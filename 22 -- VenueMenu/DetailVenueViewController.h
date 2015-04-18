//
//  DetailVenueViewController.h
//  22 -- VenueMenu
//
//  Created by Richard Herndon on 4/2/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"
#import "SearchResultsVenues.h"
#import "AnnotationMapCoordinates.h"
#import "Venue.h"

@import CoreLocation;
@import MapKit;

@interface DetailVenueViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;

@property (strong, nonatomic) SearchResultsVenues *transferResultVenue;

@property (strong, nonatomic) AnnotationMapCoordinates *currentMapCoordinates;

@property (strong, nonatomic) CoreDataStack *cdStack;

@property (strong, nonatomic) Venue *xferResultVenue;

@property (strong, nonatomic) NSString *fromFavView;


@end
