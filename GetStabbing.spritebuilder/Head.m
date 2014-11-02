//
//  Head.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Head.h"

#import "Target.h"

@implementation Head
{
    CCNode *_leftEar;
    CCNode *_rightEar;
    CCNode *_head;
}

- (void)didLoadFromCCBB
{
    // add targets to array
    [self.targets addObject:self.labret];
    [self.targets addObject:self.leftEyebrow];
    [self.targets addObject:self.leftNose];
    [self.targets addObject:self.lowerLeftEar];
    [self.targets addObject:self.lowerRightEar];
    [self.targets addObject:self.rightEyebrow];
    [self.targets addObject:self.rightNose];
    [self.targets addObject:self.upperLeftEar];
    [self.targets addObject:self.upperRightEar];
    
    self.atEnd = NO;
}

@end