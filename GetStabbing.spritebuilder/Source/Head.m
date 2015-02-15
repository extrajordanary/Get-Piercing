//
//  Head.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Harlan Kellaway. All rights reserved.
//

#import "Head.h"

#import "Target.h"

NSString *const kBlinkAnimationName = @"blink";
NSString *const kFrownAnimationName = @"frown";

@implementation Head
{
    CCSprite *_smile;
    
    CCSprite *_neckSprite;
    CCSprite *_shirtSprite;
    
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
    
    CCSprite *_hair1Sprite;
    CCSprite *_hair2Sprite;
    
    CCColor *_shirtColor;
    CCColor *_eyeColor;
    CCColor *_hairColor;
    CCColor *_skinColor;
    
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
    
    // color selection
    CCColor *skin0;
    CCColor *skin1;
    CCColor *skin2;
    CCColor *skin3;
    CCColor *skin4;
    CCColor *skin5;
    
    CCColor *color0;
    CCColor *color1;
    CCColor *color2;
    CCColor *color3;
    CCColor *color4;
    CCColor *color5;
}

#pragma mark - Initializers

- (void)didLoadFromCCB
{
    self.isScoreTallied = NO;
    self.isStrikeTallied = NO;
    self.isSmiling = NO;
    
    self.targets = [NSMutableArray array];
    [self setupTargetsWithPiercings];
    
    // skin colors
    skin0 = [CCColor colorWithUIColor:[UIColor colorWithRed:0.849 green:1.000 blue:0.852 alpha:1.000]];
    skin1 = [CCColor colorWithUIColor:[UIColor colorWithRed:1.000 green:0.889 blue:0.929 alpha:1.000]];
    skin2 = [CCColor colorWithUIColor:[UIColor colorWithRed:1.000 green:0.930 blue:0.936 alpha:1.000]];
    skin3 = [CCColor colorWithUIColor:[UIColor colorWithRed:0.846 green:0.753 blue:0.663 alpha:1.000]];
    skin4 = [CCColor colorWithUIColor:[UIColor colorWithRed:0.545 green:0.415 blue:0.372 alpha:1.000]];
    skin5 = [CCColor colorWithUIColor:[UIColor colorWithRed:1.000 green:0.928 blue:0.748 alpha:1.000]];
    
    // hair, clothes, eye colors
    color0 = [CCColor colorWithUIColor:[UIColor colorWithRed:0.940 green:1.000 blue:0.197 alpha:1.000]];
    color1 = [CCColor colorWithUIColor:[UIColor colorWithRed:1.000 green:0.384 blue:0.234 alpha:1.000]];
    color2 = [CCColor colorWithUIColor:[UIColor colorWithRed:1.000 green:0.195 blue:0.981 alpha:1.000]];
    color3 = [CCColor colorWithUIColor:[UIColor colorWithRed:0.417 green:0.217 blue:0.846 alpha:1.000]];
    color4 = [CCColor colorWithUIColor:[UIColor colorWithRed:0.197 green:0.658 blue:1.000 alpha:1.000]];
    color5 = [CCColor colorWithUIColor:[UIColor colorWithRed:0.193 green:1.000 blue:0.258 alpha:1.000]];
    
    [self reset];
    [self startBlinkAnimation];
    self.userInteractionEnabled = YES;
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

#pragma mark - Helper methods

- (void)startBlinkAnimation
{
    float delay = (arc4random() % 1000) / 1000.f;
    [self performSelector:@selector(blink) withObject:nil afterDelay:delay];
}

-(void)generateAppearance
{
    // semi-randomly generated customer appearance!
    
    // set all Sprites to not visible
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
    
    // get colors
    _skinColor = [self getSkinColor];
    _eyeColor = [self getColor];
    
    // chose body parts and assign skin color
    // ears, face, neck
    NSMutableArray *bodyParts = [[NSMutableArray alloc] initWithObjects:_neckSprite, nil];
    if ([self coinFlip])
    {
        // ears
        [bodyParts addObject:_rightEar1Sprite];
        [bodyParts addObject:_leftEar1Sprite];
    }
    else
    {
        [bodyParts addObject:_rightEar2Sprite];
        [bodyParts addObject:_leftEar2Sprite];
    }
    
    if ([self coinFlip])
    {
        // head
        [bodyParts addObject:_head1Sprite];
    }
    else
    {
        [bodyParts addObject:_head2Sprite];
    }
    
    for (CCSprite *sprite in bodyParts) {
        [self turnOnSprite:sprite withColor:_skinColor];
    }
    
    // chose other things and assign colors
    // hair, shirt
    NSMutableArray *otherParts = [[NSMutableArray alloc] initWithObjects:_shirtSprite, nil];
    if ([self coinFlip])
    {
        [otherParts addObject:_hair1Sprite];
    }
    else
    {
        [otherParts addObject:_hair2Sprite];
    }
    
    for (CCSprite *sprite in otherParts)
    {
        [self turnOnSprite:sprite withColor:[self getColor]];
    }
    
    // eyes
    [self turnOnSprite:_rightEyeSprite withColor:_eyeColor];
    [self turnOnSprite:_leftEyeSprite withColor:_eyeColor];
    
    // mouth and nose
    if ([self coinFlip])
    {
        _mouth1Sprite.visible = YES;
    }
    else _mouth2Sprite.visible = YES;
    
    if ([self coinFlip])
    {
        _nose1Sprite.visible = YES;
    } else _nose2Sprite.visible = YES;
    
}

#pragma mark - Animations

- (void)blink
{
    [self startAnimation:kBlinkAnimationName];
}

- (void)frown
{
    [self startAnimation:kFrownAnimationName];
}

#pragma mark - Touch

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    if(!self.allPiercingsMade)
    {
        // frown
        [self startAnimation:kFrownAnimationName];
        
        // tell delegate head was touched
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

-(void)turnOnSprite:(CCSprite*)sprite withColor:(CCColor*)color
{
    sprite.visible = YES;
    sprite.color = color;
}

-(CCColor*)getSkinColor
{
    
    int skinNumber = arc4random_uniform(6);
    
    switch (skinNumber)
    {
        case 0:
            return skin0;
        case 1:
            return skin1;
        case 2:
            return skin2;
        case 3:
            return skin3;
        case 4:
            return skin4;
        case 5:
            return skin5;
        default:
            return skin0;
    }
}

-(CCColor*)getColor
{
    
    int colorNumber = arc4random_uniform(6);
    
    switch (colorNumber)
    {
        case 0:
            return color0;
        case 1:
            return color1;
        case 2:
            return color2;
        case 3:
            return color3;
        case 4:
            return color4;
        case 5:
            return color5;
        default:
            return color0;
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
    
    // reset smile
    [self setIsSmiling:NO];
    
    // clear targets
    for(Target *target in self.targets)
    {
        target.isPiercingNeeded = NO;
        target.piercing.visible = NO;
    }
    
    [self generateAppearance];
    [self randomlyAssignPiercingsNeeded];
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

- (void)randomlyAssignPiercingsNeeded
{
    while(self.numPiercingsNeeded == 0)
    {
        for(Target *target in self.targets)
        {
            target.isPiercingNeeded = [self coinFlip];
            if(target.isPiercingNeeded) { self.numPiercingsNeeded++; }
        }
    }
}

- (void)startAnimation:(NSString *)animationName
{
    CCAnimationManager* animationManager = self.animationManager;
    
    // timelines can be referenced and run by name
    [animationManager runAnimationsForSequenceNamed:animationName];
}

@end