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

@end

@implementation WeightGraphViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self readWeightExercises];
    
    [self.view addSubview:[self chart1]];
    [self.view addSubview:[self chart2]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)readWeightExercises
{
    
}

#pragma mark - Creating the charts

-(FSLineChart*)chart1
{
    // Generating some dummy data
    NSMutableArray* chartData = [NSMutableArray arrayWithCapacity:20];
    
    for(int i=0;i<20;i++)
    {
        chartData[i] = [NSNumber numberWithInt:rand() % 100];
    }
    
    // Creating the line chart
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(20, 60, [UIScreen mainScreen].bounds.size.width - 40, 166)];
    
    lineChart.gridStep = 3;
    
    lineChart.labelForIndex = ^(NSUInteger item)
    {
        return [NSString stringWithFormat:@"%lu",(unsigned long)item];
    };
    
    lineChart.labelForValue = ^(CGFloat value)
    {
        return [NSString stringWithFormat:@"%.f", value];
    };
    
    [lineChart setChartData:chartData];
    
    return lineChart;
}

-(FSLineChart*)chart2
{
    // Generating some dummy data
    NSMutableArray* chartData = [NSMutableArray arrayWithCapacity:101];
    
    for(int i=0;i<101;i++)
    {
        chartData[i] = [NSNumber numberWithFloat: (float)i / 30.0f + (float)(rand() % 100) / 500.0f];
    }
    
    // Creating the line chart
    FSLineChart* lineChart = [[FSLineChart alloc] initWithFrame:CGRectMake(20, 260, [UIScreen mainScreen].bounds.size.width - 40, 166)];
    
    lineChart.gridStep = 4;
    lineChart.color = [UIColor fsOrange];
    
    lineChart.labelForIndex = ^(NSUInteger item)
    {
        return [NSString stringWithFormat:@"%lu%%",(unsigned long)item];
    };
    
    lineChart.labelForValue = ^(CGFloat value)
    {
        return [NSString stringWithFormat:@"%.f €", value];
    };
    
    [lineChart setChartData:chartData];
    
    return lineChart;
}

@end
