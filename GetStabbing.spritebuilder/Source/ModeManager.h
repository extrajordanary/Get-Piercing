//
//  ModeManager.h
//  GetStabbing
//
//  Created by Harlan Kellaway on 2/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GPMode)
{
    GPModeEasy,
    GPModeDefault,
    GPModeHard
};

@interface ModeManager : NSObject

@property (nonatomic, assign, readonly) GPMode mode;

- initWithMode:(GPMode)mode;

@end
