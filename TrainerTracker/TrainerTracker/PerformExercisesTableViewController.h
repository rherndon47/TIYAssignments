//
//  PerformExercisesTableViewController.h
//  TrainerTracker
//
//  Created by Richard Herndon on 4/29/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "PerformDetailViewController.h"
#import "PerformExerciseTableViewCell.h"

@protocol PerformDetailViewDelegate <NSObject>

@required
- (void)dataFromController:(NSString *)data;

@end

@interface PerformExercisesTableViewController : UITableViewController

@property (strong, nonatomic) PFObject *passedPFObject;
@property (strong, nonatomic) NSString *allOrOneParameter;
@property (nonatomic, weak) id<PerformDetailViewDelegate> delegate;

@end
