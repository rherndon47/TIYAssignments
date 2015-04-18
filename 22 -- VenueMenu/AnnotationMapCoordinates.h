//
//  annotationMapCoordinates.h
//  22 -- VenueMenu
//
//  Created by Richard Herndon on 4/6/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;

@interface AnnotationMapCoordinates : NSObject<MKMapViewDelegate, CLLocationManagerDelegate, MKAnnotation>

@property (assign) double latitude;
@property (assign) double longitude;

@property (nonatomic) CLLocationCoordinate2D searchCoordinate;

- (CLLocationCoordinate2D)coordinate;  // added for mapkit

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
