//
//  DetailVenueViewController.m
//  22 -- VenueMenu
//
//  Created by Richard Herndon on 4/2/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "DetailVenueViewController.h"
#import "SearchResultsVenues.h"
#import "SearchTableViewController.h"
#import "FavVenueTableViewController.h"
#import "CoreDataStack.h"
#import "AnnotationMapCoordinates.h"
#import "Venue.h"

@import CoreLocation;
@import MapKit;

#define MAP_DISPLAY_SCALE 0.5 * 1609.344  // 1609.344 meters in mile .5 means half a mile

@interface DetailVenueViewController ()

@property (strong, nonatomic) IBOutlet UILabel *venueName;
@property (strong, nonatomic) IBOutlet UILabel *venueStreet;
@property (strong, nonatomic) IBOutlet UILabel *venuecity;
@property (strong, nonatomic) IBOutlet UILabel *venueState;

@property (nonatomic) CLLocationCoordinate2D searchCoordinate;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)saveVenueData:(UIBarButtonItem *)sender;

@end

@implementation DetailVenueViewController
{
//    CoreDataStack *cdStack;
//    CLLocationManager *locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentMapCoordinates = [[AnnotationMapCoordinates alloc] init];

    // read in Venue data passed by reference via transferResultVenue
    if ([self.fromFavView isEqualToString:@"favView"])
    {
        NSLog(@"viewdidload favView");
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.venueName.text = self.xferResultVenue.venueName;
        self.venueStreet.text = self.xferResultVenue.venueStreet;
        self.venuecity.text = self.xferResultVenue.venueCity;
        self.venueState.text = self.xferResultVenue.venueState;
        
        self.currentMapCoordinates.latitude = self.xferResultVenue.venueLatValue;
        self.currentMapCoordinates.longitude = self.xferResultVenue.venueLngValue;
        self.searchCoordinate = CLLocationCoordinate2DMake(self.xferResultVenue.venueLatValue, self.xferResultVenue.venueLngValue);
    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        NSLog(@"DetailVenue venueName %@",self.transferResultVenue.venueName);
        self.venueName.text = self.transferResultVenue.venueName;
        self.venueStreet.text = self.transferResultVenue.venueAddress;
        self.venuecity.text = self.transferResultVenue.venueCity;
        self.venueState.text = self.transferResultVenue.state;
        self.currentMapCoordinates.latitude = self.transferResultVenue.latitude;
        self.currentMapCoordinates.longitude = self.transferResultVenue.longitude;
        
        self.searchCoordinate = CLLocationCoordinate2DMake(self.transferResultVenue.latitude, self.transferResultVenue.longitude);
    }
    
    [self configureMapView];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Map methods

- (void)configureMapView
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.searchCoordinate, MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
    [self.mapView setRegion:viewRegion];  // where map goes
    [self.mapView addAnnotation:self.currentMapCoordinates];  // tells mapkit where to place pin
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
//    if ([annotation isKindOfClass:[City class]])
//    {
        static NSString * const identifier = @"CityAnnotation";
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView)
        {
            annotationView.annotation = annotation;
        }
        else
        {
            annotationView  = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        
        annotationView.canShowCallout = YES;
        return annotationView;
//    }
    return nil;
}

#pragma mark - Private methods

- (IBAction)saveVenueData:(UIBarButtonItem *)sender
{
    Venue *aItem = [NSEntityDescription insertNewObjectForEntityForName:@"Venue" inManagedObjectContext:self.cdStack.managedObjectContext];

    
    aItem.venueName = self.transferResultVenue.venueName;
    aItem.venueStreet = self.transferResultVenue.venueAddress;
    aItem.venueCity = self.transferResultVenue.venueCity;
    aItem.venueState = self.transferResultVenue.state;
    aItem.venueLatValue = self.transferResultVenue.latitude;
    aItem.venueLngValue = self.transferResultVenue.longitude;
    
    
        [self saveCoreDataUpdates];

        [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void)saveCoreDataUpdates
{
    [self.cdStack saveOrFail:^(NSError *errorOrNil)
     {
         if (errorOrNil)
         {
             NSLog(@"Error from CDStack: %@", [errorOrNil localizedDescription]);
         }
         
     }];
}

@end
