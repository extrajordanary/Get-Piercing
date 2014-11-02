//
//  Target.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Target.h"

@implementation Target

- (void)didLoadFromCCB
{
    self.isOnHead = NO;
}

- (void)didGetTapped:(Target *)target
{
    [self.delegate didGetTapped:self];
}

@end