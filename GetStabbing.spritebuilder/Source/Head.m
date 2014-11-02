//
//  Head.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Head.h"

@implementation Head

- (void)didLoadFromCCB
{
    // add piercings
    [_piercings addObject:_leftUpperEarPiercing];
    [_piercings addObject:_rightUpperEarPiercing];
    [_piercings addObject:_leftLowerEarPiercing];
    [_piercings addObject:_rightLowerEarPiercing];
    [_piercings addObject:_leftEyebrowPiercing];
    [_piercings addObject:_rightEyebrowPiercing];
    [_piercings addObject:_leftNostrilPiercing];
    [_piercings addObject:_rightNostrilPiercing];
    [_piercings addObject:_labretPiercing];
}

@end
