//
//  RegimentTableViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 4/26/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "AddExerciseTableViewController.h"
#import "ExerciseCell.h"

@interface AddExerciseTableViewController ()

@property (strong, nonatomic) NSMutableArray *exerciseArray;


@end

@implementation AddExerciseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    //    testObject[@"foo"] = @"bar";
    //    [testObject saveInBackground];

    
    PFObject *exerciseObject = [PFObject objectWithClassName:@"Exercise"];
    exerciseObject[@"exerciseName"] = @"Bench Press";
    exerciseObject[@"exerciseNotes"] = @"Remember not to lock your elbows";
    exerciseObject[@"exerciseReps"] = @10;
    exerciseObject[@"exerciseWeight"] = @100;
    
    [exerciseObject saveInBackground];
    
    PFQuery *queryExercise = [PFQuery queryWithClassName:@"Exercise"];
    
//    [queryExercise fromLocalDatastore];
    
    [queryExercise whereKey:@"exerciseName" equalTo:@"Leg Press"];
    [queryExercise findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        if (!error)
        {
            [self.exerciseArray addObjectsFromArray:objects];
                
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
    return [self.exerciseArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     ExerciseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"exerciseCell" forIndexPath:indexPath];
    
    
    cell.exerciseNameLabel.text = @"some text";
    
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

@end
