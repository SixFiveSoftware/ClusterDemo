//
//  SFSViewController.h
//  ClusterDemo
//
//  Created by BJ Miller on 11/5/13.
//  Copyright (c) 2013 Six Five Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFSViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

- (IBAction)buttonTapped:(id)sender;

@end
