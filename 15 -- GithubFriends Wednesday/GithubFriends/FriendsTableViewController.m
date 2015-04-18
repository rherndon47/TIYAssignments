//
//  FriendsTableViewController.m
//  GithubFriends
//
//  Created by Richard Herndon on 3/18/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "FriendCell.h"
#import "NewFriendViewController.h"
#import "FriendDetailViewController.h"

@interface FriendsTableViewController ()
{
    NSMutableArray *friends;
}

@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    friends = [[NSMutableArray alloc] init];
    [self.tableView registerClass:[FriendCell class] forCellReuseIdentifier:@"FriendCell"];
    
    UIBarButtonItem *addFriendButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriend)];
    self.navigationItem.rightBarButtonItem = addFriendButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [friends count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
    
    // get the name and avatar from github for a user
    
    NSDictionary *friendInfo = friends[indexPath.row];
    cell.textLabel.text = [friendInfo objectForKey:@"name"]; // friendInfo:@"name" same thing
    NSURL *avatarURL = [NSURL URLWithString:[friendInfo objectForKey:@"avatar_url"]];
    
    // taking image data from url and moving into cell
    
    NSData *imagedata = [NSData dataWithContentsOfURL:avatarURL];
    UIImage *image = [UIImage imageWithData:imagedata];
    cell.imageView.image = image;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * afriend = friends[indexPath.row];
    FriendDetailViewController  *friendDetailVC = [[FriendDetailViewController alloc] init];
    
    friendDetailVC.friendinfo = afriend;

    [self.navigationController pushViewController:friendDetailVC animated:YES];
    
    
}

#pragma mark - Action Handlers

- (void)addFriend
{
    NewFriendViewController *newFriendVC = [[NewFriendViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:newFriendVC];
    newFriendVC.view.backgroundColor = [UIColor purpleColor];
    newFriendVC.friends = friends;
    
    [self    presentViewController:navController animated:YES completion:nil];
}

@end
