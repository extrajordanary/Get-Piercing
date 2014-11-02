//
//  Target.h
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@class Target;

@protocol TargetDelegate <NSObject>

- (void)didGetTapped:(Target *)target;

@end

@interface Target : CCSprite

@property (weak) id <TargetDelegate> delegate;
@property (nonatomic, assign) CCButton *button;
@property (nonatomic, assign) BOOL isOnHead;

@end