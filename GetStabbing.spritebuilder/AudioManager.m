//
//  AudioManager.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 1/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "AudioManager.h"

#import "Constants.h"

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
        // audio
        _audio = [OALSimpleAudio sharedInstance];
    }
    
    return self;
}

- (void)playSoundtrack
{
    [_audio playBg:AUDIO_SOUNDTRACK_FILENAME volume:1.0 pan:0.5 loop:TRUE];
}

@end
