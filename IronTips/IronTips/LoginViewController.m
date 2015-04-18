//
//  ViewController.m
//  IronTips
//
//  Created by Richard Herndon on 4/16/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak,nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passodeTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowTipsSegue"])
    {
        
    }
}
@end
