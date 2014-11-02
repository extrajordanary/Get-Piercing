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
    self.isOnHead = NO;
    
    self.userInteractionEnabled = YES;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"Touch occured!");
    
    self.isOnHead = YES;
    
    // set image
    
    Head *parent = (Head*)self.parent.parent;
    [parent targetTouched:self];
}

@end