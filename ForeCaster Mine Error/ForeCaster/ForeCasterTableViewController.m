//
//  ForeCasterTableViewController.m
//  ForeCaster
//
//  Created by Richard Herndon on 3/19/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "ForeCasterTableViewController.h"
#import "CityViewController.h"

#import "ForecastCellTableViewCell.h"

#define weatheriokey 2b5894d90d6f81c56ec2e6e5d481c708

//@protocol CityViewControllerDelegate
//
//- (void)cityWasChosen:(NSString *)chosenValueType;
//
//@end

//@interface ForeCasterTableViewController () <UITextFieldDelegate, NSURLSessionDataDelegate, UIPopoverPresentationControllerDelegate,CityViewController>



@interface ForeCasterTableViewController () 
{
    NSString *city;
    NSString *zipcode;
    NSMutableArray *cityArray;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addCity;

@end

@implementation ForeCasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cityArray = [[NSMutableArray alloc] init];
    [NetworkManager sharedNetworkManager].delegate = self;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
        NSLog(@"TV Entering Section");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
        NSLog(@"TV Entering Rows");
    return [cityArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ForecastCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"viewCell" forIndexPath:indexPath];

    
    City *aCity = cityArray[indexPath.row];
    cell.displayCity.text = aCity.cityName;
    if (aCity.currentWeather)
    {
        cell.displayCity.text = [aCity.currentWeather currentTemperature];
        cell.displaySummary.text = aCity.currentWeather.summary;
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Entering Seque");
    if ([segue.identifier isEqualToString:@"addCitySegue"])
    {
        UINavigationController *naVC = (UINavigationController *)[segue destinationViewController];
        CityViewController *destVC = [naVC viewControllers][0];
        destVC.cityArray = cityArray;
//        destVC.delegate = self;
    }

}

#pragma mark - ForeCasterTableViewControllerDelegate

- (void)cityWasFound:(City *)aCity
{
    NSLog(@"Entering cityWasFound");
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [cityArray addObject:aCity];
    aCity.currentWeather = [[Weather alloc] init];
    [[NetworkManager sharedNetworkManager] fetchCurrentWeatherForCity:aCity];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[cityArray indexOfObject:aCity] inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
}

- (void)weatherWasFoundForCity:(City *)aCity
{
    NSIndexPath *cityPath = [NSIndexPath indexPathForRow:[cityArray indexOfObject:aCity] inSection:0];
    ForecastCellTableViewCell *cell = (ForecastCellTableViewCell *) [self.tableView cellForRowAtIndexPath:cityPath];
    
    cell.displayCity.text = [aCity.currentWeather currentTemperature];
    cell.displaySummary.text = aCity.currentWeather.summary;
    
}


@end
