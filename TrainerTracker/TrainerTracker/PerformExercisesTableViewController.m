//
//  PerformExercisesTableViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 4/29/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "PerformExercisesTableViewController.h"
#import "PerformExerciseTableViewCell.h"

@interface PerformExercisesTableViewController ()

@property (strong, nonatomic) NSMutableArray *exerciseArray;

@end

@implementation PerformExercisesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.exerciseArray = [[NSMutableArray alloc] init];
    
    NSLog(@"Entering ViewDidLoad %@",self.passedPFObject);
    
    self.navigationItem.title = self.passedPFObject[@"regimentName"];
    
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
    
    
//    NSString *name = [self.exerciseArray[indexPath.row] objectForKey:@"regimentName"];
    
//    cell.performExerciseNameLabel.text = self.exerciseArray[indexPath.row];
    cell.textLabel.text = self.exerciseArray[indexPath.row];
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)getExerciseNames
{
    NSMutableArray *exerciseObjectIds = self.passedPFObject[@"objectIdArray"];
    PFQuery *query = [PFQuery queryWithClassName:@"Exercise"];
    
    NSString *queryObjectId = exerciseObjectIds[0];
    [query getObjectInBackgroundWithId:queryObjectId block:^(PFObject *aExercise, NSError *error) {
        // Do something with the returned PFObject in the aExercise variable.
        NSLog(@"aExercise %@", aExercise);
        NSString *aName = aExercise[@"exerciseName"];
        NSLog(@"aName %@",aName);
        self.exerciseArray[0] = aName;
        [self.tableView reloadData];
    }];
    
//    self.exerciseArray = self.passedPFObject[@"objectIDArray"];
}

- (void)passDataBack
{
    if ([_delegate respondsToSelector:@selector(dataFromController:)])
    {
        [_delegate dataFromController:@"This data is from the second view controller."];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
