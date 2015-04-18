//
//  Picmark.h
//  Pickit
//
//  Created by Richard Herndon on 4/7/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;
@import CloudKit;
@import CoreLocation;

@interface Picmark : NSObject <MKAnnotation>

- (instancetype)initWithLocation:(CLLocation *)aLocation andImage:(UIImage *)image;
- (instancetype)initWithRecord:(CKRecord *)record;
- (UIImage *)image;
- (NSString *)uuid;

@end
