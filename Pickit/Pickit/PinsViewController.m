//
//  ViewController.m
//  Pickit
//
//  Created by Richard Herndon on 4/7/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "PinsViewController.h"
#import "ImageDetailViewController.h"

#import "Picmark.h"

@import MapKit;
@import CoreLocation;
@import CloudKit;

#define LAT_LNG_DEGREES 0.2

@interface PinsViewController ()<CLLocationManagerDelegate, MKMapViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (void)addPhotoTapped:(UIBarButtonItem *)sender;

@end



@implementation PinsViewController
{
    MKMapView *_mapView;
    CLLocationManager *_locationManager;
    CLLocation *_currentLocation;
    
    NSMutableArray *_picmarks;
    CKContainer *_container;
    CKDatabase *_publicDB;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];  // required for this
    
    [self checkLocationAuthorization];
    
    // setup mapview in window as same as view (full width and height
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView]; // must add subview to map
    
    _picmarks = [[NSMutableArray alloc] init];   // where we store pins for map
    
    _container = [CKContainer defaultContainer];  // ck is part of cloudkit. each app has a container. prevents cominglying of data
    _publicDB = _container.publicCloudDatabase;   // stores all data that is public for app (there is a private data for individual)
    
    
    // adding button on the right side of the Nav bar (plus button)
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPhotoTapped:)];
    
//    [self refreshPicmarks];
    
    // Do any additional setup after loading the view, typically from a nib.
 
}

- (void)refreshPicmarks
{
    if (_currentLocation)  // check for current location
    {
        NSLog(@"refreshPicmarks %@", _currentLocation);
        CGFloat radius = 10000.0; //meters
        CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Picmark" predicate:[NSPredicate predicateWithFormat:@"distanceToLocation:fromLocation:(%K,%@) < %f", @"Location", _currentLocation, radius]];
        [_publicDB performQuery:query inZoneWithID:nil completionHandler:^(NSArray *results, NSError *error)
        {
            
            if (error)
            {
                NSLog(@"%@",error.localizedDescription);
            }
            else
            {
            
            [_mapView removeAnnotations:_picmarks];
            [_picmarks removeAllObjects];
            for (CKRecord *aRecord in results)
            {
                Picmark *aPicmark = [[Picmark alloc] initWithRecord:aRecord];
                [_picmarks addObject:aPicmark];
            }
            [_mapView addAnnotations:_picmarks];
            }
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocation related methods

- (void)checkLocationAuthorization  // sets up authorization (checks then request authorization
{
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted)
    {
        if (!_locationManager)
        {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            {
                [_locationManager requestWhenInUseAuthorization];
            }
            else
            {
                [self enableLocationManager:YES];
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self enableLocationManager:YES];
    }
}

- (void)enableLocationManager:(BOOL)enable
{
    if (_locationManager)
    {
        [_locationManager stopUpdatingLocation];
        if (enable)
            [_locationManager startUpdatingLocation];
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
    CLLocation *currentLocation = [locations lastObject];
    [self enableLocationManager:NO];
    MKCoordinateRegion mapRegion = MKCoordinateRegionMake(currentLocation.coordinate, MKCoordinateSpanMake(LAT_LNG_DEGREES, LAT_LNG_DEGREES));
    [_mapView setRegion:mapRegion];
    _currentLocation = currentLocation;  // store current location for later use
    [self refreshPicmarks];
}

#pragma mark - MKMapView delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{   // puts pin on screen
    if ([annotation isKindOfClass:[MKUserLocation class]]) // method for setting circle of where you are (not in use for this app)
    {
        return nil;
    }
    
    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"mapAnnotation"];
    
    if (pinAnnotationView) // reuse pin if one is available
    {
        [pinAnnotationView prepareForReuse];
    }
    else
    {
        pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"mapAnnotation"];
    }
    
    pinAnnotationView.canShowCallout = YES; // allows call out window to popup
    
    Picmark *aPicmark = (Picmark *)annotation; // sits up thumbnail of picture
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32.0, 32.0)];
    [imageView setImage:[aPicmark image]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    pinAnnotationView.leftCalloutAccessoryView = imageView;
    UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pinAnnotationView.rightCalloutAccessoryView = disclosureButton;
    [disclosureButton addTarget:self action:@selector(showFullSizeImage) forControlEvents:UIControlEventTouchUpInside];
    
    return pinAnnotationView;
}

#pragma mark - Action handlers

- (void)addPhotoTapped:(UIBarButtonItem *)sender  // allows you to pick picture or video
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])  // check if camera available
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;  // pick new picture
        [self presentViewController:imagePickerController animated:YES completion:nil];  // this is modal so presented from self
    }
}

- (void)showFullSizeImage  // show if button on call out is pressed
{
    Picmark *annotation = [_mapView selectedAnnotations][0];  // mapview sends back selected annotations
    
    ImageDetailViewController *imageDetailVC = [[ImageDetailViewController alloc] init];
    imageDetailVC.image = annotation.image;
    
    [self.navigationController pushViewController:imageDetailVC animated:YES];  // pushes from right
}

#pragma mark - UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        Picmark *aPicmark = [[Picmark alloc] initWithLocation:_currentLocation andImage:image];
        [_picmarks addObject:aPicmark];
        [_mapView addAnnotation:aPicmark];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  // get array of file paths
        NSString *documentsPath = paths[0];  // pick the first one and append the .png to the filename (below) uuid is unique id
        NSString *fullPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", aPicmark.uuid]];
        NSData *imageData = UIImagePNGRepresentation(image); // convert to .png format NSData
        [imageData writeToFile:fullPath atomically:YES];     // write to file use full path name
        
        CKRecord *aRecord = [[CKRecord alloc] initWithRecordType:@"Picmark"]; // create a ck (cloud kit) record of Picmark type
        [aRecord setObject:_currentLocation forKey:@"Location"];  // add location to record
        CKAsset *anAsset = [[CKAsset alloc] initWithFileURL:[NSURL fileURLWithPath:fullPath]]; // pass CKAsset with file url
        [aRecord setObject:anAsset forKey:@"Image"];
        [aRecord setObject:@"A picmark" forKey:@"Title"];
        [_publicDB saveRecord:aRecord completionHandler:^(CKRecord *record, NSError *error) {
            
        }];
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker  // when user cancels from camera
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
