//
//  GameOverScene.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameOverScene.h"

#import "GameState.h"

@implementation GameOverScene
{
    CCLabelTTF *_scoreText;
}

- (void)didLoadFromCCB
{
    _scoreText.string = [NSString stringWithFormat:@"%i", [GameState sharedInstance].latestScore];
}

- (void)startOver
{
    CCScene *scene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:scene];
}

@end