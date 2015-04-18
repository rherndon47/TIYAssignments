//
//  WeatherDetailViewController.m
//  Forecaster
//
//  Created by Ben Gohlke on 3/22/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "WeatherDetailViewController.h"

@import MapKit;

#define MAP_DISPLAY_SCALE 0.5 * 1609.344  // 1609.344 meters in mile .5 means half a mile

@interface WeatherDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *actualTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *apparentTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *dewPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *rainChanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation WeatherDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.city.name;
    self.summaryLabel.text = self.city.currentWeather.summary;
    self.actualTemperatureLabel.text = [self.city.currentWeather currentTemperature];
    self.iconImageView.image = [UIImage imageNamed:self.city.currentWeather.icon];
    self.apparentTemperatureLabel.text = [self.city.currentWeather feelsLikeTemperature];
    self.dewPointLabel.text = [self.city.currentWeather dewPointTemperature];
    self.humidityLabel.text = [self.city.currentWeather humidityPercentage];
    self.rainChanceLabel.text = [self.city.currentWeather chanceOfRain];
    self.windSpeedLabel.text = [self.city.currentWeather windSpeedMPH];
    [self configureMapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureMapView
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([self.city coordinate], MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
    [self.mapView setRegion:viewRegion];  // where map goes
    [self.mapView addAnnotation:self.city];  // tells mapkit where to place pin
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[City class]])
    {
        static NSString * const identifier = @"CityAnnotation";
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView)
        {
            annotationView.annotation = annotation;
        }
        else
        {
            annotationView  = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    return nil;
}

@end
