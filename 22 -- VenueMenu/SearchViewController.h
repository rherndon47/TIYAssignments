//
//  SearchViewController.h
//  22 -- VenueMenu
//
//  Created by Richard Herndon on 4/2/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"
#import "FavVenueTableViewController.h"

@interface SearchViewController : UIViewController<UITextFieldDelegate>

@property (strong,nonatomic) NSString *itemField;
@property (strong, nonatomic) CoreDataStack *cdStack;

@end
