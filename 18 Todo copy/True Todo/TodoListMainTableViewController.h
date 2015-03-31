//
//  TodoListMainTableViewController.h
//  True Todo
//
//  Created by Richard Herndon on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoObject.h"

@protocol ToDoDetailTableViewControllerDelegate

- (void)todoWasAdded:(TodoObject *)todoItem;

@end

@interface TodoListMainTableViewController : UITableViewController <ToDoDetailTableViewControllerDelegate>

@property (strong, nonatomic) TodoObject *todoObject;
@property (strong, nonatomic) TodoObject *todoObjectItem;
@property (strong,nonatomic) TodoObject *vcTodoObject;

@end
