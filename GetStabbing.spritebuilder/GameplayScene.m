//
//  GameplayScene.m
//  GetStabbing
//
//  Created by Jordan on 11/1/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "GameplayScene.h"

#import "Constants.h"
#import "Head.h"

@implementation GameplayScene
{
    CCNode *_conveyorNode;
    
    NSMutableArray *_heads;
    float _conveyorSpeed;
    
    int _numCorrectPiercings;
}

- (void)didLoadFromCCB
{
    _heads = [NSMutableArray arrayWithCapacity:MAX_NUM_HEADS];
    _conveyorSpeed = STARTING_CONVEYOR_SPEED;
    _numCorrectPiercings = 0;
    
    // initialize heads
    for(int i = 0; i < MAX_NUM_HEADS; i++)
    {
        Head *head = (Head *)[CCBReader load:@"Head"];
        
        [_heads addObject:head];
        [_conveyorNode addChild:head];
        
        // set head position
        CGFloat width = head.contentSize.width;
        CGFloat yPos = ((_conveyorNode.contentSize.height));
        head.position = ccp((i*(width + SPACE_BETWEEN_HEADS)) + width/2, yPos);
    }
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
            
            // move to head of line
            CGFloat newX = currentHead.position.x - (MAX_NUM_HEADS * (currentHead.contentSizeInPoints.width + SPACE_BETWEEN_HEADS));
            
            NSLog(@"currentHead.newX = %f", newX);
                
            currentHead.position = ccp(newX, currentHead.position.y);
            currentHead.atEnd = NO;
        }
    }
}

- (void)gameOver
{
//    // set score
//    int score = [GameState sharedInstance].score + _numCorrectPiercings;
//    if(score < 0) { score = 0; }
//    [GameState sharedInstance].score = score;
//    
//    // check if high score
//    if(score > [GameState sharedInstance].highScore)
//    {
//        [GameState sharedInstance].highScore = score;
//    }
    
//    // reset global values
//    [[GameState sharedInstance] clearGameState];
    
    // load GameOver scene
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
    if((!head.atEnd) && ((head.position.x) > (_conveyorNode.contentSizeInPoints.width + (head.contentSizeInPoints.width))))
    {
        head.atEnd = YES;
        
        return YES;
    }
    
    return NO;
}

@end