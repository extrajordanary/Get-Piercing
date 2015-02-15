//
//  Blood.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 11/2/14.
//  Copyright (c) 2014 Harlan Kellaway. All rights reserved.
//

#import "Blood.h"

@implementation Blood

- (void)didLoadFromCCB
{
    CGRect screen = [[UIScreen mainScreen] bounds];
    int screenWidth = (int)screen.size.width;
    int screenHeight = (int)screen.size.height;
    
    CGFloat randomXPos = 0 + arc4random() % screenWidth;
    CGFloat randomYPos = 0 + arc4random() % screenHeight;
    
    self.position = ccp(randomXPos, randomYPos);
}

@end
