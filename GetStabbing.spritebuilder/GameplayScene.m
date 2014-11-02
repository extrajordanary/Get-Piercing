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
    NSMutableArray *_heads;
    int _converyorSpeed;
}

- (void)didLoadFromCCB
{
    _heads = [NSMutableArray arrayWithCapacity:NUM_HEADS];
    _converyorSpeed = 0.5;
    
    // initialize heads
    for(int i = 0; i < NUM_HEADS; i++)
    {
        Head *head = (Head *)[CCBReader load:@"Head"];
        
        [_heads addObject:head];
    }
}

- (void)update:(CCTime)delta
{
    for(int i = 0; i < NUM_HEADS; i++)
    {
        Head *currentHead = _heads[i];
        
        currentHead.position = ccp(currentHead.position.x, currentHead.position.y - _converyorSpeed);
        
        // head is about to exit screen
        if([self isAtEndOfConveyor:currentHead])
        {
            // check all piercings were completed
            
        }
    }
}

#pragma mark - Helper methods

- (BOOL)isAtEndOfConveyor:(Head *)head
{
    return NO;
}

@end
