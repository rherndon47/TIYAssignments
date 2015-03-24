//
//  FriendDetailViewController.m
//  GithubFriends
//
//  Created by Richard Herndon on 3/18/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "FriendDetailViewController.h"

@interface FriendDetailViewController ()
{
    NSArray *repros;
}

@end

@implementation FriendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *login = [self.friendinfo objectForKey:@"login"];

    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", login];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil]; // returns JSON
    
    NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:responseData options:(NSJSONReadingMutableContainers) error:nil];
    
    NSLog(@"Detatil viewDidLoad response data %@",userInfo);
    self.view.backgroundColor = [UIColor purpleColor];
    
//    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, 300, 40)];
//    usernameTextField.placeholder = @"Username";
//    
//    usernameTextField.backgroundColor = [UIColor whiteColor];
//    
//    [self.view addSubview:usernameTextField];
    
    // create Git User button
    
//    CGFloat *locationY = usernameTextField.frame.origin.y + usernameTextField.frame.size.height + 10;
    
    
    UILabel *location = [[UILabel alloc] initWithFrame: CGRectMake(10, 74, 300, 40)];
//    [location setText:@"Location"];
    NSString *locationString = [self.friendinfo objectForKey:@"location"];
    NSString *emptyString = @"";
    if ([locationString isEqualToString:emptyString])
    {
        locationString = @"None";
    }
    
    
    [location setText:locationString];
    [self.view addSubview:location];
    
//    CGFloat cancelY = saveFriend.frame.origin.y + saveFriend.frame.size.height + 10;
//    CGFloat *emailY = location.frame.origin.y + location.frame.size.height + 10;
    
    UILabel *email = [[UILabel alloc] initWithFrame: CGRectMake(10, 124, 300, 40)];
    NSString *emailString = [self.friendinfo objectForKey:@"email"];
    if ([emailString isEqualToString:emptyString])
    {
        emailString = @"None";
    }
    
    [email setText:emailString];
    
    [self.view addSubview:email];
}

- (void)didReceiveMemoryWarning {
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

@end
