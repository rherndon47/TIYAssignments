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

@interface GetListRegimentsTableViewController () <UITextFieldDelegate, PerformExercisesTableViewDelegate>

@property (strong, nonatomic) NSMutableArray *regimentArray;

@end

@implementation GetListRegimentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Select Regiment";
    
    PFQuery *queryExercise = [PFQuery queryWithClassName:@"Regiments"];
    NSLog(@"queryExercise %@", queryExercise);
    
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
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
//    PerformExercisesTableViewController *viewControllerB = [[PerformExercisesTableViewController alloc] initWithNib:@"PerformExercisesTableViewController" bundle:nil];
//    PerformExercisesTableViewController.passedPFObject = self.regimentArray[indexPath.row];
//
//    [self pushViewController:PerformExercisesTableViewController animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"listOfExercisesSeque"])
    {
        
        PerformExercisesTableViewController *performExerciseVC = (PerformExercisesTableViewController *)[segue destinationViewController];
        
//        UIView *contentView = [textField superview]; // handle to textField
//        UITableViewCell *cell = (UITableViewCell *)[contentView superview]; // handle to the cell
//        NSIndexPath *path = [self.tableView indexPathForCell:cell]; // handle to the location of the cell
//        PFObject *anItem = self.regimentArray[path.row]; // handle to todoItem
//        
//        performExerciseVC.delegate = self;
//        saveRegimentVC.popoverPresentationController.delegate = self;
//        saveRegimentVC.preferredContentSize = CGSizeMake(275.0f, 165.0f);
    }
}


@end
