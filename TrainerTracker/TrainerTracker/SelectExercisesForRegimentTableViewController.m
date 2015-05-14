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
             if (self.regimentArray == nil)
             {
                 self.regimentArray = [[NSMutableArray alloc] init];
             }
             
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.regimentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegimentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"regimentsCells" forIndexPath:indexPath];
    cell.checkBoxButton.image = [UIImage imageNamed:@"Unchecked.png"];
    
    UIColor *cellColor = [UIColor colorWithRed:0.329 green:0.467 blue:0.188 alpha:1] /*#547730*/;
    UIColor *cellColor2 = [UIColor colorWithRed:0.631 green:0.761 blue:0.451 alpha:1] /*#a1c273*/;
    
    if( [indexPath row] % 2)
        [cell setBackgroundColor:cellColor];
    else
        [cell setBackgroundColor:cellColor2];

    NSString *name = [self.regimentArray[indexPath.row] objectForKey:@"exerciseName"];

    cell.regimentNameLabel.text = name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegimentTableViewCell *cell = (RegimentTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    PFObject *aRegiment = self.regimentArray[indexPath.row];
    NSString *aObjectId = aRegiment.objectId;
    if ([self.selectedExercisesArray containsObject:aObjectId])
    {
        cell.checkBoxButton.image = [UIImage imageNamed:@"Unchecked.png"];
        [self.selectedExercisesArray removeObject:aObjectId];
    }
    else
    {
        cell.checkBoxButton.image = [UIImage imageNamed:@"Checked.png"];
        [self.selectedExercisesArray addObject:aObjectId];
    }
    
    UIColor *cellColor = [UIColor colorWithRed:0.329 green:0.467 blue:0.188 alpha:1] /*#547730*/;
    UIColor *cellColor2 = [UIColor colorWithRed:0.631 green:0.761 blue:0.451 alpha:1] /*#a1c273*/;
    UIView *bgColorView = [[UIView alloc] init];
    if( [indexPath row] % 2)
        [bgColorView setBackgroundColor:cellColor];
    else
        [bgColorView setBackgroundColor:cellColor2];
    
    [cell setSelectedBackgroundView:bgColorView];

}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

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
    
    [self.tableView reloadData];
    [self.selectedExercisesArray removeAllObjects];

}

- (void)PopoverCanceled:(NSString *)regimentName
{
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [self.selectedExercisesArray removeAllObjects];
    
    [self.tableView reloadData];
}

@end
