//
//  City.m
//  Forecaster
//
//  Created by Ben Gohlke on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "City.h"

@interface City ()
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation City

- (instancetype)initWithZipCode:(NSString *)zip
{
    self = [super init];
    if (self)
    {
        _zipCode = zip;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng andZipCode:(NSString *)zip
{
    self = [super init];
    if (self)
    {
        _zipCode = zip;
        _latitude = lat;
        _longitude = lng;
        _name = name;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithZipCode:@"0"];
}

- (BOOL)parseCoordinateInfo:(NSDictionary *)mapsDictionary
{
    BOOL rc = NO;
    
    if (mapsDictionary)
    {
        rc = YES;
        NSArray *results = mapsDictionary[@"results"];
        NSDictionary *resultsDictionary = [results objectAtIndex:0];
        NSString *formatted_address = resultsDictionary[@"formatted_address"];
        NSArray *addressComponents = [formatted_address componentsSeparatedByString:@","];
        self.name = addressComponents[0];
        self.state = [addressComponents[1] componentsSeparatedByString:@" "][0];
        NSDictionary *geometry = resultsDictionary[@"geometry"];
        NSDictionary *location = geometry[@"location"];
        self.latitude = [location[@"lat"] doubleValue];
        self.longitude = [location[@"lng"] doubleValue];
        self.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    }
    
    return rc;
}

- (NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return [self.currentWeather currentTemperature];
}

-(CLLocationCoordinate2D)coordinate
{
    return _coordinate;  // underscore allows overriding of the coordinate value
}

- (MKMapItem *)mapItem
{
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.name;
    return mapItem;
}

#pragma mark - NSCoding

#define kNameKey @"name"
#define kLatitudeKey @"latitude"
#define kLongitudeKey @"longitude"
#define kZipCodeKey @"zipCode"


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeDouble:self.latitude forKey:kLatitudeKey];
    [aCoder encodeDouble:self.longitude forKey:kLongitudeKey];
    [aCoder encodeObject:self.zipCode forKey:kZipCodeKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *cityName = [aDecoder decodeObjectForKey:kNameKey];
    double Latitude = [aDecoder decodeDoubleForKey:kLatitudeKey];
    double longitude = [aDecoder decodeDoubleForKey:kLongitudeKey];
    NSString *zipCode = [aDecoder decodeObjectForKey:kZipCodeKey];
    return[self initWithName:cityName latitude:Latitude longitude:longitude andZipCode:zipCode];    
}

@end