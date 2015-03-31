//
//  TodoListMainTableViewController.m
//  True Todo
//
//  Created by Apple on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TodoListMainTableViewController.h"

#import "TodoTableViewCell.h"

#import "TodoObject.h"


@interface TodoListMainTableViewController () <UITextFieldDelegate>

{
    NSMutableArray *TodoItemStore;
    UIRefreshControl *refreshControl; // ala Yelp, Twitter refresh
}

- (IBAction)ClearAll:(UIBarButtonItem *)sender;
- (IBAction)AddTodoItem:(UIBarButtonItem *)sender;
- (IBAction)checkmarkTapped:(UIButton *)sender;
- (IBAction)EditTodoCell:(UIButton *)sender;
- (IBAction)clearCompleteTodos:(UIRefreshControl *)sender;


@end

@implementation TodoListMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"Todo List";
    TodoItemStore = [[NSMutableArray alloc] init];
    
    TodoItemStore = [[NSMutableArray alloc] init];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(clearCompleteTodos:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddTodoItem:)];

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [TodoItemStore count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    
    TodoObject *item = TodoItemStore[indexPath.row];
    
    cell.descriptionTextField.text = @"";
    
//    textField.delegate = self;
    

    
    
    if (item)
    {
        if (item.todoObjectString) // equal to (todoItem.title)
        {
            [cell.descriptionTextField setText:item.todoObjectString];
        }
        else
        {
            [cell.descriptionTextField becomeFirstResponder];
        }
        [cell.checkBoxButton setSelected:item.done];
    }
   
    return cell;
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    TodoObject *item = TodoItemStore[indexPath.row];
    return item.done;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (editingStyle == UITableViewCellEditingStyleDelete) // enum
    {
        
        [TodoItemStore removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      
    }
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""])
    {
        [textField resignFirstResponder];
        rc = YES;
        
        UIView *contentView = [textField superview]; // handle to textField
        UITableViewCell *cell = (UITableViewCell *)[contentView superview]; // handle to the cell
        NSIndexPath *path = [self.tableView indexPathForCell:cell]; // handle to the location of the cell
        TodoObject *anItem = TodoItemStore[path.row]; // handle to todoItem
        anItem.todoObjectString = textField.text; // stored todoItem in TextField
    }
    
    return rc;
}


#pragma mark - Action Handlers

- (IBAction)clearCompleteTodos:(UIRefreshControl *)sender
{
    NSMutableArray *indexPathsToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *itemsToRemove = [[NSMutableArray alloc] init];
    
    for (TodoObject *anItem in TodoItemStore) // class *variable 'in' stores in array
    {
        if (anItem.done)
        {
            [itemsToRemove addObject:anItem];
            [indexPathsToRemove addObject:[NSIndexPath indexPathForRow:[TodoItemStore indexOfObject:anItem] inSection:0]];
        }
    }
    
    [TodoItemStore removeObjectsInArray:itemsToRemove];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToRemove withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [sender endRefreshing];
}


- (IBAction)ClearAll:(UIBarButtonItem *)sender
{
    [TodoItemStore removeAllObjects];
    [self.tableView reloadData];
}

- (IBAction)AddTodoItem:(UIBarButtonItem *)sender
{
    TodoObject *anItem = [[TodoObject alloc] init];
    [TodoItemStore addObject:anItem];
    
    NSUInteger row = [TodoItemStore indexOfObject:anItem];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)checkmarkTapped:(UIButton *)sender
{
    UIView *contentView = [sender superview];
    UITableViewCell *cell = (UITableViewCell *)[contentView superview];
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    TodoObject *anItem = TodoItemStore[path.row];
    anItem.done = !anItem.done;
    [sender setSelected:anItem.done];
}

- (IBAction)EditTodoCell:(UIButton *)sender
{
    
}
@end
