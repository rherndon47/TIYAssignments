//
//  HighVoltageTableViewController.m
//  HighVoltage
//
//  Created by Richard Herndon on 3/12/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "HighVoltageTableViewController.h"
#import "PopUpTableViewController.h"
#import "HVCalculation.h"

@interface HighVoltageTableViewController () <UITextFieldDelegate, UIPopoverPresentationControllerDelegate, PopupReturnDelegate>
{
    NSMutableArray *hvArray;
    NSString *itemFromPopupModal;
    NSDictionary *stringWithCellIdentifierDict;
}

@end

@implementation HighVoltageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    hvArray = [[NSMutableArray alloc] init];
    
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


    return [hvArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[hvArray objectAtIndex:indexPath.row] forIndexPath:indexPath];
    
    
    return cell;
}
 

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HVPopUpSegue" forIndexPath:indexPath];
    
    HVCalculation *item = hvArray[indexPath.row];
    UITextField *textField = (UITextField *)[cell viewWithTag:1];
    UILabel *priorityLabel = (UILabel *)[cell viewWithTag:2];
    
    textField.delegate = self;
    
    if (item)
    {
        if (item.highVoltageName)
        {
            [textField setText:item.highVoltageName];
        }
        else
        {
            [textField becomeFirstResponder];
        }
        
        priorityLabel.text = [item energyTypeAsString];
    }
    
    
    return cell;
}
 */

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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

        if ([segue.identifier isEqualToString:@"HVPopUpSegue"])
        {
            PopUpTableViewController *destVC = (PopUpTableViewController *)[segue destinationViewController];
            destVC.popoverPresentationController.delegate = self;
            destVC.delegate = self;
            NSArray *EngergyType = [HVCalculation allEnergyTypes];
            float contentHeight = 44.0f * ([EngergyType count]+1);
            destVC.preferredContentSize = CGSizeMake(100.0f, contentHeight);
        }
    
}

#pragma mark - Popup Delegation Delegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    NSLog(@"Entered HV popup delegaton");
    return UIModalPresentationNone;
}

- (void)energyTypeWasSelected:(NSString *)energyString
{
    NSLog(@"%@", energyString);
    
    stringWithCellIdentifierDict = @{@"Watts":@"PowerIdentifier",@"Volts":@"ElectricPotentialIdentifier",@"amps":@"CurrentIdentifier",@"ohms":@"ResistanceIdentifier"};
    
    [hvArray addObject:[stringWithCellIdentifierDict objectForKey:energyString]];
    

    [self dismissViewControllerAnimated:YES completion:nil];

    [self.tableView reloadData];

}

#pragma mark - IBAction

//- (IBAction)addEnergyToArrayItem:(UIBarButtonItem *)sender
//{
//    NSLog(@"Entered HV addTodoItem");
//    HVCalculation *anItem = [[HVCalculation alloc] init];
//    [hvArray addObject:anItem];
//}
//
//- (IBAction)createTicket:(id)sender
//{
//    Ticket *aTicket = [Ticket ticketUsingQuickPick]; // creates a ticket objects
//    [tickets addObject:aTicket]; // when user hits + button, it will add the created ticket object to the tickets array
//    [self.tableView reloadData];
//    
//}

@end
