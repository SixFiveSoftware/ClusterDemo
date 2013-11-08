//
//  UIDevice+VersionCheck.m
//  ClassCluster
//
//  Created by BJ Miller on 8/14/13.
//  Copyright (c) 2013 Six Five Software, LLC. All rights reserved.
//

#import "UIDevice+VersionCheck.h"

@implementation UIDevice (VersionCheck)

- (NSUInteger)systemMajorVersion
{
    NSString *versionString;
    versionString = [self systemVersion];
    return (NSUInteger)[versionString doubleValue];
}

@end
