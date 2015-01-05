//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

#import "AudioManager.h"

@implementation MainScene

-(void)didLoadFromCCB
{
    // start soundtrack
    [[AudioManager sharedInstance] playSoundtrack];
}

-(void)play
{
    // transition to GameplayScene
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GameplayScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
