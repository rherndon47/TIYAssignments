//
//  AerobicGraphViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 5/7/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "AerobicGraphViewController.h"
#import "FSLineChart.h"
#import "UIColor+FSPalette.h"

@interface AerobicGraphViewController ()

@property (strong, nonatomic) NSMutableArray *exerciseArray;

@end

@implementation AerobicGraphViewController
{
    NSMutableArray *exerciseDistanceArray;
    NSMutableArray *exerciseLengthOfTimeArray;
    NSMutableArray *exerciseSpeedArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Entered AerobicGraph - viewDidLoad");
    
    self.navigationItem.title = self.selectedExerciseName;
    
    [self readWeightExercises];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marks - Data Methods

- (void)readWeightExercises
{
    PFQuery *queryExercise = [PFQuery queryWithClassName:@"ExerciseLog"];
    
    NSLog(@"selectedExerciseName %@", self.selectedExerciseName);
    [queryExercise whereKey:@"exerciseName" equalTo:self.selectedExerciseName];
    
    [queryExercise findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             
             exerciseDistanceArray = [[NSMutableArray alloc] init];
             exerciseLengthOfTimeArray = [[NSMutableArray alloc] init];
             exerciseSpeedArray = [[NSMutableArray alloc] init];
             
             //             [self.exerciseArray addObjectsFromArray:objects];
             for (int i=0; i<[objects count]; i++)
             {
                 PFObject *aExercise = objects[i];
                 
                 exerciseDistanceArray[i] = [aExercise objectForKey:@"exerciseDistance"];
                 exerciseLengthOfTimeArray[i] = [aExercise objectForKey:@"exerciseLengthOfTime"];
                 exerciseSpeedArray[i] = [aExercise objectForKey:@"exerciseSpeed"];
             }
             
             dispatch_async(dispatch_get_main_queue(), ^{
//                 [self.view addSubview:[self chart1]];
//                 [self.view addSubview:[self chart2]];
//                 [self.view addSubview:[self chart3]];
             });
             
         }
         else
         {
             NSLog(@"Error reading exercise records: %@", [error userInfo]);
         }
     }];
}

#pragma mark - Creating the charts

-(FSLineChart*)chart1 {
    // Generating some dummy data
    NSMutableArray* chartData = [NSMutableArray arrayWithCapacity:20];
    
    for(int i=0;i<20;i++) {
        chartData[i] = [NSNumber numberWithInt:rand() % 100];
    }
    
    // Creating the line chart
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(20, 60, [UIScreen mainScreen].bounds.size.width - 40, 166)];
    
    lineChart.gridStep = 3;
    
    lineChart.labelForIndex = ^(NSUInteger item) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)item];
    };
    
    lineChart.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.f", value];
    };
    
    [lineChart setChartData:chartData];
    
    return lineChart;
}

-(FSLineChart*)chart2 {
    // Generating some dummy data
    NSMutableArray* chartData = [NSMutableArray arrayWithCapacity:101];
    
    for(int i=0;i<101;i++) {
        chartData[i] = [NSNumber numberWithFloat: (float)i / 30.0f + (float)(rand() % 100) / 500.0f];
    }
    
    // Creating the line chart
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(20, 260, [UIScreen mainScreen].bounds.size.width - 40, 166)];
    
    lineChart.gridStep = 4;
    lineChart.color = [UIColor fsOrange];
    
    lineChart.labelForIndex = ^(NSUInteger item) {
        return [NSString stringWithFormat:@"%lu%%",(unsigned long)item];
    };
    
    lineChart.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.f €", value];
    };
    
    [lineChart setChartData:chartData];
    
    return lineChart;
}

@end
