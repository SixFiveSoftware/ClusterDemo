//
//  SFSSearchTVC7.m
//  ClusterDemo
//
//  Created by BJ Miller on 11/6/13.
//  Copyright (c) 2013 Six Five Software, LLC. All rights reserved.
//

#import "SFSSearchTVC7.h"

@interface SFSSearchTVC7 ()
@property (nonatomic, strong) UITableView *originalTableView;
@end

@implementation SFSSearchTVC7


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.searchController setDelegate:self];
    [self.searchController setDisplaysSearchBarInNavigationBar:YES];
    NSLog(@"iOS 7 viewDidLoad");
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"iOS 7 viewWillDisappear");
    [super viewWillDisappear:animated];
    [self restoreOriginalTableView];
}

- (UITableView *)tableView
{
    NSLog(@"iOS 7 tableView");
    return self.originalTableView ?: [super tableView];
}

- (void)restoreOriginalTableView
{
    NSLog(@"iOS 7 restoreOriginalTableView");
    if (self.originalTableView) {
        self.view = self.originalTableView;
    }
}

- (UIEdgeInsets)edgeInsetsForSearchResultsTableView
{
    NSLog(@"iOS 7 edgeInsetsForSearchResultsTableView");
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIEdgeInsetsMake(navHeight, 0, 0, 0);
    } else {
        return UIEdgeInsetsMake(navHeight + statusHeight, 0, 0, 0);
    }
}

#pragma mark - UISearchDisplayController delegate methods
- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    NSLog(@"iOS 7 searchDisplayController:didShowSearchResultsTableView:");
    if (!self.originalTableView) {
        self.originalTableView = self.tableView;
    }
    self.view = controller.searchResultsTableView;
    controller.searchResultsTableView.contentInset = [self edgeInsetsForSearchResultsTableView];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView
{
    NSLog(@"iOS 7 searchDisplayController:didHideSearchResultsTableView:");
    [self restoreOriginalTableView];
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(@"in cluster class, searchDisplayController:shouldReloadTableForSearchString:");
    [self searchBar:controller.searchBar textDidChange:searchString];
    [self.searchController.searchResultsTableView reloadData];
    return YES;
}

@end
