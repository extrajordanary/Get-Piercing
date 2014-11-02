//
//  Target.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Target.h"
#import "Head.h"

@implementation Target

- (void)didLoadFromCCB
{
    self.piercingNeeded = NO;
    
    self.userInteractionEnabled = YES;
}

- (void)setPiercingNeeded:(BOOL)piercingNeeded
{
    _piercingNeeded = piercingNeeded;
    self.visible = piercingNeeded;
}

- (void)setPiercing:(CCSprite *)piercing
{
    _piercing = piercing;
    
    _piercing.visible = NO;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"Touch occured!");
    
    // set image
    Head *parent = (Head*)self.parent.parent;
    [parent targetTouched:self];
}

@end