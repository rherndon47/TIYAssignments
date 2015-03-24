//
//  CounterItem.m
//  Counter
//
//  Created by Richard Herndon on 3/17/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "CounterItem.h"

@implementation CounterItem

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _counterTracker = 0;
    }
    
    return self;
}

@end
