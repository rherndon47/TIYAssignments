//
//  FavVenueTableViewController.m
//  22 -- VenueMenu
//
//  Created by Richard Herndon on 4/2/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "FavVenueTableViewController.h"
#import "CoreDataStack.h"
#import "SearchViewController.h"
#import "DetailVenueViewController.h"
#import "Venue.h"
#import "ItemViewCell.h"
@import CoreLocation;
@import MapKit;

@interface FavVenueTableViewController ()
{
    NSMutableArray *favVenuesArray;
    CoreDataStack *cdStack;
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    NSString *fromFavView;
}

@end

@implementation FavVenueTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Initialize coredata 
    cdStack = [CoreDataStack coreDataStackWithModelName:@"VenueMenuModel"];
    cdStack.coreDataStoreType = CDSStoreTypeSQL;
    
    self.title = @"Favorite Venues";
    
    favVenuesArray = [[NSMutableArray alloc] init];
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
    return [favVenuesArray count];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:cdStack.managedObjectContext];
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    fetch.entity = entity;
    
    favVenuesArray = nil;
    favVenuesArray = [[cdStack.managedObjectContext executeFetchRequest:fetch error:nil] mutableCopy];
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];

    Venue *itemList = favVenuesArray[indexPath.row];
    
    cell.itemLabel.text = itemList.venueName;
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"%ld", (long)indexPath.row); // you can see selected row number in your console;
//}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Venue *aVenue = [favVenuesArray objectAtIndex:indexPath.row];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    DetailVenueViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailResultView"];
    fromFavView = @"favView";
    detailVC.fromFavView = fromFavView;
    detailVC.xferResultVenue = aVenue;
    NSLog(@"aVenue.lat %@",aVenue.venueLat);
    NSLog(@"aVenue.lat %f",aVenue.venueLatValue);
    
    //    detailVC.cdStack = self.cdStack;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    NSLog(@"%@",aVenue);
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        [cdStack.managedObjectContext deleteObject:favVenuesArray[indexPath.row]];
        
        [self saveCoreDataUpdates];
        [favVenuesArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert)
        {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
}

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

//- (IBAction)addNewItem:(UIBarButtonItem *)sender
//{
//    ListItem *aItem = [NSEntityDescription insertNewObjectForEntityForName:@"ListItem" inManagedObjectContext:cdStack.managedObjectContext];
//    [itemsArray addObject:aItem];
//    NSInteger index = [itemsArray indexOfObject:aItem];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SearchVenueSegue"])
    {
        SearchViewController *modelVC = (SearchViewController *)[segue destinationViewController];

        modelVC.cdStack = cdStack;
    }
    
}
@end

