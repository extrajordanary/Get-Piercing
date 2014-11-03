//
//  Target.h
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@class Target;

@protocol TargetDelegate

-(void)targetTouched:(Target*)target;

@end

@interface Target : CCSprite

@property (weak) id <TargetDelegate> delegate;
@property (nonatomic, assign) BOOL piercingNeeded;
@property (nonatomic, strong) CCSprite *piercing;

-(void)reset;

@end