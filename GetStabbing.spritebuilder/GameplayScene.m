//
//  GameplayScene.m
//  GetStabbing
//
//  Created by Jordan on 11/1/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "GameplayScene.h"

#import "Blood.h"
#import "Constants.h"
#import "GameState.h"
#import "Head.h"
#import "Target.h"

@implementation GameplayScene
{
    CCNode *_conveyorNode;
    CCNode *_pauseOverlay;
    
    NSMutableArray *_heads;
    float _conveyorSpeed;
    
    CCSprite *_needle;
    CGPoint _originalNeedlePosition;
    
    int _score;
    CCLabelTTF *_scoreText;
    
    // strikes
    int _numStrikes;
    CCLabelBMFont *_strike1;
    CCLabelBMFont *_strike2;
    CCLabelBMFont *_strike3;
    NSMutableArray *_strikes;
    
    BOOL isPaused;
}

- (void)didLoadFromCCB
{
    _heads = [NSMutableArray arrayWithCapacity:MAX_NUM_HEADS];
    _conveyorSpeed = STARTING_CONVEYOR_SPEED;
    _originalNeedlePosition = _needle.positionInPoints;
    
    // initialize heads
    for(int i = 0; i < MAX_NUM_HEADS; i++)
    {
        Head *head = (Head *)[CCBReader load:@"Head"];
        head.delegate = self;
        
        [_heads addObject:head];
        
        // add to conveyor
        [_conveyorNode addChild:head];
        
        // set initial head position
        CGFloat width = head.contentSize.width;
        CGFloat xPos = ((i*(width + SPACE_BETWEEN_HEADS)) + width/2) - (_conveyorNode.contentSize.width * 1.5);
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
    for(int i = 0; i < MAX_NUM_HEADS; i++)
    {
        Head *currentHead = _heads[i];
        
        currentHead.position = ccp(currentHead.position.x + _conveyorSpeed, currentHead.position.y);
        
        if(currentHead.allPiercingsMade)
        {
            currentHead.isSmiling = YES;

            if(!currentHead.isScoreTallied)
            {
                [self setScore:_score + SCORE_PER_HEAD];
                
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
                
                if(_numStrikes == MAX_NUM_STRIKES)
                {
                    [self gameOver];
                }
            }
            
            // move to head of line
            CGFloat newX = currentHead.position.x - (MAX_NUM_HEADS * (currentHead.contentSizeInPoints.width + SPACE_BETWEEN_HEADS));
            currentHead.position = ccp(newX, currentHead.position.y);
            
            // reset
            [currentHead reset];
            
            // speed up conveyor up to max
            if(_conveyorSpeed < MAX_CONVEYOR_SPEED) { _conveyorSpeed += CONVEYOR_SPEED_INCREASE; }
        }
    }
}

- (void)gameOver
{
    // check if high score
    if(_score > [GameState sharedInstance].highScore)
    {
        [GameState sharedInstance].highScore = _score;
    }
    
    // display GameOver    
    CCScene *scene = [CCBReader loadAsScene:@"GameOverScene"];
    [[CCDirector sharedDirector] replaceScene:scene];
}

- (void)restart
{
    
}

#pragma mark - Pause
-(void)togglePause
{
    isPaused = !isPaused;
    _pauseOverlay.visible = isPaused;
    
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
        [[CCDirector sharedDirector] pause];
        
    }
    else
    {
        [[CCDirector sharedDirector] resume];
    }
    
}

#pragma mark - HeadDelegate methods

- (void)headTouchedAtPoint:(CGPoint)point andWasOnTarget:(BOOL)onTarget
{
    //NSLog(@"Needle start position: (%f, %f)", _needle.positionInPoints.x, _needle.positionInPoints.y);
    //NSLog(@"Position to move to: (%f, %f)", point.x, point.y);
    
    // move needle to touch point
    _needle.positionInPoints = point;
    
    //NSLog(@"Needle potition after move: (%f, %f)", _needle.positionInPoints.x, _needle.positionInPoints.y);
    
    if(!onTarget)
    {
        // add blood to screen
        Blood *blood = (Blood *)[CCBReader load:@"Blood"];
        [self addChild:blood];
    }
}

#pragma mark - Helper methods

- (BOOL)isAtEndOfConveyor:(Head *)head
{
    if((!head.atEnd) && ((head.position.x) > (_conveyorNode.contentSizeInPoints.width + (head.contentSizeInPoints.width/2))))
    {
        head.atEnd = YES;
    }
    
    return head.atEnd;
}

@end
