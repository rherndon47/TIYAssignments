//
//  CitySearchViewController.m
//  Forecaster
//
//  Created by Ben Gohlke on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CitySearchViewController.h"
#import "City.h"
#import "NetworkManager.h"

@import CoreLocation;
@import MapKit;
@import AddressBook;

@interface CitySearchViewController () <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
}

@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;

- (IBAction)findCity:(UIButton *)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)findCityWithCurrentLocation:(UIButton *)sender;

@end

@implementation CitySearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    geocoder = [[CLGeocoder alloc] init];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocation related methoids

- (void)configureLocationManager
{
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
        [self.currentLocationButton setEnabled:NO];
    }
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.currentLocationButton setEnabled:NO];
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
        [self.currentLocationButton setEnabled:NO];
    
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if ((placemarks != nil) && (placemarks.count >0))
         {
             [self enableLocationManager:NO];
             NSString *cityName = [placemarks[0] locality];
             NSString *zipCode = [[placemarks[0] addressDictionary] objectForKey:(NSString *)kABPersonAddressZIPKey];
             double lat = location.coordinate.latitude;
             double lng = location.coordinate.longitude;
             City *aCity = [[City alloc] initWithName:cityName latitude:lat longitude:lng andZipCode:zipCode];
             [[NetworkManager sharedNetworkManager] cityFoundUsingCurrentLocation:aCity];
             
         }
     }];
}
#pragma mark - Action Handlers

- (IBAction)findCity:(UIButton *)sender
{
    if (![self.zipCodeTextField.text isEqualToString:@""])
    {
        City *aCity = [[City alloc] initWithZipCode:self.zipCodeTextField.text];
        [[NetworkManager sharedNetworkManager] findCoordinatesForCity:aCity];
    }
}

- (IBAction)findCityWithCurrentLocation:(UIButton *)sender
{

    [self configureLocationManager];
}

- (IBAction)cancel:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
