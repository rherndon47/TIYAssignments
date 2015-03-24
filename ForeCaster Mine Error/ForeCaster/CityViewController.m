//
//  CityViewController.m
//  ForeCaster
//
//  Created by Richard Herndon on 3/19/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "CityViewController.h"
#import "City.h"
#import "NetworkManager.h"


//@interface CityViewController () <UITextFieldDelegate, NSURLSessionDataDelegate, UITableViewDelegate>
@interface CityViewController ()
{

    NSString *passZipCode;
    NSMutableData *receivedData;
}


@property (weak, nonatomic) IBOutlet UITextField *zipcode;

- (IBAction)findCity:(UIButton *)sender;
- (IBAction)cancelRequest:(UIBarButtonItem *)sender;

@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"CityViewController viewDidLoad");
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)findCity:(UIBarButtonItem *)sender
{
    NSLog(@"Entering findCity");
    
    if (![self.zipcode.text isEqualToString:@""])
    {
        City *aCity = [[City alloc]initWithZipCode:self.zipcode.text];
        [[NetworkManager sharedNetworkManager] findCoordinatesForCity:aCity];
    }
}

- (void)cancelRequest:(UIBarButtonItem *)sender
{
    NSLog(@"Entering cancelRequest");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - NSURLSessionData delegate

@end
