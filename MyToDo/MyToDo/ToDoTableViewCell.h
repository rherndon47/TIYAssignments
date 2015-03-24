//
//  ToDoTableViewCell.h
//  MyToDo
//
//  Created by Richard Herndon on 3/17/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *checkBoxButton;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;

@end
