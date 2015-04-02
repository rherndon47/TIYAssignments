//
//  StudentsTableViewController.m
//  TIY
//
//  Created by Richard Herndon on 3/31/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "StudentsTableViewController.h"
#import "CoreDataStack.h"
#import "StudentCell.h"
#import "Student.h"

static NSString * const StudentCellIdentifier = @"StudentCell";

@interface StudentsTableViewController () <UITextFieldDelegate>
{
    NSMutableArray *students;
    CoreDataStack *cdStack; // for core data
}

- (IBAction)addNewStudent:(UIBarButtonItem *)sender;

@end

@implementation StudentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerClass:[StudentCell class] forCellReuseIdentifier:StudentCellIdentifier];
    
    // setup core data stack
    cdStack = [CoreDataStack coreDataStackWithModelName:@"TIYModel"]; // use name of model created in file minus extension
    cdStack.coreDataStoreType = CDSStoreTypeSQL;  // assign type of stack
    students = [[NSMutableArray alloc] init];
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:<#animated#>];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:cdStack managedObjectContext];
//    
//    NSFetchRequest *fetch =v[[];
//                             Studets = [[cdStack.managedObjectContext executeFetchRequest:fetch error:<#(NSError *__autoreleasing *)#>]]
//                             
//}


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
    return [students count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentCell *cell = [tableView dequeueReusableCellWithIdentifier:StudentCellIdentifier forIndexPath:indexPath];

    Student *aStudent = students[indexPath.row];
    if ([aStudent.lastName isEqualToString:@""])
    {
        [cell.nameTextField becomeFirstResponder];
    }
    else
    {
        [cell.nameTextField setText:aStudent.lastName];
    }
    if (aStudent.ageValue == 0)
    {
        [cell.ageTextField becomeFirstResponder];
    }
    else
    {
        [cell.ageTextField setText:[NSString stringWithFormat:@"%d",aStudent.ageValue]];
    }
        
    
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

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField;

{
    BOOL rc = NO;
    UIView *contentView = [textField superview];
    StudentCell *cell = (StudentCell *)[contentView superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    Student *aStudent = students[indexPath.row];
    
    if ([textField.text isEqualToString:@""])
    {
        rc = YES;
        if ([textField.placeholder isEqualToString:@"age"])
        {
            [cell.nameTextField becomeFirstResponder];
            
        }
        else
        {
            aStudent.lastName = textField.text;
            aStudent.ageValue = 0;
            [textField resignFirstResponder];
            [self saveCoreDataUpdates];
        }
    }
    return rc;
}

#pragma mark - Action Handlers

- (IBAction)addNewStudent:(UIBarButtonItem *)sender
{
    // adding a new student to core data
    Student *aStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:cdStack.managedObjectContext];
    [students addObject:aStudent];
    NSInteger index = [students indexOfObject:aStudent];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mar - private methods

- (void)saveCoreDataUpdates
{
    [cdStack saveOrFail:^(NSError *errorOrNil)
    {
        if (errorOrNil)
        {
            NSLog(@"Error from CDStack: %@", [errorOrNil localizedDescription]);
        }
    }];
}

@end
