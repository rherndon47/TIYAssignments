//
//  Weather.m
//  Forecaster
//
//  Created by Ben Gohlke on 3/22/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (NSString *)currentTemperature
{
    return [NSString stringWithFormat:@"%.0f℉", self.temperature];
}

- (NSString *)feelsLikeTemperature
{
    return [NSString stringWithFormat:@"Feels like %.0f℉", self.apparentTemperature];
}

- (NSString *)dewPointTemperature
{
    return [NSString stringWithFormat:@"%.0f℉", self.dewPoint];
}

- (NSString *)humidityPercentage
{
    return [NSString stringWithFormat:@"%.0f%%", self.humidity * 100];
}

- (NSString *)chanceOfRain
{
    return [NSString stringWithFormat:@"%.0f%%", self.precipProbability * 100];
}

- (NSString *)windSpeedMPH
{
    return [NSString stringWithFormat:@"%.0f MPH", self.windSpeed];
}

- (BOOL)parseWeatherInfo:(NSDictionary *)infoDictionary
{
    BOOL rc = NO;
    if (infoDictionary)
    {
        rc = YES;
        NSDictionary *currently = infoDictionary[@"currently"];
        self.summary = currently[@"summary"];
        self.icon = currently[@"icon"];
        self.temperature = [currently[@"temperature"] doubleValue];
        self.apparentTemperature = [currently[@"apparentTemperature"] doubleValue];
        self.dewPoint = [currently[@"dewPoint"] doubleValue];
        self.humidity = [currently[@"humidity"] doubleValue];
        self.precipProbability = [currently[@"precipProbability"] doubleValue];
        self.windSpeed = [currently[@"windSpeed"] doubleValue];
    }
    return rc;
}

@end