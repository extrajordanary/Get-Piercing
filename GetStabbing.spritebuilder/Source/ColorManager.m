//
//  ColorManager.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 2/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ColorManager.h"

@implementation ColorManager
{
    NSMutableArray *_generalColors;
    NSMutableArray *_skinColors;
}

#pragma mark - Initializers

+(instancetype)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (instancetype)init
{
    self = [super init];
    
    if(self)
    {
        [self setupColors];
    }
    
    return self;
}

#pragma mark - Public methods

- (CCColor *)randomGeneralColor
{
    int randomNumber = [self randomNumberUpTo:[_generalColors count]];
    return [_generalColors objectAtIndex:randomNumber];
}

- (CCColor *)randomSkinColor
{
    int randomNumber = [self randomNumberUpTo:[_skinColors count]];
    return [_skinColors objectAtIndex:randomNumber];
}

#pragma mark - Helper methods

- (void)setupColors
{
    _generalColors = [NSMutableArray array];
    _skinColors = [NSMutableArray array];
    
    [_generalColors addObject:[CCColor colorWithUIColor:[UIColor colorWithRed:0.940 green:1.000 blue:0.197 alpha:1.000]]];
    [_generalColors addObject:[CCColor colorWithUIColor:[UIColor colorWithRed:1.000 green:0.384 blue:0.234 alpha:1.000]]];
    [_generalColors addObject:[CCColor colorWithUIColor:[UIColor colorWithRed:1.000 green:0.195 blue:0.981 alpha:1.000]]];
    [_generalColors addObject: [CCColor colorWithUIColor:[UIColor colorWithRed:0.417 green:0.217 blue:0.846 alpha:1.000]]];
    [_generalColors addObject:[CCColor colorWithUIColor:[UIColor colorWithRed:0.197 green:0.658 blue:1.000 alpha:1.000]]];
    [_generalColors addObject:[CCColor colorWithUIColor:[UIColor colorWithRed:0.193 green:1.000 blue:0.258 alpha:1.000]]];
    
    [_skinColors addObject:[CCColor colorWithUIColor:[UIColor colorWithRed:0.849 green:1.000 blue:0.852 alpha:1.000]]];
    [_skinColors addObject:[CCColor colorWithUIColor:[UIColor colorWithRed:1.000 green:0.889 blue:0.929 alpha:1.000]]];
    [_skinColors addObject:[CCColor colorWithUIColor:[UIColor colorWithRed:1.000 green:0.930 blue:0.936 alpha:1.000]]];
    [_skinColors addObject:[CCColor colorWithUIColor:[UIColor colorWithRed:0.846 green:0.753 blue:0.663 alpha:1.000]]];
    [_skinColors addObject:[CCColor colorWithUIColor:[UIColor colorWithRed:0.545 green:0.415 blue:0.372 alpha:1.000]]];
    [_skinColors addObject:[CCColor colorWithUIColor:[UIColor colorWithRed:1.000 green:0.928 blue:0.748 alpha:1.000]]];
}

- (int)randomNumberUpTo:(int)cutoff
{
    return arc4random_uniform(cutoff);
}

@end
