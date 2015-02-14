//
//  ModeManager.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 2/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ModeManager.h"

#pragma mark - Initializers

@implementation ModeManager
{
    GPMode _mode;
}

- (id)initWithMode:(GPMode)mode
{
    self = [super init];
    
    if(self)
    {
        _mode = mode;
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithMode:GPModeDefault];
}

#pragma mark Getters

- (GPMode)mode
{
    return _mode;
}

#pragma mark - Public methods

- (NSDictionary *)modeInfo
{
    return [NSDictionary dictionary];
}

#pragma mark - Private methods

@end
