//
//  Head.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Harlan Kellaway. All rights reserved.
//

#import "Head.h"

#import "ColorManager.h"
#import "Target.h"

NSString *const kBlinkAnimationName = @"blink";
NSString *const kFrownAnimationName = @"frown";

@implementation Head
{
    // body parts
    CCSprite *_smile;
    CCSprite *_neckSprite;
    
    CCSprite *_rightEyeSprite;
    CCSprite *_leftEyeSprite;
    
    CCSprite *_rightEar1Sprite;
    CCSprite *_rightEar2Sprite;
    
    CCSprite *_leftEar1Sprite;
    CCSprite *_leftEar2Sprite;
    
    CCSprite *_head1Sprite;
    CCSprite *_head2Sprite;
    
    CCSprite *_nose1Sprite;
    CCSprite *_nose2Sprite;
    
    CCSprite *_mouth1Sprite;
    CCSprite *_mouth2Sprite;
    
    // non body parts
    CCSprite *_shirtSprite;
    
    CCSprite *_hair1Sprite;
    CCSprite *_hair2Sprite;
    
    // piercings
    CCSprite *_labretP;
    CCSprite *_lowerLeftEarP;
    CCSprite *_lowerRightEarP;
    CCSprite *_upperLeftEarP;
    CCSprite *_upperRightEarP;
    CCSprite *_leftEyebrowP;
    CCSprite *_rightEyebrowP;
    CCSprite *_leftNoseP;
    CCSprite *_rightNoseP;
}

#pragma mark - Initializers

- (void)didLoadFromCCB
{
    [self setupTargetsWithPiercings];
    [self reset];
}

#pragma mark Getters

- (BOOL)isSmiling
{
    return _smile.visible;
}

#pragma mark Setters

- (void)setIsSmiling:(BOOL)isSmiling
{
    _smile.visible = isSmiling;
}

#pragma mark - Touch

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    if(!self.allPiercingsMade)
    {
        [self frown];
        [self.delegate headTouchedAtPoint:touch.locationInWorld andWasOnTarget:NO];
    }
}

#pragma mark - TargetDelegate methods

-(void)targetTouched:(Target *)target atPoint:(CGPoint)point
{
    if (target.visible)
    {
        target.piercing.visible = YES;
        target.visible = NO;
        
        self.numPiercingsMade++;
    }
    
    if (self.numPiercingsMade >= self.numPiercingsNeeded)
    {
        self.allPiercingsMade = YES;
        
        [self setIsSmiling:YES];
    }
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int screenHeight = (int)screenRect.size.height;
    
    CGPoint targetPoint = [target convertToWorldSpace:target.position];
    targetPoint = CGPointMake(targetPoint.x, screenHeight - targetPoint.y);
    
    // tell delegate touch occurred
    [self.delegate headTouchedAtPoint:point andWasOnTarget:YES];
}

#pragma mark - Helper methods

- (void)setupTargetsWithPiercings
{
    self.targets = [NSMutableArray array];
    
    [self setupTarget:self.labret withPiercing:_labretP];
    [self setupTarget:self.leftEyebrow withPiercing:_leftEyebrowP];
    [self setupTarget:self.rightEyebrow withPiercing:_rightEyebrowP];
    [self setupTarget:self.leftNose withPiercing:_leftNoseP];
    [self setupTarget:self.rightNose withPiercing:_rightNoseP];
    [self setupTarget:self.lowerLeftEar withPiercing:_lowerLeftEarP];
    [self setupTarget:self.lowerRightEar withPiercing:_lowerRightEarP];
    [self setupTarget:self.upperLeftEar withPiercing:_upperLeftEarP];
    [self setupTarget:self.upperRightEar withPiercing:_upperRightEarP];
}

- (void)setupTarget:(Target *)target withPiercing:(CCSprite *)piercing
{
    target.piercing = piercing;
    target.delegate = self;
    [self.targets addObject:target];
}

-(void)generateAppearance
{
    [self setAllPartsInvisible]; // we'll only make randomly selected parts visible
    
    CCColor *skinColor = [[ColorManager sharedInstance] randomSkinColor];
    CCColor *eyeColor = [[ColorManager sharedInstance] randomGeneralColor];
    
    NSMutableArray *bodyParts = [self randomBodyParts];
    for (CCSprite *sprite in bodyParts)
    {
        [self turnOnSprite:sprite withColor:skinColor];
    }
    
    NSMutableArray *nonBodyParts = [self randomNonBodyParts];
    for (CCSprite *sprite in nonBodyParts)
    {
        [self turnOnSprite:sprite withColor:[[ColorManager sharedInstance] randomGeneralColor]];
    }
    
    [self addRandomMouth];
    [self addRandomNose];
    [self colorEyes:eyeColor];
}

- (void)setAllPartsInvisible
{
    _rightEar1Sprite.visible = NO;
    _rightEar2Sprite.visible = NO;
    _leftEar1Sprite.visible = NO;
    _leftEar2Sprite.visible = NO;
    
    _head1Sprite.visible = NO;
    _head2Sprite.visible = NO;
    
    _nose1Sprite.visible = NO;
    _nose2Sprite.visible = NO;
    
    _mouth1Sprite.visible = NO;
    _mouth2Sprite.visible = NO;
    
    _hair1Sprite.visible = NO;
    _hair2Sprite.visible = NO;
}

- (NSMutableArray *)randomBodyParts
{
    NSMutableArray *bodyParts = [NSMutableArray array];
    
    [bodyParts addObject:_neckSprite];
    [self addRandomEarsToBodyParts:bodyParts];
    [self addRandomHeadToBodyParts:bodyParts];
    
    return bodyParts;
}

- (void)addRandomEarsToBodyParts:(NSMutableArray *)bodyParts
{
    if ([self coinFlip])
    {
        [bodyParts addObject:_rightEar1Sprite];
        [bodyParts addObject:_leftEar1Sprite];
    }
    else
    {
        [bodyParts addObject:_rightEar2Sprite];
        [bodyParts addObject:_leftEar2Sprite];
    }
}

- (void)addRandomHeadToBodyParts:(NSMutableArray *)bodyParts
{
    if ([self coinFlip])
    {
        [bodyParts addObject:_head1Sprite];
    }
    else
    {
        [bodyParts addObject:_head2Sprite];
    }
}

- (NSMutableArray *)randomNonBodyParts
{
    NSMutableArray *nonBodyParts = [NSMutableArray array];
    
    [nonBodyParts addObject:_shirtSprite];
    [self addRandomHairToNonBodyParts:nonBodyParts];

    return nonBodyParts;
}

- (void)addRandomHairToNonBodyParts:(NSMutableArray *)nonBodyParts
{
    if ([self coinFlip])
    {
        [nonBodyParts addObject:_hair1Sprite];
    }
    else
    {
        [nonBodyParts addObject:_hair2Sprite];
    }
}

- (void)addRandomMouth
{
    if ([self coinFlip])
    {
        _mouth1Sprite.visible = YES;
    }
    else
    {
        _mouth2Sprite.visible = YES;
    }
}

- (void)colorEyes:(CCColor *)color
{
    [self turnOnSprite:_rightEyeSprite withColor:color];
    [self turnOnSprite:_leftEyeSprite withColor:color];
}

- (void)addRandomNose
{
    if ([self coinFlip])
    {
        _nose1Sprite.visible = YES;
    }
    else
    {
        _nose2Sprite.visible = YES;
    }
}

-(void)turnOnSprite:(CCSprite*)sprite withColor:(CCColor*)color
{
    sprite.visible = YES;
    sprite.color = color;
}

- (void)randomlyAssignPiercingsNeeded
{
    while(self.numPiercingsNeeded == 0)
    {
        for(Target *target in self.targets)
        {
            target.isPiercingNeeded = [self coinFlip];
            if(target.isPiercingNeeded)
            {
                self.numPiercingsNeeded++;
            }
        }
    }
}

- (void)reset
{
    self.numPiercingsMade = 0;
    self.numPiercingsNeeded = 0;
    self.isScoreTallied = NO;
    self.isStrikeTallied = NO;
    self.allPiercingsMade = NO;
    self.atEnd = NO;
    self.isSmiling = NO;
    
    [self clearTargets];
    
    [self generateAppearance];
    [self randomlyAssignPiercingsNeeded];
    [self startBlinkAnimation];
    self.userInteractionEnabled = YES;
}

- (void)clearTargets
{
    for(Target *target in self.targets)
    {
        target.isPiercingNeeded = NO;
        target.piercing.visible = NO;
    }
}

- (void)startBlinkAnimation
{
    float delay = (arc4random() % 1000) / 1000.f;
    [self performSelector:@selector(blink) withObject:nil afterDelay:delay];
}

- (void)blink
{
    [self.animationManager runAnimationsForSequenceNamed:kBlinkAnimationName];
}

- (void)frown
{
    [self.animationManager runAnimationsForSequenceNamed:kFrownAnimationName];
}

-(BOOL)coinFlip
{
    if (arc4random_uniform(2))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end