//
//  PinModel.h
//  LocateCar
//
//  Created by Richard Herndon on 3/25/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;

@interface PinModel : NSObject <MKAnnotation, NSCoding>

@property (strong, nonatomic) NSString *comment;

- (instancetype)initWithLatLng:(double)lat andlongitude:(double)lng;
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)encodeWithCoder:(NSCoder *)aCoder;

@end
