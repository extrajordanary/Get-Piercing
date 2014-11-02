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
    CCNode *_contentNode;
    
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

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:_contentNode];
    
//    // start catapult dragging when a touch inside of the catapult arm occurs
//    if (CGRectContainsPoint([_catapultArm boundingBox], touchLocation))
//    {
//        // move the mouseJointNode to the touch position
//        _mouseJointNode.position = touchLocation;
//        
//        // setup a spring joint between the mouseJointNode and the catapultArm
//        _mouseJoint = [CCPhysicsJoint connectedSpringJointWithBodyA:_mouseJointNode.physicsBody bodyB:_catapultArm.physicsBody anchorA:ccp(0, 0) anchorB:ccp(34, 138) restLength:0.f stiffness:3000.f damping:150.f];
//    }
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
