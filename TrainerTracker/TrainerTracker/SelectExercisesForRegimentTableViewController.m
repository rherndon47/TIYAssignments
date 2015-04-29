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

- (IBAction)saveRegiment:(UIBarButtonItem *)sender;

@end

@implementation SelectExercisesForRegimentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedExercisesArray = [[NSMutableArray alloc] init];
    
    PFQuery *queryExercise = [PFQuery queryWithClassName:@"Exercise"];
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RegimentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"regimentsCells" forIndexPath:indexPath];
    
    NSString *name = [self.regimentArray[indexPath.row] objectForKey:@"exerciseName"];

    cell.regimentNameLabel.text = name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark)
    {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }else
    {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;

        PFObject *aRegiment = self.regimentArray[indexPath.row];
        NSString *aObjectId = aRegiment.objectId;
        [self.selectedExercisesArray addObject:aObjectId];
    }

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

#pragma mark - IBAction

- (IBAction)saveRegiment:(UIBarButtonItem *)sender
{
    NSLog(@"Entered SaveRegiment");
    PFObject *exerciseObject = [PFObject objectWithClassName:@"Regiments"];
    exerciseObject[@"regimentName"] = @"First Regiment";
    exerciseObject[@"objectIdArray"] = self.selectedExercisesArray;

    
    [exerciseObject saveInBackground];

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

}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

@end
