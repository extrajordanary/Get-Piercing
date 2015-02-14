//
//  ModeManager.m
//  GetStabbing
//
//  Created by Harlan Kellaway on 2/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ModeManager.h"

static NSString * const kPlistNameModeInfoEasy = @"GPModeInfoEasy";
static NSString * const kPlistNameModeInfoDefault = @"GPModeInfoDefault";
static NSString * const kPlistNameModeInfoHard = @"GPModeInfoHard";

@implementation ModeManager
{
    GPMode _mode;
    NSDictionary *_modeInfo;
}

#pragma mark - Initializers

+(instancetype)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

#pragma mark Getters

- (GPMode)mode
{
    return _mode;
}

- (NSDictionary *)modeInfo
{
    return _modeInfo;
}

#pragma mark Setters

- (void)setMode:(GPMode)mode
{
    _mode = mode;
    
    switch (mode) {
        case GPModeEasy:
            _modeInfo = [self getPListData:kPlistNameModeInfoEasy];
            break;
        case GPModeDefault:
            _modeInfo = [self getPListData:kPlistNameModeInfoDefault];
            break;
        case GPModeHard:
            _modeInfo = [self getPListData:kPlistNameModeInfoHard];
            break;
        default:
            _modeInfo = [self getPListData:kPlistNameModeInfoDefault];
            break;
    }
}

#pragma mark - Private methods

- (NSDictionary *)getPListData:(NSString *)plistName
{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    // get file-styem path to file containing XML property list
    plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", plistName]];
    
    // if file doesn't exist at file-system path, check application's main bundle
    if(![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", plistName] ofType:@"plist"];
    }
    
    NSData *pListXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    
    NSDictionary *plistData = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:pListXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if(!plistData)
    {
        return [NSDictionary dictionary];
    }
    
    return plistData;
}

@end
