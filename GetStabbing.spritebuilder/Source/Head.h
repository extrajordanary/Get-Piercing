//
//  Head.h
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@class Piercing;

@interface Head : CCSprite

@property (nonatomic, strong) Piercing *leftUpperEarPiercing;
@property (nonatomic, strong) Piercing *rightUpperEarPiercing;
@property (nonatomic, strong) Piercing *leftLowerEarPiercing;
@property (nonatomic, strong) Piercing *rightLowerEarPiercing;
@property (nonatomic, strong) Piercing *leftEyebrowPiercing;
@property (nonatomic, strong) Piercing *rightEyebrowPiercing;
@property (nonatomic, strong) Piercing *leftNostrilPiercing;
@property (nonatomic, strong) Piercing *rightNostrilPiercing;
@property (nonatomic, strong) Piercing *labretPiercing;

@property (nonatomic, strong) NSMutableArray *piercings;

@end