//
//  SFSViewController.m
//  ClusterDemo
//
//  Created by BJ Miller on 11/5/13.
//  Copyright (c) 2013 Six Five Software, LLC. All rights reserved.
//

#import "SFSViewController.h"
#import "SFSSearchTVC.h"

@interface SFSViewController ()
@property (nonatomic, strong) NSArray *items;
@end

@implementation SFSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = @[@"Watermelon",
                   @"Orange",
                   @"Apples",
                   @"Bananas",
                   @"Grapefruit",
                   @"Strawberries",
                   @"Kiwi",
                   @"Pear"];
    
}

- (IBAction)buttonTapped:(id)sender
{
    [self performSegueWithIdentifier:@"SearchSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SearchSegue"]) {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        SFSSearchTVC *vc = (SFSSearchTVC *)[nav topViewController];
        if ([vc respondsToSelector:@selector(setTheItems:)]) {
            [vc setTheItems:self.items];
        }
        if ([vc respondsToSelector:@selector(setTheCompletionBlock:)]) {
            [vc setTheCompletionBlock:^(id obj, NSInteger idx) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.myLabel.text = [NSString stringWithFormat:@"Item %ld, %@, selected. (zero-based, of course!)", (long)idx, obj];
                });
            }];
        }
    }
}

@end
