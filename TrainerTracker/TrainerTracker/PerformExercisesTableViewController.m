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
    
    self.exerciseArray = [[NSMutableArray alloc] init];
    
    NSLog(@"Entering ViewDidLoad %@",self.passedPFObject);
    
    self.navigationItem.title = self.passedPFObject[@"regimentName"];
    
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"All" style:UIBarButtonItemStylePlain target:self action:@selector(performAllExercises)];
    
    [self.tableView registerClass: [PerformExerciseTableViewCell class] forCellReuseIdentifier:@"ExerciseCell"];
    
    [self getExerciseNames];

    
        
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark = Perform all Exercises

-(void)performAllExercises
{
    NSLog(@"Entered performAllExercises");
    PerformDetailViewController *destVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"performDetailView"];
    destVC.allOrOneParameter = @"all";
    destVC.passedPFObject = self.passedPFObject;
    
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
    
    UIColor *cellColor = [UIColor colorWithRed:0.561 green:0.706 blue:0.82 alpha:1]; /*#8fb4d1*/
    UIColor *cellColor2 = [UIColor colorWithRed:0.451 green:0.569 blue:0.776 alpha:1]; /*#7391c6*/
    
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
    destVC.allOrOneParameter = @"one";
    
    [self.navigationController pushViewController:destVC animated:YES];
    
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
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"performExerciseSeque"])
//    {
//        PerformDetailViewController *destVC = (PerformDetailViewController *)[segue destinationViewController];
//        
//        destVC.passedPFObject = self.passedPFObject;
//        
////        destVC.delegate = self;
//        //        [self.navigationController pushViewController:destVC animated:YES];
//        
//    }
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}


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
        }
        [self.tableView reloadData];
    }];
    
}

@end
