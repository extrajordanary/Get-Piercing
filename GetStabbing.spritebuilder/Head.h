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

@property (nonatomic, assign) BOOL atEnd;

// for modularizational magic
//@property (nonatomic, strong) CCSprite *neckSprite;
//@property (nonatomic, strong) CCSprite *shirtSprite;
//
//@property (nonatomic, strong) CCSprite *rightEyeSprite;
//@property (nonatomic, strong) CCSprite *leftEyeSprite;
//
//@property (nonatomic, strong) CCSprite *rightEar1Sprite;
//@property (nonatomic, strong) CCSprite *rightEar2Sprite;
//
//@property (nonatomic, strong) CCSprite *leftEar1Sprite;
//@property (nonatomic, strong) CCSprite *leftEar2Sprite;
//
//@property (nonatomic, strong) CCSprite *head1Sprite;
//@property (nonatomic, strong) CCSprite *head2Sprite;
//
//@property (nonatomic, strong) CCSprite *nose1Sprite;
//// 2nd nose
//
//@property (nonatomic, strong) CCSprite *mouth1Sprite;
//// 2nd mouth
//
//@property (nonatomic, strong) CCSprite *hair1Sprite;
//@property (nonatomic, strong) CCSprite *hair2Sprite;

-(void)modularMagic;

@end