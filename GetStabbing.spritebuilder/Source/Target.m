//
//  Target.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Harlan Kellaway. All rights reserved.
//

#import "Target.h"
#import "Head.h"

@implementation Target

- (void)didLoadFromCCB
{
    self.isPiercingNeeded = NO;
    self.userInteractionEnabled = YES;
}

- (void)setIsPiercingNeeded:(BOOL)isPiercingNeeded
{
    _isPiercingNeeded = isPiercingNeeded;
    self.visible = isPiercingNeeded;
}

- (void)setPiercing:(CCSprite *)piercing
{
    _piercing = piercing;
    _piercing.visible = NO;
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CGPoint point = touch.locationInWorld;
    [self.delegate targetTouched:self atPoint:point];
}

- (void)reset
{
    self.isPiercingNeeded = NO;
    self.visible = NO;
}

@end