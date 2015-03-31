//
//  ToDoDetailTableViewController.h
//  True Todo
//
//  Created by Richard Herndon on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoListMainTableViewController.h"
#import "TodoObject.h"

@import MapKit;


@protocol DueDatePickerDelegate // for date picker

- (void)dueDateWasChosen:(NSDate *)dueDate;

@end

@interface ToDoDetailTableViewController : UITableViewController <DueDatePickerDelegate,ToDoDetailTableViewControllerDelegate>

@property (strong,nonatomic) id<ToDoDetailTableViewControllerDelegate> delegate;

@property (strong,nonatomic) NSMutableArray *TodoStore;
@property (strong,nonatomic) TodoObject *detailTodoObject;

@property (strong, nonatomic) IBOutlet UITextField *enterLocationTextField;

@property (strong,nonatomic) MKLocalSearchResponse *results;
@property (nonatomic) UITableViewController *POIVC;


-(void)performSearch:(MKCoordinateRegion)aRegion;



@end
