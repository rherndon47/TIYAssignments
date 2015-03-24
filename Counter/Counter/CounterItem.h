//
//  CounterItem.h
//  Counter
//
//  Created by Richard Herndon on 3/17/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CounterItem : NSObject

@property (strong, nonatomic) NSString *title;
@property (assign) BOOL done;
@property (assign) int counterTracker;

@end
