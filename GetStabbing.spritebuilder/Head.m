//
//  Head.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Head.h"

#import "Constants.h"
#import "Target.h"

@implementation Head
{
    // smile
    CCSprite *_smile;
    BOOL _isSmiling;
    
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

- (void)didLoadFromCCB
{
    // score
    self.isScoreTallied = NO;
    
    // smile
    [self setIsSmiling:NO];
    
    // generate a random number between 0.0 and 1.0
    float delay = (arc4random() % 1000) / 1000.f;
    [self performSelector:@selector(blink) withObject:nil afterDelay:delay];
    
    // add targets to array
    self.targets = [[NSMutableArray alloc] init];
    
    self.labret.piercing = _labretP;
    self.labret.delegate = self;
    [self.targets addObject:self.labret];
    
    self.leftEyebrow.piercing = _leftEyebrowP;
    self.rightEyebrow.piercing = _rightEyebrowP;
    self.leftEyebrow.delegate = self;
    self.rightEyebrow.delegate = self;
    [self.targets addObject:self.leftEyebrow];
    [self.targets addObject:self.rightEyebrow];
    
    self.leftNose.piercing = _leftNoseP;
    self.rightNose.piercing = _rightNoseP;
    self.leftNose.delegate = self;
    self.rightNose.delegate = self;
    [self.targets addObject:self.leftNose];
    [self.targets addObject:self.rightNose];
    
    self.lowerLeftEar.piercing = _lowerLeftEarP;
    self.lowerRightEar.piercing = _lowerRightEarP;
    self.lowerLeftEar.delegate = self;
    self.lowerRightEar.delegate = self;
    [self.targets addObject:self.lowerLeftEar];
    [self.targets addObject:self.lowerRightEar];
    
    self.upperLeftEar.piercing = _upperLeftEarP;
    self.upperRightEar.piercing = _upperRightEarP;
    self.upperLeftEar.delegate = self;
    self.upperRightEar.delegate = self;
    [self.targets addObject:self.upperLeftEar];
    [self.targets addObject:self.upperRightEar];
    
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
    
    // clear settings
    [self reset];
    
    // enable touch
    self.userInteractionEnabled = YES;
}

-(void)setIsSmiling:(BOOL)isSmiling
{
    _isSmiling = isSmiling;
    _smile.visible = isSmiling;
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
    [self startAnimation:BLINK_ANIMATION_NAME];
}

- (void)frown
{
    [self startAnimation:FROWN_ANIMATION_NAME];
}

#pragma mark - Touch

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(!self.allPiercingsMade)
    {
        // frown
        [self startAnimation:FROWN_ANIMATION_NAME];
        
        // tell delegate head was touched
        [self.delegate headTouchedAtPoint:[touch locationInNode:self] andWasOnTarget:NO];
    }
}

#pragma mark - TargetDelegate methods

-(void)targetTouched:(Target*)target
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
    
    // tell delegate touch occurred
    [self.delegate headTouchedAtPoint:target.position andWasOnTarget:YES];
}

#pragma mark - Helper methods

-(void)turnOnSprite:(CCSprite*)sprite withColor:(CCColor*)color
{
    sprite.visible = YES;
    sprite.color = color;
}

-(CCColor*)getSkinColor
{
    
    int skinNumber = arc4random_uniform(6);
    //    NSLog(@"skin number %i",skinNumber);
    
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
    //    NSLog(@"color number %i",colorNumber);
    
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