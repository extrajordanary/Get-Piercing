//
//  GameOverScene.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/2/14.
//  Copyright (c) 2014 Harlan Kellaway. All rights reserved.
//

#import "GameOverScene.h"

@implementation GameOverScene
{
    CCLabelTTF *_scoreText;
}

- (void)didLoadFromCCB
{
    _scoreText.string = [NSString stringWithFormat:@"%i", [[[NSUserDefaults standardUserDefaults] objectForKey:@"GP_LATEST_SCORE_KEY"] intValue]];
}

- (void)startOver
{
    CCScene *scene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:scene];
}

@end