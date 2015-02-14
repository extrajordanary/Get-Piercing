//
//  GameplayScene.m
//  GetStabbing
//
//  Created by Jordan on 11/1/14.
//  Copyright 2014 Harlan Kellaway. All rights reserved.
//

#import "GameplayScene.h"

#import "AudioManager.h"
#import "Blood.h"
#import "Head.h"
#import "Target.h"
#import <GameCenterManager/GameCenterManager.h>

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
int const kMaxNumStrikes = 3;

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
    int _numStrikes;
    CCLabelBMFont *_strike1;
    CCLabelBMFont *_strike2;
    CCLabelBMFont *_strike3;
    NSMutableArray *_strikes;
    
    // stats
    int _numPierced;
    int _numMisses;
}

- (void)didLoadFromCCB
{
    _heads = [NSMutableArray arrayWithCapacity:kMaxNumHeads];
    _conveyorSpeed = kStartingConveyorSpeed;
    _originalNeedlePosition = _needle.positionInPoints;
    
    // initialize heads
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
    
    // set up strikes
    _numStrikes = 0;
    
    _strike1.visible = NO;
    _strike2.visible = NO;
    _strike3.visible = NO;
    
    isPaused = NO;
    _pauseOverlay.visible = NO;
    _playButton.visible = NO;
    _gameOverScene = (CCScene*)[CCBReader load:@"GameOverScene" owner:self];
    
    _strikes = [[NSMutableArray alloc] init];
    [_strikes addObject:_strike1];
    [_strikes addObject:_strike2];
    [_strikes addObject:_strike3];
}

- (void)setScore:(int)score
{
    _score = score;
    _scoreText.string = [NSString stringWithFormat:@"%i", score];
}

- (void)update:(CCTime)delta
{
    for(int i = 0; i < kMaxNumHeads; i++)
    {
        Head *currentHead = _heads[i];
        
        currentHead.position = ccp(currentHead.position.x + _conveyorSpeed, currentHead.position.y);
        
        if(currentHead.allPiercingsMade)
        {
            currentHead.isSmiling = YES;

            if(!currentHead.isScoreTallied)
            {
                [self setScore:_score + kScorePerHead];
                _numPierced++;
                
                currentHead.isScoreTallied = YES;
            }
        }
        
        // head is about to exit screen
        if([self isAtEndOfConveyor:currentHead])
        {
            // check all piercings were completed
            if(!currentHead.allPiercingsMade)
            {
                _numStrikes += 1;
                
                CCSprite *strike = (CCSprite *)[_strikes objectAtIndex:_numStrikes-1];
                
                strike.visible = YES;
                
                if(_numStrikes == kMaxNumStrikes)
                {
                    [self gameOver];
                }
            }
            
            // move to head of line
            CGFloat newX = currentHead.position.x - (kMaxNumHeads * (currentHead.contentSizeInPoints.width + kSpaceBetweenHeads));
            currentHead.position = ccp(newX, currentHead.position.y);
            
            // reset
            [currentHead reset];
            
            // speed up conveyor up to max
            if(_conveyorSpeed < kMaxConveyorSpeed) { _conveyorSpeed += kConveyorSpeedIncrease; }
        }
    }
}

- (void)gameOver
{
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"gamePaused"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self submitHighScore];
    [self submitMostPierced];
    [self submitMostMisses];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_score] forKey:@"GP_LATEST_SCORE_KEY"];
    
    // display GameOver    
    CCScene *scene = [CCBReader loadAsScene:@"GameOverScene"];
    [[CCDirector sharedDirector] replaceScene:scene];
}

#pragma mark - Pause
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
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"gamePaused"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[CCDirector sharedDirector] pause];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"gamePaused"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[CCDirector sharedDirector] resume];
    }
    
}

#pragma mark - HeadDelegate methods

- (void)headTouchedAtPoint:(CGPoint)point andWasOnTarget:(BOOL)onTarget
{
    CGPoint adjustedPoint = CGPointMake(point.x + _conveyorSpeed, point.y);
    
    // move needle to touch point, accounting for conveyer speed
    _needle.positionInPoints = adjustedPoint;
    
    if(!onTarget)
    {
        _numMisses++;
        
        // play miss sound effect
        [[AudioManager sharedInstance] playMiss];
        
        // add blood to screen
        Blood *blood = (Blood *)[CCBReader load:@"Blood"];
        [self addChild:blood];
    }
    else
    {
        // play hit sound effect
        [[AudioManager sharedInstance] playHit];
    }
}

#pragma mark - Helper methods

- (BOOL)isAtEndOfConveyor:(Head *)head
{
    if((!head.atEnd) && ((head.position.x) > (_conveyorNode.contentSizeInPoints.width + (head.contentSizeInPoints.width))))
    {
        head.atEnd = YES;
    }
    
    return head.atEnd;
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
    // get current value
    int totalPierced = _numPierced + [[GameCenterManager sharedManager] highScoreForLeaderboard:kGameCenterMostPiercedLeaderboardID];
    
    // report to GameCenter
    [[GameCenterManager sharedManager] saveAndReportScore:totalPierced leaderboard:kGameCenterMostPiercedLeaderboardID  sortOrder:GameCenterSortOrderHighToLow];
}

- (void)submitMostMisses
{
    // get current value
    int totalMissed = _numMisses + [[GameCenterManager sharedManager] highScoreForLeaderboard:kGameCenterMostMissesLeaderboardID];
    
    // report to GameCenter
    [[GameCenterManager sharedManager] saveAndReportScore:totalMissed leaderboard:kGameCenterMostMissesLeaderboardID  sortOrder:GameCenterSortOrderHighToLow];
}

@end
