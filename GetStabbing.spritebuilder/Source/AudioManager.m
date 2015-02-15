//
//  AudioManager.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 1/4/15.
//  Copyright (c) 2015 Harlan Kellaway. All rights reserved.
//

#import "AudioManager.h"

NSString *const kSoundtrackFilename = @"Published-iOS/sounds/soundtrack.caf";
NSString *const kHitSFX = @"Published-iOS/sounds/hit.caf";
NSString *const kMissSFX = @"Published-iOS/sounds/miss2.caf";

@implementation AudioManager
{
    OALSimpleAudio *_audio;
}

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
        _audio = [OALSimpleAudio sharedInstance];
    }
    
    return self;
}

- (void)preloadSounds
{
    [_audio preloadEffect:kHitSFX];
    [_audio preloadEffect:kMissSFX];
}

- (void)playSoundtrack
{
    [_audio playBg:kSoundtrackFilename volume:1.0 pan:0.5 loop:TRUE];
}

- (void)playHit
{
    [_audio playEffect:kHitSFX];
}

- (void)playMiss
{
    [_audio playEffect:kMissSFX];
}

@end
