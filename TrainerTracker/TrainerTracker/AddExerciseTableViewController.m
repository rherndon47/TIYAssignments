//
//  AddExerciseTableViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 4/26/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "AddExerciseTableViewController.h"
#import "AddExerciseViewController.h"
#import "UpdateExerciseViewController.h"

#import "ExerciseCell.h"

@interface AddExerciseTableViewController ()

@property (strong, nonatomic) NSMutableArray *exerciseArray;

@end

@implementation AddExerciseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Add Exercises";
    
    PFQuery *queryExercise = [PFQuery queryWithClassName:@"Exercise"];
    NSLog(@"queryExercise %@", queryExercise);

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    PFQuery *queryExercise = [PFQuery queryWithClassName:@"Exercise"];
    NSLog(@"queryExercise %@", queryExercise);
    
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
    ExerciseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"exerciseCell" forIndexPath:indexPath];
    
    UIColor *cellColor = [UIColor colorWithRed:0.522 green:0.341 blue:0.137 alpha:1] /*#855723*/;
    UIColor *cellColor2 = [UIColor colorWithRed:0.725 green:0.612 blue:0.42 alpha:1] /*#b99c6b*/;
    
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
    UpdateExerciseViewController *secondViewController = [[UpdateExerciseViewController alloc] init];
    secondViewController.passedPFObject = self.exerciseArray[indexPath.row];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        PFQuery *query = [PFQuery queryWithClassName:@"Exercise"];
        
        NSString *name = [self.exerciseArray[indexPath.row] objectForKey:@"exerciseName"];
        
        [query whereKey:@"exerciseName" equalTo:name];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
         {
             
             NSLog(@"placeholder %@", query);
//             NSString *name = [self.exerciseArray[indexPath.row] objectForKey:@"exerciseName"];

             [objects[0] deleteInBackground];
             [self.exerciseArray removeObject:self.exerciseArray[indexPath.row] ];
             [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
             [self.tableView reloadData];
             
         }];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addExerciseDetailSeque"])
    {
        AddExerciseViewController *destVC = (AddExerciseViewController *)[segue destinationViewController];

    }
    if ([segue.identifier isEqualToString:@"updateSeque"])
    {
        UpdateExerciseViewController *destVC = (UpdateExerciseViewController *)[segue destinationViewController];
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        destVC.passedPFObject = self.exerciseArray[path.row];
    }
}


@end
