//
//  FirstViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 4/25/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "SelectGraphTypeViewController.h"
#import "SelectWeightTableViewController.h"
#import "SelectAerobicTableViewController.h"

@interface SelectGraphTypeViewController ()

@end

@implementation SelectGraphTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.81 green:0.63 blue:0.58 alpha:1.0];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"selectWeightExercises"])
    {
        SelectWeightTableViewController *destVC = (SelectWeightTableViewController *)[segue destinationViewController];
        
    }
    if ([segue.identifier isEqualToString:@"selectAerobicExercises"])
    {
        SelectAerobicTableViewController *destVC = (SelectAerobicTableViewController *)[segue destinationViewController];
    }
}

@end
