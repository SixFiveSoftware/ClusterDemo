//
//  SFSSearchTVC.m
//  ClusterDemo
//
//  Created by BJ Miller on 11/6/13.
//  Copyright (c) 2013 Six Five Software, LLC. All rights reserved.
//

#import "SFSSearchTVC.h"
#import "UIDevice+VersionCheck.h"
#import "SFSSearchTVC6.h"
#import "SFSSearchTVC7.h"

@interface SFSSearchTVC () 
@property (nonatomic, strong) NSArray *theItems;
@property (nonatomic, strong) NSMutableArray *filteredItems;
@property (nonatomic, strong) SFSSearchResultsCompletion completion;
@end

@implementation SFSSearchTVC

+ (id)alloc
{
    if ([self class] == [SFSSearchTVC class]) {
        if ([[UIDevice currentDevice] systemMajorVersion] < 7) {
            return [SFSSearchTVC6 alloc];
        } else if ([[UIDevice currentDevice] systemMajorVersion] == 7) {
            return [SFSSearchTVC7 alloc];
        }
    }
    
    return [super alloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.searchDisplayController setDelegate:nil];
    
    self.filteredItems = [@[] mutableCopy];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, self.tableView.frame.size.width, 64)];
    [searchBar setDelegate:self];
    _searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
//    [self.searchController setDelegate:self]; // commented this out to show that this class should NOT be the delegate...let the private subclasses be the delegate
    [self.searchController setSearchResultsDataSource:self];
    [self.searchController setSearchResultsDelegate:self];
    
    [self.searchController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
}

- (void)setTheItems:(NSArray *)theItems
{
    _theItems = theItems;
}

- (void)setTheCompletionBlock:(SFSSearchResultsCompletion)completion
{
    _completion = completion;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        NSLog(@"tableView is self.tableView. count: %lu", (unsigned long)[self.filteredItems count]);
        return 0;
    } else if (tableView == self.searchController.searchResultsTableView) {
        NSLog(@"tableView is self.searchController.searchResultsTableView. count: %lu", (unsigned long)[self.filteredItems count]);
        return [self.filteredItems count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (tableView == self.searchController.searchResultsTableView) {
        NSLog(@"CFRAIP tableView is searchResultsTableView.");
        cell.textLabel.text = self.filteredItems[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (_completion) {
            NSInteger idx = indexPath.row;
            id obj = self.filteredItems[idx];
            _completion(obj, idx);
        }
    }];
}

#pragma mark - UISearchBar delegate methods
// This cluster class should be the searchBar delegate, searchResultsDelegate, and searchResultsDataSource so that all private subclasses inherit functionality and don't need to rewrite code
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"cluster. searchBar:textDidChange: (%@)", searchText);
    [self.filteredItems removeAllObjects];
    self.filteredItems = [self filteredResultsForString:searchText];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.filteredItems removeAllObjects];
}

- (NSMutableArray *)filteredResultsForString:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    NSMutableArray *mutableResults = [[self.theItems filteredArrayUsingPredicate:predicate] mutableCopy];
    return mutableResults;
}

#pragma mark - UISearchDisplayDelegate methods
// none here; the subclasses will be the delegate for UISDC

@end
