//
//  MainScene.m
//  GetStabbing
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Harlan Kellaway. All rights reserved.
//

#import "MainScene.h"

#import "AudioManager.h"

@implementation MainScene

-(void)didLoadFromCCB
{

}

-(void)play
{
    // transition to GameplayScene
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GameplayScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
