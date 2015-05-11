//
//  PerformDetailViewController.h
//  TrainerTracker
//
//  Created by Richard Herndon on 5/3/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "PerformExercisesTableViewController.h"

@protocol PerformDetailDelegate <NSObject>

@end

@interface PerformDetailViewController : UIViewController

@property (strong, nonatomic) PFObject *passedPFObject;
@property (strong, nonatomic) NSMutableArray *passedExerciseObjectsArray;
@property int passedExerciseIndex;
@property (strong, nonatomic) NSString *allOrOneParameter;
@property (nonatomic, weak) id<PerformDetailDelegate> delegate;

@end
