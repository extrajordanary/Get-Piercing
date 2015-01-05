//
//  GameState.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/2/14.
//  Copyright (c) 2014 Harlan Kellaway. All rights reserved.
//

#import "GameState.h"

static NSString *const GAME_STATE_LATEST_SCORE_KEY = @"GameStateLatestScoreKey";
static NSString *const GAME_STATE_HIGH_SCORE_KEY = @"GameStateHighScoreKey";

@implementation GameState

+(instancetype)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (instancetype)init
{
    self = [super init];
    
    if(self)
    {
        // high score
        NSString *currentHighScore = [[NSUserDefaults standardUserDefaults]objectForKey:GAME_STATE_HIGH_SCORE_KEY];
        
        // if no high score recorded
        if(currentHighScore == nil)
        {
            [self setHighScore:0];
        }
        
        NSString *latestScore = [[NSUserDefaults standardUserDefaults]objectForKey:GAME_STATE_LATEST_SCORE_KEY];
        
        // if no latest score recorded
        if(latestScore == nil)
        {
            [self setLatestScore:0];
        }
        
        // save defaults
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    
    return self;
}

# pragma mark - Setter overides

- (void)setLatestScore:(NSInteger)latestScore
{
    _latestScore = latestScore;
    
    NSNumber *latestScoreNSNumber = [NSNumber numberWithInteger:latestScore];
    
    // store change
    [[NSUserDefaults standardUserDefaults] setObject:latestScoreNSNumber forKey:GAME_STATE_LATEST_SCORE_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)setHighScore:(NSInteger)highScore
{
    _highScore = highScore;
    
    NSNumber *highScoreNSNumber = [NSNumber numberWithInteger:highScore];
    
    // store change
    [[NSUserDefaults standardUserDefaults] setObject:highScoreNSNumber forKey:GAME_STATE_HIGH_SCORE_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
