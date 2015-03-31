//
//  POIResultsTableViewController.h
//  True Todo
//
//  Created by Richard Herndon on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoDetailTableViewController.h"
#import "TodoObject.h"

@import MapKit;

@interface POIResultsTableViewController : UITableViewController <ToDoDetailTableViewControllerDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) TodoObject *aTask;

@property (nonatomic, strong) NSArray *locationsArray;

@property (nonatomic, strong) MKLocalSearchResponse *searchResponses;

@end
