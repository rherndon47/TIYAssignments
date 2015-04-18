//
//  WinningTicketViewController.m
//  Jackpot
//
//  Created by Jordan Anderson on 3/4/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "WinningTicketViewController.h"

@interface WinningTicketViewController ()

@property (weak, nonatomic) IBOutlet UITextField *winNumTextField1;
@property (weak, nonatomic) IBOutlet UITextField *winNumTextField2;
@property (weak, nonatomic) IBOutlet UITextField *winNumTextField3;
@property (weak, nonatomic) IBOutlet UITextField *winNumTextField4;
@property (weak, nonatomic) IBOutlet UITextField *winNumTextField5;
@property (weak, nonatomic) IBOutlet UITextField *winNumTextField6;


- (IBAction)checkWinTicketNumButton:(UIButton *)sender;

@end




@implementation WinningTicketViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)checkWinTicketNumButton:(UIButton *)sender
{
    NSArray *textsField = @[self.winNumTextField1.text,self.winNumTextField2.text, self.winNumTextField3.text, self.winNumTextField4.text, self.winNumTextField5.text, self.winNumTextField6.text ];
    [self.delegate winningTicketNumbersWasChosen:textsField];

    NSLog(@"%@ ", textsField);
    
    [self.navigationController popToRootViewControllerAnimated:YES];


}


@end
