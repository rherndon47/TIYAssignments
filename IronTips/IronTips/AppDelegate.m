//
//  AppDelegate.m
//  IronTips
//
//  Created by Richard Herndon on 4/16/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Parse setApplicationId:@"7m0HnyrxZKtpTVUqUNS0wLhYby1WmkZ0h9HdbX9j" clientKey:@"x9zlQZ4Dmjmyuk9l2LZF2LoKcTSYMOdgAZ9SNLBR]"];
    
    
    
//    PFObject *player = [PFObject objectWithClassName:@"Player"];
//    player[@"Name"] = @"Richard";
//    player[@"Score"] = @951;
//    [player save];
//    player[@"Name"] = @"George";
//    player[@"Score"] = @13;
//    [player saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//       if (succeeded)
//       {
//           NSLog(@"Player was added to Parse.");
//       }
//        else
//        {
//            NSLog(@"Player Save failed: %@", [error localizedDescription]);
//        }
//    }];
    
//    PFQuery *query = [PFQuery queryWithClassName:@"Player"];
//    [query whereKey:@"Score" greaterThan:@500];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *object, NSError *error) {
//        if (!error) {
//            NSLog(@"Successfully retreived: %@", object);
//        }
//        else
//        {
//            NSLog(@"Error :%@", [error localizedDescription]);
//        }
//    }];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
