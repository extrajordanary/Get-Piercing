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
    
    float _conveyorSpeed;
    NSMutableArray *_heads;
    int _headSpacing;
    
    int _numCorrectPiercings;
}

- (void)didLoadFromCCB
{
    _heads = [NSMutableArray arrayWithCapacity:MAX_NUM_HEADS];
    _conveyorSpeed = 0.01;
    _numCorrectPiercings = 0;
    _headSpacing = 100;
    
    // initialize heads
    for(int i = 0; i < MAX_NUM_HEADS; i++)
    {
        Head *head = (Head *)[CCBReader load:@"Head"];
        
        [_heads addObject:head];
        [_conveyorNode addChild:head];
        
        CGFloat width = head.contentSize.width;
        CGFloat yPos = ((_conveyorNode.contentSize.height));
        
        head.position = ccp((i*(width + _headSpacing)) + width/2, yPos);
        
        NSLog(@"head.position = %f %f)", head.position.x, head.position.y);
    }
}

- (void)update:(CCTime)delta
{
    for(int i = 0; i < MAX_NUM_HEADS; i++)
    {
        Head *currentHead = _heads[i];
        
//        _testHead.position = ccp(_testHead.position.x + _converyorSpeed, _testHead.position.y);
        
        // head is about to exit screen
        if([self isAtEndOfConveyor:currentHead])
        {
            // check all piercings were completed
            
        }
    }
    
//    _testHead.position = ccp(_testHead.position.x - _converyorSpeed, _testHead.position.y);
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
    CCTransition *gameOverTransition = [CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.5];
    
    CCScene *scene = [CCBReader loadAsScene:@"GameOverScene"];
    [[CCDirector sharedDirector] replaceScene:scene withTransition:gameOverTransition];
}

- (void)restart
{
    
}

#pragma mark - Helper methods

- (BOOL)isAtEndOfConveyor:(Head *)head
{
    if(head.allTargetsHit)
    {
        return YES;
    }
    
    return NO;
}

@end