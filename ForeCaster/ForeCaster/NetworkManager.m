//
//  NetworkManager.m
//  Forecaster
//
//  Created by Ben Gohlke on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "NetworkManager.h"

typedef enum {
    DataFetchTypeCoordinates,
    DataFetchTypeWeather
} DataFetchType;

@interface NetworkManager () <NSURLSessionDataDelegate>
{
    NSURLSessionConfiguration *configuration;
    NSURLSession *session;
    NSMutableDictionary *citiesForActiveTasks;
    NSMutableDictionary *receivedDataRepos;
}

@end

@implementation NetworkManager

static NSString *gMapsBaseURL = @"http://maps.googleapis.com/maps/api/geocode/json?address=santa+cruz&components=postal_code:%@&sensor=false";
static NSString *forecastIoBaseURL = @"https://api.forecast.io/forecast/2b5894d90d6f81c56ec2e6e5d481c708/%f,%f";


+ (NetworkManager *)sharedNetworkManager
{
    static NetworkManager *sharedNetworkManager = nil;
    if (sharedNetworkManager)
        return sharedNetworkManager;
    
    // Use Grand Central Dispatch to only init one instance of NetworkManager, makes the singleton thread-safe
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkManager = [[NetworkManager alloc] init];
    });
    
    return sharedNetworkManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        citiesForActiveTasks = [[NSMutableDictionary alloc] init];
        receivedDataRepos = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)findCoordinatesForCity:(City *)aCity
{

    
    NSString *googleMapsUrlString = [NSString stringWithFormat:gMapsBaseURL, aCity.zipCode];
    NSURL *url = [NSURL URLWithString:googleMapsUrlString];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [self startDataTask:dataTask forCity:aCity];
}

- (void)fetchCurrentWeatherForCity:(City *)aCity
{

    NSString *forecastIoUrlString = [NSString stringWithFormat:forecastIoBaseURL, aCity.latitude, aCity.longitude];
    NSURL *url = [NSURL URLWithString:forecastIoUrlString];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [self startDataTask:dataTask forCity:aCity];
    
}

- (void)startDataTask:(NSURLSessionTask *)dataTask forCity:(City *)aCity
{
    [citiesForActiveTasks setObject:aCity forKey:[NSNumber numberWithInteger:dataTask.taskIdentifier]];
    [receivedDataRepos setObject:[[NSMutableData alloc] init] forKeyedSubscript:[NSNumber numberWithInteger:dataTask.taskIdentifier]];
    [dataTask resume];
}

- (void)fetchCurrentWeatherForCities:(NSArray *)cities
{
    for (City *aCity in cities)
    {
        [self fetchCurrentWeatherForCity:aCity];
    }
}

- (void)cityFoundUsingCurrentLocation:(City *)aCity
{
    [self.delegate cityWasFound:aCity];
}

#pragma mark - NSURLSession delegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSMutableData *receivedData = receivedDataRepos[[NSNumber numberWithInteger:dataTask.taskIdentifier]];
    [receivedData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        NSMutableData *receivedData = receivedDataRepos[[NSNumber numberWithInteger:task.taskIdentifier]];
        
        NSDictionary *aDictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        City *aCity = citiesForActiveTasks[[NSNumber numberWithInteger:task.taskIdentifier]];
        DataFetchType fetchType;
        if ([aDictionary objectForKey:@"results"])
        {
            fetchType = DataFetchTypeCoordinates;
        }
        else
        {
            fetchType = DataFetchTypeWeather;
        }
        
        BOOL coordinatesSuccess = NO;
        BOOL weatherSuccess = NO;
        switch (fetchType)
        {
            case DataFetchTypeCoordinates:
                coordinatesSuccess = [aCity parseCoordinateInfo:aDictionary];
                break;
            case DataFetchTypeWeather:
                weatherSuccess = [aCity.currentWeather parseWeatherInfo:aDictionary];
                break;
                
            default:
                break;
        }
        
        if (coordinatesSuccess)
        {
            [self.delegate cityWasFound:aCity];
        }
        if (weatherSuccess)
        {
            [self.delegate weatherWasFoundForCity:aCity];
        }
    }
}

@end
