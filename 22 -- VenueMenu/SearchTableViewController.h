//
//  SearchTableViewController.h
//  22 -- VenueMenu
//
//  Created by Richard Herndon on 4/2/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultsVenues.h"
#import "SearchViewController.h"

@interface SearchTableViewController : UITableViewController

@property (strong,nonatomic) NSString *itemField;
@property (nonatomic) NSMutableArray *resultVenues;
@property (strong, nonatomic) SearchResultsVenues *transferResultVenue;
@property (strong, nonatomic) CoreDataStack *cdStack;
@property (strong, nonatomic) NSString *fromFavView;


@end
