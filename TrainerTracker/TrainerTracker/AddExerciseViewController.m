//
//  AddExerciseViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 4/27/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "AddExerciseViewController.h"

@interface AddExerciseViewController ()

@property (strong, nonatomic) IBOutlet UITextField *exerciseName;
@property (strong, nonatomic) IBOutlet UITextField *exerciseNotes;
@property (strong, nonatomic) IBOutlet UITextField *exerciseReps;
@property (strong, nonatomic) IBOutlet UITextField *exerciseWeight;
@property (strong, nonatomic) IBOutlet UITextField *exerciseDistance;
@property (strong, nonatomic) IBOutlet UITextField *exerciseSpeed;
@property (strong, nonatomic) IBOutlet UITextField *exerciseLengthOfTime;

- (IBAction)SaveExercise:(UIButton *)sender;

@end

@implementation AddExerciseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Exercise Detail";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SaveExercise:(UIButton *)sender
{
    NSLog(@"Entered SaveExercise");
    PFObject *exerciseObject = [PFObject objectWithClassName:@"Exercise"];
    exerciseObject[@"exerciseName"] = self.exerciseName.text;
    exerciseObject[@"exerciseNotes"] = self.exerciseNotes.text;

    exerciseObject[@"exerciseReps"] = [NSNumber numberWithInteger: [self.exerciseReps.text integerValue]];
    exerciseObject[@"exerciseWeight"] = [NSNumber numberWithInteger: [self.exerciseWeight.text integerValue]];
    exerciseObject[@"exerciseDistance"] = [NSNumber numberWithInteger: [self.exerciseDistance.text integerValue]];
    exerciseObject[@"exerciseSpeed"] = [NSNumber numberWithInteger: [self.exerciseSpeed.text integerValue]];
    exerciseObject[@"exerciseLengthOfTime"] = [NSNumber numberWithInteger: [self.exerciseLengthOfTime.text integerValue]];;
    
    [exerciseObject saveInBackground];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
