//
//  Head.h
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@class Target;

@interface Head : CCSprite

@property (nonatomic, strong) Target *labret;
@property (nonatomic, strong) Target *leftEyebrow;
@property (nonatomic, strong) Target *leftNose;
@property (nonatomic, strong) Target *lowerLeftEar;
@property (nonatomic, strong) Target *lowerRightEar;
@property (nonatomic, strong) Target *rightEyebrow;
@property (nonatomic, strong) Target *rightNose;
@property (nonatomic, strong) Target *upperLeftEar;
@property (nonatomic, strong) Target *upperRightEar;

@property (nonatomic, strong) NSMutableArray *targets;
@property (nonatomic, assign) BOOL allTargetsHit;

- (void)didGetTapped:(Target *)target;

@end
