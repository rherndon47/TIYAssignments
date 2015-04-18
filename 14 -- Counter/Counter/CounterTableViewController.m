//
//  CounterTableViewController.m
//  Counter
//
//  Created by Richard Herndon on 3/17/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "CounterTableViewController.h"

#import "CounterTableViewCell.h"

#import "CounterItem.h"


@interface CounterTableViewController () <UITextFieldDelegate>
{
    NSMutableArray *counterItemsArray;
    UIRefreshControl *refreshControl;
    int numberCounter;
}

- (IBAction)addCounterItemButton:(UIBarButtonItem *)sender;
- (IBAction)clearAllCountersButton:(UIBarButtonItem *)sender;
- (IBAction)addToCounterTapped:(UIButton *)sender;
- (IBAction)subtractFromCounterTapped:(UIButton *)sender;

@end

@implementation CounterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Counters";
    
    numberCounter = 0;
    
    counterItemsArray = [[NSMutableArray alloc] init];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(clearAllCountersButton:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCounterItemButton:)];
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
    return [counterItemsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Entering callforRowatIndex");

    CounterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCounterCell" forIndexPath:indexPath];
    
    CounterItem *countItem = counterItemsArray[indexPath.row];
    
    // Reset textfield/button values in case of cell reuse
    
    cell.counterNameTextField.text = @"";
    
    if (countItem.title)
    {
        cell.counterNameTextField.text = countItem.title;
        cell.displayCounterLabel.text = [NSString stringWithFormat:@"%i", numberCounter];
//        cell.counterTracker.label = countItem.counterTracker;
    }
    else
    {
        [cell.counterNameTextField becomeFirstResponder];
    }
    
//    {
//        if (item.counterObjectString)
//    {
//        [cell.counterNameTextField setText:item.counterObjectString];
//    }
//    else
//    {
//        cell.counterNameTextField becomeFirstResponder];
//    }
//    }
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Entering canEditRow");
    // Return NO if you do not want the specified item to be editable.
    CounterItem *item = counterItemsArray[indexPath.row];
//    counterNameTextField
    return item.done;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Entering committEdit");
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        [counterItemsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
//    else if (editingStyle == UITableViewCellEditingStyleInsert)
//    {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}


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

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    NSLog(@"Entering field should return textfield is %@",textField.text);
    if (![textField.text isEqualToString:@""])
    {
        [textField resignFirstResponder];
        rc = YES;
        
        UIView *contentView = [textField superview];
        UITableViewCell *cell = (UITableViewCell *)[contentView superview];
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        CounterItem *anItem = counterItemsArray[path.row];
        anItem.title = textField.text;
        anItem.counterTracker = numberCounter;
        NSLog(@"Leaving If Field Should Return title %@ array %@ count %d", anItem.title, counterItemsArray, numberCounter);
    }
    
    return rc;
}

#pragma mark - Action Handlers


- (IBAction)addCounterItemButton:(UIBarButtonItem *)sender
{
    CounterItem *anItem = [[CounterItem alloc] init];
    [counterItemsArray addObject:anItem];
    [self.tableView reloadData];
    NSLog(@"Entered addCounter %@", counterItemsArray);
}

- (IBAction)clearAllCountersButton:(UIRefreshControl *)sender
{
    NSLog(@"Entering clearAllCounters");
    NSMutableArray *indexPathsToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *itemsToRemove = [[NSMutableArray alloc] init];
    
    numberCounter = 0;

    for (CounterItem *anItem in counterItemsArray)
    {
        if (anItem.done)
        {
            [itemsToRemove addObject:anItem];
            [indexPathsToRemove addObject:[NSIndexPath indexPathForRow:[counterItemsArray indexOfObject:anItem] inSection:0]];
        }
    }
    
    [counterItemsArray removeObjectsInArray:itemsToRemove];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToRemove withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadData];
    
    [sender endRefreshing];
}

- (IBAction)addToCounterTapped:(UIButton *)sender
{
    NSLog(@"Entering addToCounter");
    numberCounter++;
    [self.tableView reloadData];
}

- (IBAction)subtractFromCounterTapped:(UIButton *)sender
{
    NSLog(@"Entering subtractFromCounter");
    if (numberCounter > 0)
    {
    numberCounter--;
    }
    
    [self.tableView reloadData];
}
@end
