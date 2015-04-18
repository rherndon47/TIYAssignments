//
//  GetWeatherData.m
//  ForeCaster
//
//  Created by Richard Herndon on 3/21/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

#define weatheriokey 2b5894d90d6f81c56ec2e6e5d481c708

//@interface Weather ()
//{
//    NSMutableData *receivedData;
//    NSMutableArray *cityArray;
//}
//
//@end


@implementation Weather


//- (void)getWeatherData:(NSString *)lat andlng:(NSString *)lng
- (BOOL)parseWeatherInfo:(NSDictionary *)infoDictionary
{
    
    NSLog(@"Entering parseWeatherInfo");
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
    return YES;
    
}



//}
- (NSString *)currentTemperature
{
    return [NSString stringWithFormat:@"%f F",self.temperature];
}

- (NSString *)feelsLikeTemperature
{
    return [NSString stringWithFormat:@"%.0f F",self.apparentTemperature];
}
- (NSString *)dewPointTemperature
{
    return [NSString stringWithFormat:@"%.0f",self.dewPoint];
}
- (NSString *)humidityPercentage
{
    return [NSString stringWithFormat:@"%f%%",self.humidity];
}
- (NSString *)chanceOfRain
{
    return [NSString stringWithFormat:@"%.0f%%",self.precipProbability];
}
- (NSString *)windSpeedMPH
{
    return [NSString stringWithFormat:@"%.0f MPH",self.windSpeed];
}

@end
