//
//  PerformDetailViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 5/3/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "PerformDetailViewController.h"
#import "PerformExercisesTableViewController.h"

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
    NSString *typeOfExercise;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"PerformDetail - entered viewDidLoad");
    self.navigationItem.title = @"Perform Exercise";
    
    NSLog(@"passedPFObject %@",self.passedPFObject);
    
    if ([self.allOrOneParameter isEqualToString:@"all"])
    {
        if (self.passedExerciseIndex < [self.passedExerciseObjectsArray count])
        {
            [self readExercise];
            self.passedExerciseIndex = self.passedExerciseIndex + 1;
        }
        
    }
    else
    {
//        [self readCurrentExercise];
        [self readExercise];
    }
    
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


- (void)readExercise
{
    // this method reads the exercise information from the passed array of objects and puts data on the view
    
    self.exerciseName.text = [self.passedExerciseObjectsArray[self.passedExerciseIndex] objectForKey:@"exerciseName"];
    self.exerciseNotes.text = [self.passedExerciseObjectsArray[self.passedExerciseIndex] objectForKey:@"exerciseNotes"];
             
    self.exerciseReps.text = [NSString stringWithFormat:@"%@", [self.passedExerciseObjectsArray[self.passedExerciseIndex] objectForKey:@"exerciseReps"]];
    self.exerciseWeight.text = [NSString stringWithFormat:@"%@", [self.passedExerciseObjectsArray[self.passedExerciseIndex] objectForKey:@"exerciseWeight"]];
    self.exerciseLengthOfTime.text = [NSString stringWithFormat:@"%@", [self.passedExerciseObjectsArray[self.passedExerciseIndex]  objectForKey:@"exerciseLengthOfTime"]];
    self.exerciseSpeed.text = [NSString stringWithFormat:@"%@", [self.passedExerciseObjectsArray[self.passedExerciseIndex] objectForKey:@"exerciseSpeed"]];
    self.exerciseDistance.text = [NSString stringWithFormat:@"%@", [self.passedExerciseObjectsArray[self.passedExerciseIndex] objectForKey:@"exerciseDistance"]];
    
}

- (void)saveExerciseLog
{
    // this method saves the exercise data in the ExerciseLog entity
    
    NSLog(@"Entered SaveExerciseLog");
    PFObject *exerciseObject = [PFObject objectWithClassName:@"ExerciseLog"];
    exerciseObject[@"exerciseName"] = self.exerciseName.text;
    exerciseObject[@"exerciseNote"] = self.exerciseNotes.text;
    NSLog(@"exercise note %@", self.exerciseNotes.text);
    exerciseObject[@"exerciseReps"] = [NSNumber numberWithInteger: [self.exerciseReps.text integerValue]];
    exerciseObject[@"exerciseWeight"] = [NSNumber numberWithInteger: [self.exerciseWeight.text integerValue]];
    exerciseObject[@"exerciseDistance"] = [NSNumber numberWithInteger: [self.exerciseDistance.text integerValue]];
    exerciseObject[@"exerciseSpeed"] = [NSNumber numberWithInteger: [self.exerciseSpeed.text integerValue]];
    NSLog(@"exercise speed %@", self.exerciseSpeed.text);
    exerciseObject[@"exerciseLengthOfTime"] = [NSNumber numberWithInteger: [self.exerciseLengthOfTime.text integerValue]];;
    exerciseObject[@"exerciseStartTime"] = exerciseStartTime;
    exerciseObject[@"exerciseStopTime"] = exerciseStopTime;
    exerciseObject[@"exerciseDate"] = todaysDate;
    
    // estabish if exercise is weight or aerobic. used for graphing
    if (![self.exerciseReps.text isEqualToString:@"0"] || ![self.exerciseWeight.text isEqualToString:@"0"])
    {
        typeOfExercise = @"Weight";
    }
    else if (![self.exerciseDistance.text isEqualToString:@"0"] || ![self.exerciseSpeed.text isEqualToString:@"0"])
    {
        typeOfExercise = @"Aerobic";
    }
    exerciseObject[@"typeOfExercise"] = typeOfExercise;

    [exerciseObject saveInBackground];
    
    if ([self.allOrOneParameter isEqualToString:@"one"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if (self.passedExerciseIndex < [self.passedExerciseObjectsArray count])
        {
            [self readExercise];
            self.passedExerciseIndex = self.passedExerciseIndex + 1;
            [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }

}

@end
