//
//  ViewController.h
//  LocateCar
//
//  Created by Richard Herndon on 3/25/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinModel.h"

@import MapKit;

@interface LocateCarViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

- (void)saveCarLocationData;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic)  NSString *comment;

@end

