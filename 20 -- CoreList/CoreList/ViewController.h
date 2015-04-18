//
//  ViewController.h
//  CoreList
//
//  Created by Richard Herndon on 3/31/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"
#import "CoreListTableViewController.h" 

@interface ViewController : UIViewController

@property (strong, nonatomic) CoreDataStack *cdStack;

@end

