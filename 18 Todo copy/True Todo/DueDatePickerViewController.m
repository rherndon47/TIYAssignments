//
//  DueDatePickerViewController.m
//  True Todo
//
//  Created by Richard Herndon on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "DueDatePickerViewController.h"
#import "ToDoDetailTableViewController.h"
#import "TodoObject.h"


@interface DueDatePickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)done:(UIBarButtonItem *)sender;

@end

@implementation DueDatePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"DatePicker viewDidLoad");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"DatePicker viewWillDisappear");
    
    //
    //  We need to call a method to tell the delegate that a destination date was chosen and pass the date from the
    //    datePicker object.
    //
    
    [self.delegate dueDateWasChosen:self.datePicker.date];
    
}

- (IBAction)done:(UIBarButtonItem *)sender
{
    NSLog(@"DatePicker done");
    [self.delegate dueDateWasChosen:self.datePicker.date];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
