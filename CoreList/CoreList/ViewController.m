//
//  ViewController.m
//  CoreList
//
//  Created by Richard Herndon on 3/31/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "ViewController.h"
#import "CoreListTableViewController.h"
#import "CoreDataStack.h"
#import "ListItem.h"

@interface ViewController ()

- (IBAction)saveItemButton:(UIBarButtonItem *)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UITextField *itemTextField;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (IBAction)saveItemButton:(id)sender;
{
    ListItem *aItem = [NSEntityDescription insertNewObjectForEntityForName:@"ListItem" inManagedObjectContext:self.cdStack.managedObjectContext];
//    aItem.name = self.itemTextField.text;
    if (![self.itemTextField.text isEqualToString:@""])
    {
        aItem.name = self.itemTextField.text;
        [self saveCoreDataUpdates];
        [self.itemTextField resignFirstResponder];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)saveCoreDataUpdates
{
    [self.cdStack saveOrFail:^(NSError *errorOrNil)
     {
         if (errorOrNil)
         {
             NSLog(@"Error from CDStack: %@", [errorOrNil localizedDescription]);
         }
         
     }];
}

- (void)cancel:(UIBarButtonItem *)sender;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
