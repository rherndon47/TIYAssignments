//
//  City.h
//  Forecaster
//
//  Created by Ben Gohlke on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@import MapKit;

@interface City : NSObject <MKAnnotation, NSCoding>    // MKAnnotation implementing MK protocol

@property (strong, nonatomic) Weather *currentWeather;
@property (strong, nonatomic) NSArray *forecastedWeather;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *state;
@property (assign) double latitude;
@property (assign) double longitude;
@property (strong, nonatomic) NSString *zipCode;

- (instancetype)initWithZipCode:(NSString *)zip;
- (BOOL)parseCoordinateInfo:(NSDictionary *)mapsDictionary;
- (CLLocationCoordinate2D)coordinate;  // added for mapkit

@end
