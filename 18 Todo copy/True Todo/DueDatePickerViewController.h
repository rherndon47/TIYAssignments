//
//  DueDatePickerViewController.h
//  True Todo
//
//  Created by Richard Herndon on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoObject.h"
#import "ToDoDetailTableViewController.h"

@interface DueDatePickerViewController : UIViewController

@property (strong, nonatomic) id<DueDatePickerDelegate,ToDoDetailTableViewControllerDelegate> delegate;

@end
