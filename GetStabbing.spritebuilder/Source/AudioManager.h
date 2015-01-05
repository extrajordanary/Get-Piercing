//
//  AudioManager.h
//  GetStabbing
//
//  Created by Harlan Kellaway on 1/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioManager : NSObject

+(instancetype)sharedInstance;

- (void)playSoundtrack;

@end
