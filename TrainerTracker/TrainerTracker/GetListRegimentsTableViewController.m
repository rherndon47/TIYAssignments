//
//  PerformExercisesTableViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 4/29/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "GetListRegimentsTableViewController.h"
#import "PerformExercisesTableViewController.h"

#import "PerformRegimentTableViewCell.h"

@interface GetListRegimentsTableViewController () <UITextFieldDelegate, PerformDetailViewDelegate>

@property (strong, nonatomic) NSMutableArray *regimentArray;

@end

@implementation GetListRegimentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Select Regiment";
    
    PFQuery *queryExercise = [PFQuery queryWithClassName:@"Regiments"];
    
    [queryExercise findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
             self.regimentArray = [[NSMutableArray alloc] init];
             [self.regimentArray addObjectsFromArray:objects];
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
    return [self.regimentArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PerformRegimentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"performRegimentCell" forIndexPath:indexPath];
    
    UIColor *cellColor = [UIColor colorWithRed:0.561 green:0.706 blue:0.82 alpha:1]; /*#8fb4d1*/
    UIColor *cellColor2 = [UIColor colorWithRed:0.451 green:0.569 blue:0.776 alpha:1]; /*#7391c6*/
    
//        UIColor *cellColor = [UIColor colorWithRed:0.329 green:0.467 blue:0.188 alpha:1] /*#547730*/;
//        UIColor *cellColor2 = [UIColor colorWithRed:0.631 green:0.761 blue:0.451 alpha:1] /*#a1c273*/;
    
    if( [indexPath row] % 2)
        [cell setBackgroundColor:cellColor];
    else
        [cell setBackgroundColor:cellColor2];
    
    NSString *name = [self.regimentArray[indexPath.row] objectForKey:@"regimentName"];
    
    cell.performRegimentNameLabel.text = name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PerformExercisesTableViewController *secondViewController = [[PerformExercisesTableViewController alloc] init];
    secondViewController.passedPFObject = self.regimentArray[indexPath.row];
    secondViewController.delegate = self;
    [self.navigationController pushViewController:secondViewController animated:YES];

}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        PFQuery *query = [PFQuery queryWithClassName:@"Regiments"];
        
        NSString *name = [self.regimentArray[indexPath.row] objectForKey:@"regimentName"];
        
        [query whereKey:@"regimentName" equalTo:name];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
         {
             
             NSLog(@"placeholder %@", query);
             //             NSString *name = [self.exerciseArray[indexPath.row] objectForKey:@"exerciseName"];
             
             [objects[0] deleteInBackground];
             [self.regimentArray removeObject:self.regimentArray[indexPath.row] ];
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
    if ([segue.identifier isEqualToString:@"listOfExercisesSeque"])
    {
        
        PerformExercisesTableViewController *performExerciseVC = (PerformExercisesTableViewController *)[segue destinationViewController];
    }
}


@end
