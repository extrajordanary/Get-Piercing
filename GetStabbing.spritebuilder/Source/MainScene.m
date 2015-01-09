//
//  MainScene.m
//  GetStabbing
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Harlan Kellaway. All rights reserved.
//

#import "MainScene.h"

#import "AudioManager.h"
#import "GameState.h"

@implementation MainScene
{
    CCLabelTTF *_highScoreText;
}

-(void)didLoadFromCCB
{
    _highScoreText.string = [NSString stringWithFormat:@"%i", [GameState sharedInstance].highScore];
}

-(void)play
{
    // transition to GameplayScene
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GameplayScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
