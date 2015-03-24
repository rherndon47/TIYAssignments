//
//  FriendDetailViewController.m
//  GithubFriends
//
//  Created by Richard Herndon on 3/18/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "FriendDetailViewController.h"

@interface FriendDetailViewController () <NSURLSessionDataDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSArray *repros;
    NSMutableData *receivedData;
    UITableView *theTableView;
}

@end

@implementation FriendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *login = [self.friendinfo objectForKey:@"login"];
    


    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", login];
    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil]; // returns JSON
//    
//    NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:responseData options:(NSJSONReadingMutableContainers) error:nil];
//    
//    NSLog(@"Detatil viewDidLoad response data %@",userInfo);
    self.view.backgroundColor = [UIColor purpleColor];
    
//    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, 300, 40)];
//    usernameTextField.placeholder = @"Username";
//    
//    usernameTextField.backgroundColor = [UIColor whiteColor];
//    
//    [self.view addSubview:usernameTextField];
    
    // create Git User button
    
//    CGFloat *locationY = usernameTextField.frame.origin.y + usernameTextField.frame.size.height + 10;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [dataTask resume];
                             
    
    
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
    CGFloat tableviewY = email.frame.origin.y + email.frame.size.height + 10;
    theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableviewY, self.view.frame.size.width, self.view.frame.size.height-tableviewY)];
    theTableView.delegate = self;
    theTableView.dataSource = self;
    [self.view addSubview:theTableView];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [repros count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    NSDictionary *repo = repros[indexPath.row];
    cell.textLabel.text = repo[@"name"];
    return cell;
}

#pragma mark -- NSURLSessionData delegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if (!receivedData)
    {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }
    else
    {
        [receivedData appendData:data];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        NSLog(@"Download successful");
        repros = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        [theTableView reloadData];
    }
}
@end
