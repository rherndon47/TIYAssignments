//
//  SelectWeightTableViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 5/6/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "SelectWeightTableViewController.h"
#import "WeightGraphViewController.h"

#import "WeightGraphExerciseTableViewCell.h"

@interface SelectWeightTableViewController () <UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray *exerciseArray;

@end

@implementation SelectWeightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Weight Exercises";
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.741 green:0.486 blue:0.161 alpha:1] /*#bd7c29*/;
    
    PFQuery *queryExercise = [PFQuery queryWithClassName:@"Exercise"];
    NSLog(@"queryExercise %@", queryExercise);
    [queryExercise whereKey:@"typeOfExercise" equalTo:@"Weight"];
    
    [queryExercise findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             self.exerciseArray = [[NSMutableArray alloc] init];
             [self.exerciseArray addObjectsFromArray:objects];
             [self.tableView reloadData];
         }
         else
         {
             NSLog(@"Error reading exercise records: %@", [error userInfo]);
         }
     }];
}

- (void)viewWillAppear:(BOOL)animated
{
    PFQuery *queryExercise = [PFQuery queryWithClassName:@"Exercise"];
    NSLog(@"queryExercise %@", queryExercise);
    [queryExercise whereKey:@"typeOfExercise" equalTo:@"Weight"];
    
    [queryExercise findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             self.exerciseArray = [[NSMutableArray alloc] init];
             [self.exerciseArray addObjectsFromArray:objects];
             [self.tableView reloadData];
         }
         else
         {
             NSLog(@"Error reading exercise records: %@", [error userInfo]);
         }
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.exerciseArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeightGraphExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weightGraphExerciseCell" forIndexPath:indexPath];
    
    UIColor *cellColor = [UIColor colorWithRed:0.675 green:0.447 blue:0.137 alpha:1]; /*#ac7223*/
    UIColor *cellColor2 = [UIColor colorWithRed:0.741 green:0.486 blue:0.161 alpha:1] /*#bd7c29*/;
    
    if( [indexPath row] % 2)
        [cell setBackgroundColor:cellColor];
    else
        [cell setBackgroundColor:cellColor2];
    
    NSString *name = [self.exerciseArray[indexPath.row] objectForKey:@"exerciseName"];
    cell.exerciseNameLabel.text = name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    self.selectedExerciseName = [self.exerciseArray[indexPath.row] objectForKey:@"exerciseName"];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"weightGraphSeque"])
    {
        
        WeightGraphViewController *performExerciseVC = (WeightGraphViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        performExerciseVC.selectedExerciseName = [self.exerciseArray[indexPath.row] objectForKey:@"exerciseName"];
        
    }
}


@end
