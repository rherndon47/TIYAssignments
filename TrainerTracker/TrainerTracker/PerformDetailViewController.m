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

- (IBAction)startExercise:(UIButton *)sender;
- (IBAction)pauseExercise:(UIButton *)sender;
- (IBAction)completeExercise:(UIButton *)sender;

@end

@implementation PerformDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"PerformDetail - entered viewDidLoad");
    self.navigationItem.title = @"Perform Exercise";
    
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

#pragma mark - IBAction methods

- (IBAction)startExercise:(UIButton *)sender
{
    
}
- (IBAction)pauseExercise:(UIButton *)sender
{
    
}
- (IBAction)completeExercise:(UIButton *)sender
{
    
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
