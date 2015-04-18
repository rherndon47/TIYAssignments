//
//  Picmark.m
//  Pickit
//
//  Created by Richard Herndon on 4/7/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "Picmark.h"

@implementation Picmark
{
    CLLocation *_theLocation;
    UIImage *_image;
    NSUUID *_identifier;
}

- (instancetype)initWithLocation:(CLLocation *)aLocation andImage:(UIImage *)image
{
    self = [super init];
    if (self)
    {
        _theLocation = aLocation;
        _image = image;
        _identifier = [NSUUID UUID]; // UUID is number that is gives you random number to make it unique
    }
    
    return self;
}

- (instancetype)initWithRecord:(CKRecord *)record
{
    self = [super init];
    if (self)
    {
        _theLocation = [record objectForKey:@"Location"]; // dictionary of images
        CKAsset *asset = [record objectForKey:@"Image"];
        NSData *imageData = [NSData dataWithContentsOfURL:asset.fileURL];
//        _image = [record objectForKey:@"Image"];          // stores it here
        _image = [UIImage imageWithData:imageData];
    }
    
    return self;
}

- (NSString *)title
{
    return @"A Picmark";  // required title
}

- (CLLocationCoordinate2D)coordinate  // required method
{
    return _theLocation.coordinate;
}

- (UIImage *)image  // getter for image
{
    return _image;
}

- (NSString *)uuid  // getter for image
{
    return [NSString stringWithFormat:@"%@", _identifier];  // returns uuid as string
}

@end