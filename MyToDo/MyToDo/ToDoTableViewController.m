//
//  ToDoTableViewController.m
//  MyToDo
//
//  Created by Richard Herndon on 3/16/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "ToDoTableViewController.h"

#import "ToDoTableViewCell.h"

#import "ToDoItem.h"



@interface ToDoTableViewController () <UITextFieldDelegate>
{
    NSMutableArray *todoTaskData;
    UIRefreshControl *refreshControl;
}

- (IBAction)addTaskItemButton:(UIBarButtonItem *)sender;
- (IBAction)clearTasksButton:(UIBarButtonItem *)sender;
- (IBAction)checkmarkTapped:(UIButton *)sender;

@end

@implementation ToDoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Todo";
    todoTaskData = [[NSMutableArray alloc] init];
    refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self action:@selector(clearCompleteTodos:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTodoItem:)];
    
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
    NSLog(@"TableView section");
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [todoTaskData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    
    NSLog(@"UITableViewCell");
    
    ToDoItem *todoItem = todoTaskData[indexPath.row];
    
//    cell.descriptionTextField.text = @"";
    
    UITextField *textField = (UITextField *)[cell viewWithTag:1];
    UIButton *checkboxButton = (UIButton *)[cell viewWithTag:2];
    
    textField.text = @"";
    
    if (todoItem.title)
    {
        textField.text = todoItem.title;
    }
    else
    {
        [textField becomeFirstResponder];
    }
    [checkboxButton setSelected:todoItem.done];
    
//    
//    
//    todoTaskData[indexPath.row] = @"Data";
//    cell.textLabel.text = self->todoTaskData[indexPath.row];
//    [self.tableView reloadData];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    ToDoItem *item = todoTaskData[indexPath.row];
    return item.done;

}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        [todoTaskData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
  
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"TableView cellCheck1");
//    UITableViewCell* cellCheck = [tableView
//                                  cellForRowAtIndexPath:indexPath];
//    cellCheck.accessoryType = UITableViewCellAccessoryCheckmark;
//
//}
//
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"TableView cellCheck2");
////        UITableViewCell* cellCheck = [tableView
////                                      cellForRowAtIndexPath:indexPath];
////        cellCheck.accessoryType = UITableViewCellAccessoryCheckmark;
//    UITableViewCell* uncheckCell = [tableView
//                                    cellForRowAtIndexPath:indexPath];
//    uncheckCell.accessoryType = UITableViewCellAccessoryNone;
//}

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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""])
    {
        [textField resignFirstResponder];
        
        
        UIView *contentView = [textField superview];
        UITableViewCell *cell = (UITableViewCell *)[contentView superview]; 
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        ToDoItem *anItem = todoTaskData[path.row];
        
// help here
        anItem.title = textField.text;
        
        rc = YES;
    }
    
    
    return rc;
}

#pragma mark - IBAction

- (IBAction)addTaskItemButton:(UIBarButtonItem *)sender
{
    NSLog(@"Entered addTaskItemButton");
    ToDoItem *anItem = [[ToDoItem alloc] init];
    [todoTaskData addObject:anItem];
    [self.tableView reloadData];

}

- (IBAction)checkmarkTapped:(UIButton *)sender
{
    
}


- (IBAction)clearTasksButton:(UIBarButtonItem *)sender
{
    NSLog(@"Entering clearTasks");
    [todoTaskData removeAllObjects];
    NSLog(@"array %@", todoTaskData);
    [self.tableView reloadData];
}

@end
