//
//  GameplayScene.m
//  GetStabbing
//
//  Created by Jordan on 11/1/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "GameplayScene.h"

#import "Constants.h"
#import "GameState.h"
#import "Head.h"

@implementation GameplayScene
{
    CCNode *_conveyorNode;
    
    NSMutableArray *_heads;
    float _conveyorSpeed;
    
    int _score;
    CCLabelTTF *_scoreText;
    
    // strikes
    int _numStrikes;
    CCSprite *_strike1;
    CCSprite *_strike2;
    CCSprite *_strike3;
    NSMutableArray *_strikes;
}

- (void)didLoadFromCCB
{
    _heads = [NSMutableArray arrayWithCapacity:MAX_NUM_HEADS];
    _conveyorSpeed = STARTING_CONVEYOR_SPEED;

    // initialize heads
    for(int i = 0; i < MAX_NUM_HEADS; i++)
    {
        Head *head = (Head *)[CCBReader load:@"Head"];
        
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
    
    _strikes = [[NSMutableArray alloc] init];
    [_strikes addObject:_strike1];
    [_strikes addObject:_strike2];
    [_strikes addObject:_strike3];
}

- (void)update:(CCTime)delta
{
    for(int i = 0; i < MAX_NUM_HEADS; i++)
    {
        Head *currentHead = _heads[i];
        
        currentHead.position = ccp(currentHead.position.x + _conveyorSpeed, currentHead.position.y);
        
        // head is about to exit screen
        if([self isAtEndOfConveyor:currentHead])
        {
            // check all piercings were completed
            if(currentHead.allTargetsHit)
            {
                _score += 1;
                
                _scoreText.string = [NSString stringWithFormat:@"%i", _score];
                
            }
            else
            {
                _numStrikes += 1;
                
                CCSprite *strike = (CCSprite *)[_strikes objectAtIndex:_numStrikes-1];
                
                strike.visible = YES;
            }
            
            if(_numStrikes == MAX_NUM_STRIKES)
            {
                [self gameOver];
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
{// set score
    int score = [GameState sharedInstance].score + _score;
    if(score < 0) { score = 0; }
    [GameState sharedInstance].score = score;
    
    // check if high score
    if(score > [GameState sharedInstance].highScore)
    {
        [GameState sharedInstance].highScore = score;
    }
    
    // reset global values
    [[GameState sharedInstance] reset];
    
    // display GameOver
    CCTransition *gameOverTransition = [CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0];
    
    CCScene *scene = [CCBReader loadAsScene:@"GameOverScene"];
    [[CCDirector sharedDirector] replaceScene:scene withTransition:gameOverTransition];
}

- (void)restart
{
    
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
