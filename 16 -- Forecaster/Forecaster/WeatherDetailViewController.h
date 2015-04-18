//
//  WeatherDetailViewController.h
//  Forecaster
//
//  Created by Ben Gohlke on 3/22/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface WeatherDetailViewController : UIViewController

@property (strong, nonatomic) City *city;

@end