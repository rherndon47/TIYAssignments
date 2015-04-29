//
//  SelectExercisesForRegimentTableViewController.h
//  TrainerTracker
//
//  Created by Richard Herndon on 4/28/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol SaveRegimentViewControllerDelegate

- (void)RegimentNameWasChosen:(NSString *)regimentName;

@end

@interface SelectExercisesForRegimentTableViewController : UITableViewController <SaveRegimentViewControllerDelegate>

@end
