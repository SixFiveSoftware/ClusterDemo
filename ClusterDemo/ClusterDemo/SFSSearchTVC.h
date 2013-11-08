//
//  SFSSearchTVC.h
//  ClusterDemo
//
//  Created by BJ Miller on 11/6/13.
//  Copyright (c) 2013 Six Five Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SFSSearchResultsCompletion)(id obj, NSInteger idx);


@interface SFSSearchTVC : UITableViewController <UISearchBarDelegate>

@property (nonatomic, strong) UISearchDisplayController *searchController;

- (void)setTheItems:(NSArray *)theItems;
- (void)setTheCompletionBlock:(SFSSearchResultsCompletion)completion;

@end
