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

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self.delegate targetTouched:self];
}

- (void)reset
{
    self.isPiercingNeeded = NO;
    self.visible = NO;
}

@end