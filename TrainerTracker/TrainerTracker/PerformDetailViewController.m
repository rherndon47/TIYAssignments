//
//  PerformDetailViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 5/3/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "PerformDetailViewController.h"

@interface PerformDetailViewController ()
@property (strong, nonatomic) IBOutlet UITextField *exerciseName;
@property (strong, nonatomic) IBOutlet UITextField *exerciseNotes;
@property (strong, nonatomic) IBOutlet UITextField *exerciseReps;
@property (strong, nonatomic) IBOutlet UITextField *exerciseWeight;
@property (strong, nonatomic) IBOutlet UITextField *exerciseDistance;
@property (strong, nonatomic) IBOutlet UITextField *exerciseSpeed;
@property (strong, nonatomic) IBOutlet UITextField *exerciseLengthOfTime;

@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *completeButton;

- (IBAction)startExercise:(UIButton *)sender;

- (IBAction)completeExercise:(UIButton *)sender;

@end

@implementation PerformDetailViewController
{
    NSDate *todaysDate;
    NSString *exerciseStartTime;
    NSString *exerciseStopTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"PerformDetail - entered viewDidLoad");
    self.navigationItem.title = @"Perform Exercise";
    
    NSLog(@"passedPFObject %@",self.passedPFObject);
    
    [self readCurrentExercise];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction methods

- (IBAction)startExercise:(UIButton *)sender
{
    if ([self.startButton.titleLabel.text  isEqual: @"Start"])
    {
        [self.startButton setTitle:@"Pause" forState:UIControlStateNormal];
        
        NSDate * now = [NSDate date];
        todaysDate = now;
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"HH:mm:ss"];
        NSString *startDateString = [outputFormatter stringFromDate:now];
        NSLog(@"newDateString %@", startDateString);
        exerciseStartTime = startDateString;
    }
    else
    {
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    
}

- (IBAction)completeExercise:(UIButton *)sender
{
    NSDate *now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm:ss"];
    NSString *stopDateString = [outputFormatter stringFromDate:now];
    NSLog(@"newDateString %@", stopDateString);
    exerciseStopTime = stopDateString;
    
    [self saveExerciseLog];
}

#pragma mark - Data Methods

- (void)readCurrentExercise
{
    PFQuery *query = [PFQuery queryWithClassName:@"Exercise"];
    [query whereKey:@"exerciseName" equalTo:self.passedPFObject];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             self.exerciseName.text = [objects[0] objectForKey:@"exerciseName"];
             self.exerciseNotes.text = [objects[0] objectForKey:@"exerciseNotes"];
             
             self.exerciseReps.text = [NSString stringWithFormat:@"%@", [objects[0] objectForKey:@"exerciseReps"]];
             self.exerciseWeight.text = [NSString stringWithFormat:@"%@", [objects[0] objectForKey:@"exerciseWeight"]];
             self.exerciseLengthOfTime.text = [NSString stringWithFormat:@"%@", [objects[0] objectForKey:@"exerciseLengthOfTime"]];
             self.exerciseSpeed.text = [NSString stringWithFormat:@"%@", [objects[0] objectForKey:@"exerciseSpeed"]];
             self.exerciseDistance.text = [NSString stringWithFormat:@"%@", [objects[0] objectForKey:@"exerciseDistance"]];
            
         }
         else
         {
             NSLog(@"Error durining Exercise read: %@ %@", error, [error userInfo]);
         }
     }];
}

- (void)saveExerciseLog
{
    NSLog(@"Entered SaveExerciseLog");
    PFObject *exerciseObject = [PFObject objectWithClassName:@"ExerciseLog"];
    exerciseObject[@"exerciseName"] = self.exerciseName.text;
    exerciseObject[@"exerciseNote"] = self.exerciseNotes.text;
    
    exerciseObject[@"exerciseReps"] = [NSNumber numberWithInteger: [self.exerciseReps.text integerValue]];
    exerciseObject[@"exerciseWeight"] = [NSNumber numberWithInteger: [self.exerciseWeight.text integerValue]];
    exerciseObject[@"exerciseDistance"] = [NSNumber numberWithInteger: [self.exerciseDistance.text integerValue]];
    exerciseObject[@"exerciseSpeed"] = [NSNumber numberWithInteger: [self.exerciseSpeed.text integerValue]];
    exerciseObject[@"exerciseLengthOfTime"] = [NSNumber numberWithInteger: [self.exerciseLengthOfTime.text integerValue]];;
    exerciseObject[@"exerciseStartTime"] = exerciseStartTime;
    exerciseObject[@"exerciseStopTime"] = exerciseStopTime;
    exerciseObject[@"exerciseDate"] = todaysDate;
    
    [exerciseObject saveInBackground];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
