//
//  UpdateExerciseViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 5/3/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "UpdateExerciseViewController.h"

@interface UpdateExerciseViewController ()

@property (strong, nonatomic) IBOutlet UITextField *exerciseName;
@property (strong, nonatomic) IBOutlet UITextField *exerciseNotes;
@property (strong, nonatomic) IBOutlet UITextField *exerciseReps;
@property (strong, nonatomic) IBOutlet UITextField *exerciseWeight;
@property (strong, nonatomic) IBOutlet UITextField *exerciseDistance;
@property (strong, nonatomic) IBOutlet UITextField *exerciseSpeed;
@property (strong, nonatomic) IBOutlet UITextField *exerciseLengthOfTime;

- (IBAction)updateExercise:(UIButton *)sender;

@end

@implementation UpdateExerciseViewController
{
    NSString *typeOfExercise;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Update Exercise";
    
    NSLog(@"passedPFObject %@",self.passedPFObject);

    self.exerciseName.text = [self.passedPFObject objectForKey:@"exerciseName"];
    self.exerciseNotes.text = [self.passedPFObject objectForKey:@"exerciseNotes"];

    self.exerciseReps.text = [NSString stringWithFormat:@"%@", [self.passedPFObject objectForKey:@"exerciseReps"]];
    self.exerciseWeight.text = [NSString stringWithFormat:@"%@", [self.passedPFObject objectForKey:@"exerciseWeight"]];
    self.exerciseLengthOfTime.text = [NSString stringWithFormat:@"%@", [self.passedPFObject objectForKey:@"exerciseLengthOfTime"]];
    self.exerciseSpeed.text = [NSString stringWithFormat:@"%@", [self.passedPFObject objectForKey:@"exerciseSpeed"]];
    self.exerciseDistance.text = [NSString stringWithFormat:@"%@", [self.passedPFObject objectForKey:@"exerciseDistance"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateExercise:(UIButton *)sender
{
    NSLog(@"Entered updateExercise");
    PFObject *exerciseObject = [PFObject objectWithClassName:@"Exercise"];
    
    exerciseObject[@"exerciseName"] = self.exerciseName.text;
    exerciseObject[@"exerciseNotes"] = self.exerciseNotes.text;
    
    exerciseObject[@"exerciseReps"] = [NSNumber numberWithInteger: [self.exerciseReps.text integerValue]];
    exerciseObject[@"exerciseWeight"] = [NSNumber numberWithInteger: [self.exerciseWeight.text integerValue]];
    exerciseObject[@"exerciseDistance"] = [NSNumber numberWithInteger: [self.exerciseDistance.text integerValue]];
    exerciseObject[@"exerciseSpeed"] = [NSNumber numberWithInteger: [self.exerciseSpeed.text integerValue]];
    exerciseObject[@"exerciseLengthOfTime"] = [NSNumber numberWithInteger: [self.exerciseLengthOfTime.text integerValue]];;
    
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
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
