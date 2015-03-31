//
//  ToDoDetailTableViewController.m
//  True Todo
//
//  Created by Richard Herndon on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ToDoDetailTableViewController.h"
#import "DueDatePickerViewController.h"
#import "POIResultsTableViewController.h"
#import "TodoObject.h"

@interface ToDoDetailTableViewController () <UITextFieldDelegate,UITextViewDelegate,CLLocationManagerDelegate>
{
    NSDateFormatter *formatTime;
    CLLocationManager *locationManager;
    MKLocalSearch *localSearch;
    CLGeocoder *geocoder;
}

@property (weak, nonatomic) IBOutlet UILabel *destinationTimeLabel;
@property (strong, nonatomic) IBOutlet UITextField *taskName;
@property (strong, nonatomic) IBOutlet UITextField *poiSearch;
@property (strong, nonatomic) IBOutlet UITextView *tasknotes;


- (IBAction)deleteTask:(id)sender;
- (IBAction)selectNotes:(id)sender;

@end

@implementation ToDoDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"Entering ToDoDetail viewDidLoad");
    
    ToDoDetailTableViewController *textViewVC = (ToDoDetailTableViewController *)textViewVC;
    textViewVC.delegate = self;

    
    formatTime = [[NSDateFormatter alloc] init];
    
    NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"MMMddyyyy"
                                                             options:0
                                                              locale:[NSLocale currentLocale]];
    [formatTime setDateFormat:formatString];
    self.destinationTimeLabel.text = [formatTime stringFromDate:[NSDate date]]; // [NSDate date] gives you current date
    
    self.taskName.text = self.detailTodoObject.todoObjectString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DueDatePickerDelegate

- (void)dueDateWasChosen:(NSDate *)dueDate
{
    NSLog(@"Entering ToDoDetail dueDateWasChosen");
    //
    //  The dueDate Label needs to be set to the destination date using our date formatter object
    //
    self.destinationTimeLabel.text = [formatTime stringFromDate:dueDate];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"ToDoDetail prepareForSeque");
    if ([segue.identifier isEqualToString:@"DatePickerSegue"])
    {
        DueDatePickerViewController *datePickerVC = (DueDatePickerViewController *)[segue destinationViewController];
        datePickerVC.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"POIResults"])
    {
        UINavigationController  *navC = [segue destinationViewController];
        POIResultsTableViewController *poiVC = [navC viewControllers][0];
        poiVC.locationsArray = self.results.mapItems;
        poiVC.aTask = self.detailTodoObject;
    
        NSLog(@"leaving segue");
    }
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"Entering textFieldShouldReturn");
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""] || [textField.text isEqualToString:@""])
    {
        if (textField == self.enterLocationTextField && ![textField.text isEqualToString:@""])
        {
            [self configureLocationManager];
        }
        [textField resignFirstResponder];
        rc = YES;
    }
    return rc;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"Entering textViewShouldReturn");
    BOOL *rc;
    NSArray* components = [text componentsSeparatedByString:@"\n"];
    if ([text isEqualToString:@"\n"])
    {
        NSString* commandText = [components lastObject];
        // and optionally clear the text view and hide the keyboard...
        self.detailTodoObject.taskNotes = textView.text;
        [textView resignFirstResponder];
        NSLog(@"taskNotes %@",self.detailTodoObject.taskNotes);
    }
    return rc;
}

#pragma mark - IBAction methods

- (IBAction)deleteTask:(id)sender
{
    
}

- (IBAction)selectNotes:(id)sender
{
    NSLog(@"Entering selectNotes");
}

#pragma mark - LocationManager methods


- (void)configureLocationManager
{
    NSLog(@"entering Detail location config Manager ");
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted)
    {
        if (!locationManager)
        {
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            {
                [locationManager requestWhenInUseAuthorization];
            }
            else
            {
                [self enableLocationManager:YES];
            }
        }
    }
    else
    {
        NSLog(@"Error in Location manager %@",locationManager);
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        
    }
    else
    {
        [self enableLocationManager:YES];
    }
}

- (void)enableLocationManager:(BOOL)enable
{
    if (locationManager)
    {
        if (enable) {
            [locationManager stopUpdatingLocation];
            [locationManager startUpdatingLocation];
        }
        else
        {
            [locationManager stopUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error != kCLErrorLocationUnknown)
    {
        [self enableLocationManager:NO];
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self enableLocationManager:NO];
    
    CLLocation *location = [locations lastObject];
    
    MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(location.coordinate, 1500.00, 1500.00);
    
    [self performSearch:userLocation];
}

-(void)performSearch:(MKCoordinateRegion)aRegion
{
    NSLog(@"entering performSearch");
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = self.enterLocationTextField.text;
    request.region = aRegion;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (error != nil) {
            [[[UIAlertView alloc] initWithTitle:@"Map Error"
                                        message:[error localizedDescription]
                                       delegate:nil
                              cancelButtonTitle:@"OK"otherButtonTitles:nil] show];
            return;
        }
        if ([response.mapItems count] == 0) {
            [[[UIAlertView alloc] initWithTitle:@"No Results"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"otherButtonTitles:nil] show];
            return;
        }
        self.results = response;
    }];
}

@end
