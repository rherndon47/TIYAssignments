//
//  PerformExercisesTableViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 4/29/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "PerformExercisesTableViewController.h"
#import "PerformExerciseTableViewCell.h"
#import "PerformDetailViewController.h"

@interface PerformExercisesTableViewController () <UITextFieldDelegate, PerformDetailDelegate>

@property (strong, nonatomic) NSMutableArray *exerciseArray;

@end

@implementation PerformExercisesTableViewController
{
    PFQuery *query;
    NSMutableArray *exerciseObjectIds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.64 green:0.67 blue:0.70 alpha:1.0];
    
    self.exerciseArray = [[NSMutableArray alloc] init];
    self.passedExerciseObjectsArray = [[NSMutableArray alloc] init];
    self.passedExerciseIndex = 0;
    
    self.navigationItem.title = self.passedPFObject[@"regimentName"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"All" style:UIBarButtonItemStylePlain target:self action:@selector(performAllExercises)];
    
    [self.tableView registerClass: [PerformExerciseTableViewCell class] forCellReuseIdentifier:@"ExerciseCell"];
    
    [self getExerciseNames];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
}

#pragma mark = Perform all Exercises

-(void)performAllExercises
{
    // user has clicked on the all button and wants to view each individual exercise without coming back to the table view
    
    NSLog(@"Entered performAllExercises");
    PerformDetailViewController *destVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"performDetailView"];
    self.passedExerciseIndex = 0;
    destVC.allOrOneParameter = @"all";  // Telling PerformDetailView to perform all of the exercises in passedPFObjectArray
    destVC.passedPFObject = self.passedPFObject;
    destVC.passedExerciseIndex = self.passedExerciseIndex;
    destVC.passedExerciseObjectsArray = self.passedExerciseObjectsArray;
    
    [self.navigationController pushViewController:destVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.exerciseArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PerformExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExerciseCell" forIndexPath:indexPath];
    
    UIColor *cellColor = [UIColor colorWithRed:0.64 green:0.67 blue:0.70 alpha:1.0];
    UIColor *cellColor2 = [UIColor colorWithRed:0.58 green:0.62 blue:0.65 alpha:1.0];
    
//    UIColor *cellColor = [UIColor colorWithRed:0.561 green:0.706 blue:0.82 alpha:1]; /*#8fb4d1*/
//    UIColor *cellColor2 = [UIColor colorWithRed:0.451 green:0.569 blue:0.776 alpha:1]; /*#7391c6*/
    if( [indexPath row] % 2)
        [cell setBackgroundColor:cellColor];
    else
        [cell setBackgroundColor:cellColor2];

    cell.textLabel.text = self.exerciseArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Cellid %@",cell.reuseIdentifier);
    
    PerformDetailViewController *destVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"performDetailView"];
    destVC.passedPFObject = self.exerciseArray[indexPath.row];
    destVC.passedExerciseObjectsArray = self.passedExerciseObjectsArray;
    destVC.passedExerciseIndex = indexPath.row;
    destVC.allOrOneParameter = @"one";  // telling PerformDetailView to only perform this one exercise
    
    [self.navigationController pushViewController:destVC animated:YES];
}

#pragma mark - getExerciseNames

- (void)getExerciseNames
{

    exerciseObjectIds = self.passedPFObject[@"objectIdArray"];
    query = [PFQuery queryWithClassName:@"Exercise"];

    [query whereKey:@"objectId" containedIn:exerciseObjectIds];

    [query findObjectsInBackgroundWithBlock:^(NSArray *result, NSError *error)

    {
        // Getting the exercise names for the passed Regiment.
    
        NSLog(@"aExercise %@", result);
        for (int i =0; i < [result count]; i++)
        {
            PFObject *aExercise = result[i];
            NSString *aName = aExercise[@"exerciseName"];
            NSLog(@"aName %@",aName);
            self.exerciseArray[i] = aName;
            self.passedExerciseObjectsArray[i] = result[i];
        }
        [self.tableView reloadData];
    }];
    
}

@end
