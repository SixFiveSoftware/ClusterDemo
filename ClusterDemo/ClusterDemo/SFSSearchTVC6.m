//
//  SFSSearchTVC6.m
//  ClusterDemo
//
//  Created by BJ Miller on 11/6/13.
//  Copyright (c) 2013 Six Five Software, LLC. All rights reserved.
//

#import "SFSSearchTVC6.h"

@interface SFSSearchTVC6 ()

@end

@implementation SFSSearchTVC6


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.searchController setDelegate:self];
    NSLog(@"iOS 6 viewDidLoad");
    
    [self.tableView setTableHeaderView:self.searchController.searchBar];
}

// here we don't need the 3 UISDC delegate methods, because in iOS 6, they're not jacked up and need a hack to fix.

@end
