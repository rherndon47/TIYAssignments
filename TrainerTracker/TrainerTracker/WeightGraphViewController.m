//
//  WeightGraphViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 5/6/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "WeightGraphViewController.h"
#import "FSLineChart.h"
#import "UIColor+FSPalette.h"

@interface WeightGraphViewController ()

@property (strong, nonatomic) NSMutableArray *exerciseArray;

@end

@implementation WeightGraphViewController
{
    NSMutableArray *exerciseRepsArray;
    NSMutableArray *exerciseWeightArray;
    NSString *graphTitle;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.81 green:0.63 blue:0.58 alpha:1.0];
    
    self.navigationItem.title = self.selectedExerciseName;
    
    [self readWeightExercises];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma marks - Data Methods

- (void)readWeightExercises
{
    PFQuery *queryExercise = [PFQuery queryWithClassName:@"ExerciseLog"];

    [queryExercise whereKey:@"exerciseName" equalTo:self.selectedExerciseName];
    
    [queryExercise findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             exerciseRepsArray = [[NSMutableArray alloc] init];
             exerciseWeightArray = [[NSMutableArray alloc] init];
             
             for (int i=0; i<[objects count]; i++)
             {
                 PFObject *aExercise = objects[i];
                 
                 exerciseRepsArray[i] = [aExercise objectForKey:@"exerciseReps"];
                 exerciseWeightArray[i] = [aExercise objectForKey:@"exerciseWeight"];
             }
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.view addSubview:[self chart1]];  // Reps
                 [self.view addSubview:[self chart2]];  // Weight
             });
             
         }
         else
         {
             NSLog(@"Error reading exercise records: %@", [error userInfo]);
         }
     }];
}

#pragma mark - Creating the charts

-(FSLineChart *)chart1
{
    // moving how many reps performed to be graphed
    
    NSMutableArray* chartData = [NSMutableArray arrayWithCapacity:[exerciseRepsArray count]];
    
    for(int i=0;i<[exerciseRepsArray count];i++)
    {
        chartData[i] = [NSNumber numberWithInt:exerciseRepsArray[i]];
    }
    
    // Creating the line chart
    FSLineChart *lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(20, 75, [UIScreen mainScreen].bounds.size.width - 40, 166)];
    
    lineChart.graphTitle = @"Replications";
    
    lineChart.gridStep = 3;
    
    lineChart.labelForIndex = ^(NSUInteger item)
    {
        return [NSString stringWithFormat:@"%lu",(unsigned long)item];
    };
    
    lineChart.labelForValue = ^(CGFloat value)
    {
        return [NSString stringWithFormat:@"%.f", value*.089];
    };
    
    [lineChart setChartData:chartData];
    
    return lineChart;
}

-(FSLineChart *)chart2
{
    // moving how much weight used to be graphed
    
    NSMutableArray *chartData = [NSMutableArray arrayWithCapacity:[exerciseWeightArray count]];
    
    for(int i=0;i<[exerciseWeightArray count];i++)
    {
        chartData[i] = [NSNumber numberWithInt:exerciseWeightArray[i]];
    }
    
    // Creating the line chart
    FSLineChart *lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(20, 260, [UIScreen mainScreen].bounds.size.width - 40, 166)];
    
    lineChart.graphTitle = @"Weight Lifted"; // Added by RLH
    lineChart.gridStep = 3;
    lineChart.color = [UIColor fsOrange];
    
    lineChart.labelForIndex = ^(NSUInteger item)
    {
        return [NSString stringWithFormat:@"%lu",(unsigned long)item];
    };
    
    lineChart.labelForValue = ^(CGFloat value)
    {
        return [NSString stringWithFormat:@"%.f", value*.07];
    };
    
    [lineChart setChartData:chartData];
    
    return lineChart;
}

@end
