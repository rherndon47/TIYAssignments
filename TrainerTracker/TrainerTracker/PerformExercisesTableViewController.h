//
//  PerformExercisesTableViewController.h
//  TrainerTracker
//
//  Created by Richard Herndon on 4/29/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "PerformExerciseTableViewCell.h"

@protocol PerformExercisesTableViewDelegate <NSObject>

@required
- (void)dataFromController:(NSString *)data;

@end

@interface PerformExercisesTableViewController : UITableViewController

@property (strong, nonatomic) PFObject *passedPFObject;
@property (nonatomic, weak) id<PerformExercisesTableViewDelegate> delegate;

@end
