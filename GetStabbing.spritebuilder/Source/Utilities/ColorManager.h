//
//  ColorManager.h
//  GetStabbing
//
//  Created by Harlan Kellaway on 2/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorManager : NSObject

+ (instancetype)sharedInstance;
- (CCColor *)randomGeneralColor;
- (CCColor *)randomSkinColor;

@end
