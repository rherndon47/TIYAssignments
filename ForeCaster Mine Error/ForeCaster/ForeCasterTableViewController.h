//
//  ForeCasterTableViewController.h
//  ForeCaster
//
//  Created by Richard Herndon on 3/19/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "NetworkManager.h"

@protocol ForeCasterTableViewControllerDelegate

- (void)cityWasFound:(City *)aCity;
//- (void)cityWasFound:(City *)aCity;
- (void)weatherWasFoundForCity:(City *)aCity;

@end

@interface ForeCasterTableViewController : UITableViewController <ForeCasterTableViewControllerDelegate>


@end
