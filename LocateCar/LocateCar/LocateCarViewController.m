//
//  LocateCarViewController.m
//  LocateCar
//
//  Created by Richard Herndon on 3/25/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "LocateCarViewController.h"
#import "PinModel.h"

@import CoreLocation;
@import MapKit;
@import AddressBook;

#define MAP_DISPLAY_SCALE 0.5 * 1609.344  // 1609.344 meters in mile .5 means half a mile
#define kCarKey @"car"

@interface LocateCarViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    NSMutableArray *car;

}


- (IBAction)markLocation:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) PinModel *pinModel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *markLocation;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;

@end

@implementation LocateCarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadCarData];
    if  (!self.pinModel)
    {
        [self configureLocationManager];
    }
    else
    {
        [self configureMapView];
        [self addAnnotation];
    }
//

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addAnnotation
{
    [self.mapView addAnnotation:self.pinModel]; 
}

- (void)loadCarData
{
    NSData *carData = [[NSUserDefaults standardUserDefaults] objectForKey:kCarKey];kCarKey;
    if (carData)
    {
        self.pinModel = [NSKeyedUnarchiver unarchiveObjectWithData:carData];
        NSLog(@"car %@",car);
    }
    else
    {
        self.pinModel = nil;
    }
}

- (void)saveCarLocationData
{
    NSData *carData = [NSKeyedArchiver archivedDataWithRootObject:self.pinModel];
    [[NSUserDefaults standardUserDefaults] setObject:carData forKey:kCarKey];
}

#pragma mark IBAction

- (IBAction)markLocation:(UIBarButtonItem *)sender
{
    [self.mapView addAnnotation:self.pinModel];  // tells mapkit where to place pin
    self.pinModel.comment = self.commentTextField.text;
    NSLog(@"textFiewld %@", self.commentTextField.text);
    [self.commentTextField resignFirstResponder];
    [self saveCarLocationData];
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
                [self enableLocationManager:YES];
            }
        }
    }
    else
    {
        [self.markLocation setEnabled:NO];
    }
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.markLocation setEnabled:NO];
    }
    else
    {
        [self enableLocationManager:YES];
        [self.markLocation setEnabled:YES];
    }
}

- (void)enableLocationManager:(BOOL)enable
{
    if (locationManager)
    {
        if (enable)
        {
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
        [self.markLocation setEnabled:NO];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];

    [self enableLocationManager:NO];
    double lat = location.coordinate.latitude;
    double lng = location.coordinate.longitude;
    NSLog(@"lat %f lng %f", lat, lng);
    [self.markLocation setEnabled:YES];
    self.pinModel = [[PinModel alloc] initWithLatLng:(double)lat andlongitude:(double)lng];
    [self configureMapView];
}

- (void)configureMapView
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([self.pinModel coordinate], MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
    [self.mapView setRegion:viewRegion];  // where map goes
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[PinModel class]])
    {
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
    }
    return nil;
}

@end
