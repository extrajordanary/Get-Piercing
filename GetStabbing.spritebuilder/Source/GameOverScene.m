//
//  GameOverScene.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/2/14.
//  Copyright (c) 2014 Harlan Kellaway. All rights reserved.
//

#import "GameOverScene.h"

#import "Blood.h"

@implementation GameOverScene
{
    CCLabelTTF *_scoreText;
}

- (void)didLoadFromCCB
{
    _scoreText.string = [NSString stringWithFormat:@"%i", [[[NSUserDefaults standardUserDefaults] objectForKey:@"GP_LATEST_SCORE_KEY"] intValue]];
    
    for(int i = 0; i < 10; i++)
    {
        Blood *blood = (Blood *)[CCBReader load:@"Blood"];
        [self addChild:blood];
    }
}

- (void)startOver
{
    CCScene *scene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:scene];
}

@end