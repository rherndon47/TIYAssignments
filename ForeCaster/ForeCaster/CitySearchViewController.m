//
//  CitySearchViewController.m
//  Forecaster
//
//  Created by Ben Gohlke on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CitySearchViewController.h"
#import "City.h"
#import "NetworkManager.h"

@interface CitySearchViewController ()

@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

- (IBAction)findCity:(UIButton *)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;

@end

@implementation CitySearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Handlers

- (IBAction)findCity:(UIButton *)sender
{
    if (![self.zipCodeTextField.text isEqualToString:@""])
    {
        City *aCity = [[City alloc] initWithZipCode:self.zipCodeTextField.text];
        [[NetworkManager sharedNetworkManager] findCoordinatesForCity:aCity];
    }
}

- (IBAction)cancel:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
