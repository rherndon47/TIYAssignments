//
//  SearchResultsVenues.h
//  22 -- VenueMenu
//
//  Created by Richard Herndon on 4/4/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;

@interface SearchResultsVenues : NSObject<MKMapViewDelegate, CLLocationManagerDelegate, MKAnnotation>
{
    
}

@property (strong, nonatomic) NSString *venueName;
@property (strong, nonatomic) NSString *venueAddress;
@property (strong, nonatomic) NSString *venueCity;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zipCode;
@property (assign) double latitude;
@property (assign) double longitude;
@property (strong, nonatomic) NSString *searchQuery;

@property (nonatomic) CLLocationCoordinate2D searchCoordinate;



//- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng andZipCode:(NSString *)zip;
- (CLLocationCoordinate2D)coordinate;  // added for mapkit
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
