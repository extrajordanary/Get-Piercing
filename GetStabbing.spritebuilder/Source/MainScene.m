//
//  MainScene.m
//  GetStabbing
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Harlan Kellaway. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene
{
    CCLabelTTF *_highScoreText;
}

-(void)didLoadFromCCB
{

    _highScoreText.string = [NSString stringWithFormat:@"%i", [[[NSUserDefaults standardUserDefaults] objectForKey:@"GP_HIGH_SCORE_KEY"] intValue]];
}

-(void)play
{
    // transition to GameplayScene
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GameplayScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
