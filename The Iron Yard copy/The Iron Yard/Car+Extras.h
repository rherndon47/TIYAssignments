//
//  Car+Extras.h
//  The Iron Yard
//
//  Created by Richard Herndon on 3/11/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

@interface Car (Extras)

- (BOOL)paint: (NSString *)color;
- (BOOL)wash;

@end
