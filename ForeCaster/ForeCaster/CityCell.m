//
//  CityCell.m
//  Forecaster
//
//  Created by Ben Gohlke on 3/22/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CityCell.h"

@implementation CityCell

- (void)awakeFromNib
{
    self.cityNameLabel.text = @"";
    self.currentTemperatureLabel.text = @"";
    self.currentConditionsSummaryLabel.text = @"";
}

@end
