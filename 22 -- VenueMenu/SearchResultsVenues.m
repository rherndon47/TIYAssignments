//
//  SearchResultsVenues.m
//  22 -- VenueMenu
//
//  Created by Richard Herndon on 4/4/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "SearchResultsVenues.h"

@implementation SearchResultsVenues

-(CLLocationCoordinate2D)coordinate
{
    self.searchCoordinate = CLLocationCoordinate2DMake(_latitude, _longitude);
    return self.searchCoordinate;  // underscore allows overriding of the coordinate value
}

- (id) initWithCoordinate:(CLLocationCoordinate2D)coord
{
    self.coordinate = coord;
    return self;
}

@end
