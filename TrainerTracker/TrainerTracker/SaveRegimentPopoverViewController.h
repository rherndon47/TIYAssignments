//
//  SaveRegimentPopoverViewController.h
//  TrainerTracker
//
//  Created by Richard Herndon on 4/29/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectExercisesForRegimentTableViewController.h"

@interface SaveRegimentPopoverViewController : UIViewController

@property (strong, nonatomic) NSString *regimentName;
@property (strong, nonatomic) id<SaveRegimentViewControllerDelegate> delegate;

@end
