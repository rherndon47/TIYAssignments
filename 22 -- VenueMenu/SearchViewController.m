//
//  SearchViewController.m
//  22 -- VenueMenu
//
//  Created by Richard Herndon on 4/2/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "SearchViewController.h"
#import "FavVenueTableViewController.h"
#import "SearchTableViewController.h"
#import "CoreDataStack.h"


@interface SearchViewController ()

@property (strong, nonatomic) IBOutlet UITextField *itemSearchField;

@end

@implementation SearchViewController

static NSString *fourSquareBaseURL = @"https://api.foursquare.com/v2/venues/search?client_id=OWA5APW2SPIQ1MBUMZDPFW5RBK4YLKW4FS2TZBDI4ZXQSZSI&client_secret=LTCMUOBE1WUB4RDX5Z2UTZRYU14AU5WCTDY32NLRSQVMHBC4&v=20130815%20%20&ll"; // need to add Lat Lng, &query=??? &radius 800

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemField = @"";
    self.itemSearchField.delegate = self;
    [self.itemSearchField becomeFirstResponder];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.itemSearchField resignFirstResponder];
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SearchVenueSeque"])
    {
        SearchTableViewController *modelVC = (SearchTableViewController *)[segue destinationViewController];
        self.itemField = self.itemSearchField.text;
        modelVC.itemField = self.itemField;
        modelVC.cdStack = self.cdStack;
    }
    
}

@end
