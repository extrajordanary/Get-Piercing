//
//  GameOverScene.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameOverScene.h"

@implementation GameOverScene

- (void)startOver
{
    CCScene *scene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:scene];
}

@end