//
//  PinModel.m
//  LocateCar
//
//  Created by Richard Herndon on 3/25/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "PinModel.h"
@import MapKit;

@interface PinModel ()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (strong, nonatomic) NSString *name;
@property (assign) double latitude;
@property (assign) double longitude;

@end

@implementation PinModel

- (NSString *)comment
{
    return self.comment;
}

//- (NSString *)subtitle
//{
//    return self.currentWeather currentTemperature];
//}

-(CLLocationCoordinate2D)coordinate
{
    NSLog(@"Entering PinModel Coordinate");
    return _coordinate;  // underscore allows overriding of the coordinate value
}

- (MKMapItem *)mapItem
{
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.comment;
    return mapItem;
}

- (instancetype)initWithLatLng:(double)lat andlongitude:(double)lng
{
    self = [super init];
    if (self)
    {
        _latitude = lat;
        _longitude = lng;
        _coordinate = CLLocationCoordinate2DMake(lat, lng);
    }
    return self;
}

- (NSString *)title //built in method being overwritten for MKAnnotation
{
    self.name = @"Car Location";
    return self.name;
}

- (NSString *)subtitle
{
    return self.comment;
}

#pragma mark - NSCoding

#define kPlaceCommentKey @"comment"
#define kLatitudeKey @"latitude"
#define kLongitudeKey @"longitude"

- (void)encodeWithCoder:(NSCoder *)aCoder
{
//    [aCoder encodeObject:self.coordinate.comment forKey:kPlaceCommentKey];
    [aCoder encodeDouble:self.coordinate.latitude forKey:kLatitudeKey];
    [aCoder encodeDouble:self.coordinate.longitude forKey:kLongitudeKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
//    NSString *comment = [aDecoder decodeObjectForKey:kPlaceCommentKey];
    double Latitude = [aDecoder decodeDoubleForKey:kLatitudeKey];
    double longitude = [aDecoder decodeDoubleForKey:kLongitudeKey];

    return [self initWithLatLng:(double)Latitude andlongitude:(double)longitude];

}

@end
