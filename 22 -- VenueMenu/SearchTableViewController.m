//
//  SearchTableViewController.m
//  22 -- VenueMenu
//
//  Created by Richard Herndon on 4/2/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "SearchTableViewController.h"
#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "DetailVenueViewController.h"
#import "SearchResultsVenues.h"

@import CoreLocation;

@interface SearchTableViewController () <CLLocationManagerDelegate, NSURLSessionDataDelegate>
{
    
    CLLocationManager *locationManager;
//    NSURLSessionConfiguration *configuration;
//    NSURLSession *session;
    NSMutableDictionary *citiesForActiveTasks;   // really venues (will change later)
    NSMutableDictionary *receivedDataRepos;
    NSMutableData *receivedData;
    NSMutableArray *resultsArray;
    NSMutableArray *searchObjectArray;
    BOOL markLocation;
    double lat;
    double lng;
    
}

@end

@implementation SearchTableViewController

static NSString *fourSquareBaseURL = @"https://api.foursquare.com/v2/venues/search?client_id=OWA5APW2SPIQ1MBUMZDPFW5RBK4YLKW4FS2TZBDI4ZXQSZSI&client_secret=LTCMUOBE1WUB4RDX5Z2UTZRYU14AU5WCTDY32NLRSQVMHBC4&v=20130815%20%20&ll=%F,%f,&query=%@&radius=800";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    resultsArray = [[NSMutableArray alloc] init];
    
    markLocation = NO;
    [self configureLocationManager];                // configuring location manager

    searchObjectArray = [[NSMutableArray alloc] init];

    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [resultsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultCell" forIndexPath:indexPath];
    NSString *itemList = resultsArray[indexPath.row];
    cell.resultLabel.text = itemList;
    
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailSegue"])
    {
        DetailVenueViewController *modelVC = (DetailVenueViewController *)[segue destinationViewController];

        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        SearchResultsVenues *tempSearch = searchObjectArray[path.row];
        NSLog(@"Search Seque venueName %@", tempSearch.venueName);
        
        modelVC.transferResultVenue = tempSearch;
        modelVC.cdStack = self.cdStack;
        self.fromFavView = @"searchView";
        modelVC.fromFavView = self.fromFavView;
        

    }
    
}

#pragma mark - CLLocation related methoids

- (void)configureLocationManager
{
    NSLog(@"Entering configureLocationManager %@",locationManager);
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted )
    {
        if (!locationManager)
        {
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            {
                [locationManager requestWhenInUseAuthorization];
            }
            else
            {
                [self enableLocationManager:YES];  // turning the button on
            }
        }
    }
    else
    {
        markLocation = NO;  // turning the location flag off
    }
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        markLocation = NO;  // turning the location flag off
    }
    else
    {
        [self enableLocationManager:YES];    // turning Location services on
        markLocation = YES;  // turning the location flag on
    }
}

- (void)enableLocationManager:(BOOL)enable
{
    if (locationManager)
    {
        if (enable)
        {
            [locationManager stopUpdatingLocation];  // Stop updating location manager
            [locationManager startUpdatingLocation]; // trun it back on
        }
        else
        {
            [locationManager stopUpdatingLocation];  // turn it off if not enabled
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error != kCLErrorLocationUnknown)
    {
        [self enableLocationManager:NO];
        markLocation = NO;  // turning the location flag off
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];  // get the last known location
    
    [self enableLocationManager:NO];                // turn off location manager
    lat = location.coordinate.latitude;             // get the current lat long
    lng = location.coordinate.longitude;
//    *aSearchVenue = [[SearchResultsVenues alloc] init];
    NSLog(@"lat %f lng %f", lat, lng);
    [self buildFourSquareURL];
}

#pragma mark - NSURLSession delegate

- (void)buildFourSquareURL
{
    NSString *fourSquareUrlString = [NSString stringWithFormat:fourSquareBaseURL, lat, lng, self.itemField];
    NSURL *url = [NSURL URLWithString:fourSquareUrlString];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    NSLog(@"buildFourSquareURL %@", fourSquareUrlString);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration //used more than once keep it around
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url]; //similar to above URLRequest ^
    
    [dataTask resume];
    NSLog(@"Leaving buildFourSquareURL");
 
}

//- (void)startDataTask:(NSURLSessionTask *)dataTask forsearchVenue:(SearchResultsVenues *)aSearchVenue
//{
//    [citiesForActiveTasks setObject:aSearchVenue forKey:[NSNumber numberWithInteger:dataTask.taskIdentifier]];
//    [receivedDataRepos setObject:[[NSMutableData alloc] init] forKeyedSubscript:[NSNumber numberWithInteger:dataTask.taskIdentifier]];
//    [dataTask resume];
//}



- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    NSLog(@"Entering didReceiveResponse");
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data //blob of bytes - download in pieces - recieved data but not all the data - more to come...maybe
{
    NSLog(@"Entering didReceiveData");
    if (!receivedData)
    {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }//only create an object if we need one/alloc init - don't load stuff until you need to load it
    else
    {
        [receivedData appendData:data];
    }
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error //if it didn't complete this will point to error
{
    NSLog(@"Entering didComp[leteWithError");
    if (!error)
    {
        
        NSLog(@"Download Successful."); //RCL: take out in production
        NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:receivedData
                                                                 options:0
                                                                   error:nil]; // grab user info as dictionary
//        NSArray *response = [userInfo objectForKey:@"response"];
        
        NSDictionary *response = [userInfo objectForKey:@"response"];

//        NSDictionary *firstLocation = 0;
        
        
        NSArray *venues = [response objectForKey:@"venues"];
        
//        searchObjectArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *aVenue in venues)
        {
            SearchResultsVenues *aSearchResult = [[SearchResultsVenues alloc] init];
    
            
            [resultsArray addObject: [aVenue objectForKey:@"name"]];
            aSearchResult.venueName = [aVenue objectForKey:@"name"];

            NSDictionary *location = [aVenue objectForKey:@"location"];
            aSearchResult.latitude = [[location objectForKey:@"lat"] doubleValue];
            aSearchResult.longitude = [[location objectForKey:@"lng"] doubleValue];
            
            aSearchResult.venueAddress = [location objectForKey:@"address"];
            aSearchResult.venueCity = [location objectForKey:@"city"];
            aSearchResult.state = [location objectForKey:@"state"];


            [searchObjectArray addObject:aSearchResult];

        }
        
        [self.tableView reloadData];
    }
}

@end
