//
//  Blood.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Blood.h"

@implementation Blood

- (void)didLoadFromCCB
{
    // get screen size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int screenWidth = (int)screenRect.size.width;
    int screenHeight = (int)screenRect.size.height;
    
    // set random position
    CGFloat randomXPos = 0 + arc4random() % screenWidth;
    CGFloat randomYPos = 0 + arc4random() % screenHeight;
    
    self.position = ccp(randomXPos, randomYPos);
}

@end
