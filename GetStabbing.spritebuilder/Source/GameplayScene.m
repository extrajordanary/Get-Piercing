//
//  GameplayScene.m
//  GetStabbing
//
//  Created by Jordan on 11/1/14.
//  Copyright 2014 Harlan Kellaway. All rights reserved.
//

#import "GameplayScene.h"

#import <GameCenterManager/GameCenterManager.h>
#import "AudioManager.h"
#import "Blood.h"
#import "Constants.h"
#import "Head.h"
#import "ModeManager.h"
#import "Strike.h"
#import "Target.h"

static NSString * const kIsPausedKey = @"gamePaused";

// Game Center
static NSString * const kGameCenterMainLeaderboardID = @"GP_Main_Leaderboard";
static NSString * const kGameCenterMostPiercedLeaderboardID = @"GP_Most_Pierced_Leaderboard";
static NSString * const kGameCenterMostMissesLeaderboardID = @"GP_Most_Misses_Leaderboard";
static NSString * const kGameCenterHighScoreKey = @"GP_HIGH_SCORE_KEY";

float const kStartingConveyorSpeed = 1.5;
float const kConveyorSpeedIncrease = 0.05;
float const kMaxConveyorSpeed = 4.0;
int const kMaxNumHeads = 3;
int const kScorePerHead = 1;
int const kSpaceBetweenHeads = 100;

@implementation GameplayScene
{
    CCNode *_conveyorNode;
    CCNode *_layerNode;
    CCScene *_gameOverScene;
    
    BOOL isPaused;
    CCNode *_pauseOverlay;
    CCSprite *_playButton;
    
    NSMutableArray *_heads;
    float _conveyorSpeed;
    
    // needle
    CCSprite *_needle;
    CGPoint _originalNeedlePosition;
    
    // score
    int _score;
    CCLabelTTF *_scoreText;
    
    // strikes
    int _maxNumStrikes;
    int _numStrikes;
    NSMutableArray *_strikes;
    CCLayoutBox *_strikesBox;
    
    // stats
    int _numPierced;
    int _numMisses;
}

#pragma mark - Initializers

- (void)didLoadFromCCB
{
    [self setModeInfo]; // this should come first
    [self setupConveyor];
    [self setupHeads];
    [self setupNeedle];
    [self setupStrikes];
    
    isPaused = NO;
    _pauseOverlay.visible = NO;
    _playButton.visible = NO;
    _gameOverScene = (CCScene*)[CCBReader load:@"GameOverScene" owner:self];
}

#pragma mark Setters

- (void)setScore:(int)score
{
    _score = score;
    _scoreText.string = [NSString stringWithFormat:@"%i", score];
}

#pragma mark - Public methods

#pragma mark Update loop

- (void)update:(CCTime)delta
{
    for(Head *currentHead in _heads)
    {
        [self updatePositionForHead:currentHead];
        [self tallyPiercingsForHead:currentHead];
        
        if([self isAtEndOfConveyor:currentHead])
        {
            [self tallyStrikesForHead:currentHead];
            
            if([self isOffScreen:currentHead])
            {
                [self resetHead:currentHead];
                [self speedUpConveyor];
            }
        }
    }
}

#pragma mark HeadDelegate methods

- (void)headTouchedAtPoint:(CGPoint)point andWasOnTarget:(BOOL)onTarget
{
    [self moveNeedleToPoint:point];
    
    if(onTarget)
    {
        [self hitTarget];
    }
    else
    {
        [self missedTarget];
    }
}

#pragma mark - Helper methods

- (void)setModeInfo
{
    NSDictionary *modeInfo = [ModeManager sharedInstance].modeInfo;
    
    _maxNumStrikes = [[modeInfo objectForKey:@"NumStrikes"] intValue];
}

- (void)setupConveyor
{
    _conveyorSpeed = kStartingConveyorSpeed;
}

- (void)setupHeads
{
    _heads = [NSMutableArray arrayWithCapacity:kMaxNumHeads];
    for(int i = 0; i < kMaxNumHeads; i++)
    {
        Head *head = (Head *)[CCBReader load:@"Head"];
        head.delegate = self;
        
        [_heads addObject:head];
        
        // add to conveyor
        [_conveyorNode addChild:head];
        
        // set initial head position
        CGFloat width = head.contentSize.width;
        CGFloat xPos = ((i*(width + kSpaceBetweenHeads)) + width/2) - (_conveyorNode.contentSize.width * 1.5);
        CGFloat yPos = ((_conveyorNode.contentSize.height));
        head.position = ccp(xPos, yPos);
    }
}

- (void)setupNeedle
{
    _originalNeedlePosition = _needle.positionInPoints;
}

- (void)setupStrikes
{
    _numStrikes = 0;
    _strikes = [NSMutableArray array];
    
    for(int i = 0; i < _maxNumStrikes; i++)
    {
        Strike *strike = (Strike *)[CCBReader load:@"Strike"];
        [_strikes addObject:strike];
    }
}

- (void)updatePositionForHead:(Head *)head
{
    head.position = ccp(head.position.x + _conveyorSpeed, head.position.y);
}

- (void)tallyPiercingsForHead:(Head *)head
{
    if(head.allPiercingsMade)
    {
        head.isSmiling = YES;
        
        [self updateScoreForHead:head];
    }
}

- (void)tallyStrikesForHead:(Head *)head
{
    if(!head.isStrikeTallied && !head.allPiercingsMade)
    {
        [_strikesBox addChild:[_strikes objectAtIndex:_numStrikes]];
        _numStrikes += 1;
        
        if(_numStrikes == _maxNumStrikes)
        {
            [self gameOver];
        }
        
        head.isStrikeTallied = YES;
    }
}

- (void)resetHead:(Head *)head
{
    [self moveHeadToStart:head];
    
    [head reset];
}

- (void)moveHeadToStart:(Head *)head
{
    CGFloat newX = head.position.x - (kMaxNumHeads * (head.contentSizeInPoints.width + kSpaceBetweenHeads));
    head.position = ccp(newX, head.position.y);
}

- (void)speedUpConveyor
{
    if(_conveyorSpeed < kMaxConveyorSpeed)
    {
        _conveyorSpeed += kConveyorSpeedIncrease;
    }
}

- (void)updateScoreForHead:(Head *)head
{
    if(!head.isScoreTallied)
    {
        [self setScore:_score + kScorePerHead];
        _numPierced++;
        
        head.isScoreTallied = YES;
    }
}

- (BOOL)isAtEndOfConveyor:(Head *)head
{
    if((!head.atEnd) && ((head.position.x) > (_conveyorNode.contentSizeInPoints.width + (head.contentSizeInPoints.width/2))))
    {
        head.atEnd = YES;
    }
    
    return head.atEnd;
}

- (BOOL)isOffScreen:(Head *)head
{
    return ((head.position.x) > (_conveyorNode.contentSizeInPoints.width + (head.contentSizeInPoints.width)));
}

- (void)moveNeedleToPoint:(CGPoint)point
{
    CGPoint adjustedPoint = CGPointMake(point.x + _conveyorSpeed, point.y);
    _needle.positionInPoints = adjustedPoint;
}

- (void)hitTarget
{
    [[AudioManager sharedInstance] playHit];
}

- (void)missedTarget
{
    _numMisses++;
    
    [[AudioManager sharedInstance] playMiss];
    [self splatterBlood];
}

- (void) splatterBlood
{
    Blood *blood = (Blood *)[CCBReader load:@"Blood"];
    [self addChild:blood];
}

-(void)togglePause
{
    isPaused = !isPaused;
    _pauseOverlay.visible = isPaused;
    _playButton.visible = isPaused;
    
    for(Head *head in _heads)
    {
        head.userInteractionEnabled = !isPaused;
        
        for(Target *target in head.targets)
        {
            target.userInteractionEnabled = !isPaused;
        }
    }
    
    if(isPaused)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:kIsPausedKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[CCDirector sharedDirector] pause];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:kIsPausedKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[CCDirector sharedDirector] resume];
    }
    
}

- (void)gameOver
{
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:kIsPausedKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self submitHighScore];
    [self submitMostPierced];
    [self submitMostMisses];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_score] forKey:GPCONSTANTS_LATEST_SCORE_KEY];
    
    // display GameOver
    CCScene *scene = [CCBReader loadAsScene:@"GameOverScene"];
    [[CCDirector sharedDirector] replaceScene:scene];
}

- (void)submitHighScore
{
    // check if high score
    if(_score > [[[NSUserDefaults standardUserDefaults] objectForKey:kGameCenterHighScoreKey] integerValue])
    {
        // save high score locally
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_score] forKey:kGameCenterHighScoreKey];
        
        // report high score to GameCenter
        [[GameCenterManager sharedManager] saveAndReportScore:_score leaderboard:kGameCenterMainLeaderboardID  sortOrder:GameCenterSortOrderHighToLow];
    }
}

- (void)submitMostPierced
{
    int totalPierced = _numPierced + [[GameCenterManager sharedManager] highScoreForLeaderboard:kGameCenterMostPiercedLeaderboardID];
    
    [[GameCenterManager sharedManager] saveAndReportScore:totalPierced leaderboard:kGameCenterMostPiercedLeaderboardID  sortOrder:GameCenterSortOrderHighToLow];
}

- (void)submitMostMisses
{
    int totalMissed = _numMisses + [[GameCenterManager sharedManager] highScoreForLeaderboard:kGameCenterMostMissesLeaderboardID];

    [[GameCenterManager sharedManager] saveAndReportScore:totalMissed leaderboard:kGameCenterMostMissesLeaderboardID  sortOrder:GameCenterSortOrderHighToLow];
}

@end
