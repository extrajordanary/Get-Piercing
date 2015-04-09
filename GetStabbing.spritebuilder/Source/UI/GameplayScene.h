//
//  GameplayScene.h
//  GetStabbing
//
//  Created by Jordan on 11/1/14.
//  Copyright 2014 Harlan Kellaway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Head.h"

@class ModeManager;

@interface GameplayScene : CCNode <HeadDelegate>

@property (nonatomic, strong) ModeManager *modeManager;

@end
