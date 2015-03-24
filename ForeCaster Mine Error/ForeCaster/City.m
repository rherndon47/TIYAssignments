//
//  ZipCodeData.m
//  ForeCaster
//
//  Created by Richard Herndon on 3/20/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "City.h"
//#import "NetworkManager.h"
//#import "ForeCasterTableViewController.h"


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
        NSArray *results = [mapsDictionary objectForKey:@"results"];
        NSDictionary *locationInfo = results[0];
        NSArray *addressComps = [locationInfo objectForKey:@"address_components"];
        
        NSDictionary *city = addressComps[1];
        self.cityName = [city objectForKey:@"long_name"];
        
        NSDictionary *geometry = [locationInfo objectForKey:@"geometry"];
        NSDictionary *location = [geometry objectForKey:@"location"];
        self.lat = [location[@"lat"] doubleValue];
        self.lng = [location[@"lng"] doubleValue];
    }
    
    return rc;
}


@end
