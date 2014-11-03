//
//  Head.h
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "Target.h"

@interface Head : CCSprite <TargetDelegate>

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
@property (nonatomic, strong) NSMutableArray *piercings;

@property (nonatomic, assign) int numPiercingsNeeded;
@property (nonatomic, assign) int numPiercingsMade;
@property (nonatomic, assign) BOOL allPiercingsMade;
@property (nonatomic, assign) BOOL isScoreTallied;

@property (nonatomic, assign) BOOL isSmiling;
@property (nonatomic, assign) BOOL atEnd;

-(void)generateAppearance;
- (void)reset;


@end