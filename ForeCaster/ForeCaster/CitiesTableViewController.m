//
//  CitiesTableViewController.m
//  Forecaster
//
//  Created by Ben Gohlke on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CitiesTableViewController.h"
#import "CitySearchViewController.h"
#import "WeatherDetailViewController.h"
#import "CityCell.h"

#import "NetworkManager.h"

@interface CitiesTableViewController ()

@end

@implementation CitiesTableViewController
{
    NSMutableArray *cities;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    cities = [[NSMutableArray alloc] init];
    [NetworkManager sharedNetworkManager].delegate = self;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell" forIndexPath:indexPath];
    
    City *aCity = cities[indexPath.row];
    cell.cityNameLabel.text = aCity.name;
    if (aCity.currentWeather)
    {
        cell.currentConditionsSummaryLabel.text = aCity.currentWeather.summary;
        cell.currentTemperatureLabel.text = [aCity.currentWeather currentTemperature];
    }
    
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    City *selectedCity = cities[indexPath.row];
    WeatherDetailViewController *weatherDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherDetailView"];
    weatherDetailVC.city = selectedCity;
    [self.navigationController pushViewController:weatherDetailVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [cities removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - CitiesTableview delegate

- (void)cityWasFound:(City *)aCity
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [cities addObject:aCity];
    aCity.currentWeather = [[Weather alloc] init];
    [[NetworkManager sharedNetworkManager] fetchCurrentWeatherForCity:aCity];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[cities indexOfObject:aCity] inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)weatherWasFoundForCity:(City *)aCity
{
    NSIndexPath *indexPathForCell = [NSIndexPath indexPathForRow:[cities indexOfObject:aCity] inSection:0];
    CityCell *cellToUpdate = (CityCell *)[self.tableView cellForRowAtIndexPath:indexPathForCell];
    cellToUpdate.currentConditionsSummaryLabel.text = aCity.currentWeather.summary;
    cellToUpdate.currentTemperatureLabel.text = [aCity.currentWeather currentTemperature];
}

- (IBAction)unwindToCitiesTableView:(UIStoryboardSegue *)unwindSegue
{
    
}


@end
