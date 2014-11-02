//
//  Target.h
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Target : CCSprite

@property (nonatomic, assign) BOOL isOnHead;
@property (nonatomic, strong) CCSprite *piercing;

@end