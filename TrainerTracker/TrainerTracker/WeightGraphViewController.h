//
//  WeightGraphViewController.h
//  TrainerTracker
//
//  Created by Richard Herndon on 5/6/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface WeightGraphViewController : UIViewController

@property (strong, nonatomic) PFObject *passedPFObject;

@property (strong, nonatomic) NSString *selectedExerciseName;

@end
