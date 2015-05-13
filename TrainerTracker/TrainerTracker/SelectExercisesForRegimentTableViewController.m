//
//  SelectExercisesForRegimentTableViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 4/28/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "SelectExercisesForRegimentTableViewController.h"
#import "RegimentTableViewCell.h"
#import "SaveRegimentPopoverViewController.h"

@interface SelectExercisesForRegimentTableViewController () <UITextFieldDelegate,UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) NSMutableArray *regimentArray;
@property (strong, nonatomic) NSMutableArray *selectedExercisesArray;


@end

@implementation SelectExercisesForRegimentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedExercisesArray = [[NSMutableArray alloc] init];
    

    [self readInRegimentData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)readInRegimentData
{
    PFQuery *queryExercise = [PFQuery queryWithClassName:@"Exercise"];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.regimentArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RegimentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"regimentsCells" forIndexPath:indexPath];
    
//    UIColor *cellColor = [UIColor colorWithRed:0.451 green:0.82 blue:0.408 alpha:1]; /*#73d168*/
//    UIColor *cellColor2 = [UIColor colorWithRed:0.322 green:0.796 blue:0.412 alpha:1]; /*#52cb69*/
    
    UIColor *cellColor = [UIColor colorWithRed:0.329 green:0.467 blue:0.188 alpha:1] /*#547730*/;
    UIColor *cellColor2 = [UIColor colorWithRed:0.631 green:0.761 blue:0.451 alpha:1] /*#a1c273*/;

    
    if( [indexPath row] % 2)
        [cell setBackgroundColor:cellColor];
    else
        [cell setBackgroundColor:cellColor2];
    
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark)
    {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }

    
    NSString *name = [self.regimentArray[indexPath.row] objectForKey:@"exerciseName"];

    cell.regimentNameLabel.text = name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark)
    {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;

        PFObject *aRegiment = self.regimentArray[indexPath.row];
        NSString *aObjectId = aRegiment.objectId;
        [self.selectedExercisesArray addObject:aObjectId];
    }

}

//- (void)clearCheckmarks
//{
//    int i = 0;
//    for (NSString * in self.regimentArray)
//    {
//        [UITableView cellForRowAtIndexPath:i].accessoryType = UITableViewCellAccessoryNone;
//
//    }
//}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"saveRegimentPopoverSeque"])
    {
        SaveRegimentPopoverViewController *saveRegimentVC = (SaveRegimentPopoverViewController *)[segue destinationViewController];
        saveRegimentVC.delegate = self;
        saveRegimentVC.popoverPresentationController.delegate = self;
        saveRegimentVC.preferredContentSize = CGSizeMake(275.0f, 165.0f);
    }
}

#pragma mark - RegimentNamePopoverViewController delegate

- (void)RegimentNameWasChosen:(NSString *)regimentName
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"Entered RegimentNameWasChosen");
    PFObject *exerciseObject = [PFObject objectWithClassName:@"Regiments"];
    exerciseObject[@"regimentName"] = regimentName;
    exerciseObject[@"objectIdArray"] = self.selectedExercisesArray;
    
    [exerciseObject saveInBackground];
    
    [self readInRegimentData];
    
    [self.tableView reloadData];
//    [self.selectedExercisesArray removeAllObjects];

}

- (void)PopoverCanceled:(NSString *)regimentName
{
    NSLog(@"PopoverCanceled");
    [self dismissViewControllerAnimated:NO completion:nil];
    [self readInRegimentData];
}

@end
