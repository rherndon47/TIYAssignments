//
//  SaveRegimentPopoverViewController.m
//  TrainerTracker
//
//  Created by Richard Herndon on 4/29/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "SaveRegimentPopoverViewController.h"

@interface SaveRegimentPopoverViewController ()

@property (weak, nonatomic) IBOutlet UITextField *regimentNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

- (IBAction)saveName:(UIButton *)sender;
- (IBAction)cancelName:(UIButton *)sender;

@end

@implementation SaveRegimentPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithRed:0.62 green:0.76 blue:0.51 alpha:1.0];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveName:(UIButton *)sender
{
    self.regimentName = self.regimentNameTextField.text;
    [self.delegate RegimentNameWasChosen:self.regimentName];
}
- (IBAction)cancelName:(UIButton *)sender
{
    NSLog(@"CancelName");
    self.regimentName = self.regimentNameTextField.text;
    [self.delegate PopoverCanceled:self.regimentName];
   
}

@end
