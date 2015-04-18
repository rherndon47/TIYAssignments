//
//  TicketsTableViewController.m
//  Jackpot
//
//  Created by Jordan Anderson on 3/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TicketsTableViewController.h"
#import "WinningTicketViewController.h"
#import "Ticket.h"

@interface TicketsTableViewController ()
{
    NSMutableArray *tickets;
   
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;


- (IBAction)createTicket:(id)sender;


@end


@implementation TicketsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.title = @"Lottery Tickets";
    tickets = [[NSMutableArray alloc] init];
   
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
    NSLog(@"Entering Section");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    // Return the number of rows in the section.

    return [tickets count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TicketCell" forIndexPath:indexPath];
    
//    cell.textLabel.text = tickets[indexPath.row]; //grabs our ticket object from quick pick and assignins it to our array
    
    Ticket *aTicket = tickets[indexPath.row];
    cell.textLabel.text = [aTicket description];
    
//    cell.detailTextLabel.text = @""; // update later to show amount of winnings
    
    return cell;
    
    // need to fix stuff in here! update!
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
{
    if ([segue.identifier isEqualToString:@"ShowCheckTicketsSegue"])
    {
        WinningTicketViewController *textFieldVC = (WinningTicketViewController *)[segue destinationViewController];
     
        textFieldVC.delegate = self;
        
    }
}

#pragma mark - TicketsTableViewControllerDelegate

- (void)winningTicketNumbersWasChosen:(NSArray *)lottoWinningNumbers {
    
   
    
}



#pragma mark - Action Handlers

- (IBAction)createTicket:(id)sender
{
    Ticket *aTicket = [Ticket ticketUsingQuickPick]; // creates a ticket objects
    [tickets addObject:aTicket]; // when user hits + button, it will add the created ticket object to the tickets array
    [self.tableView reloadData];
    
}


@end
