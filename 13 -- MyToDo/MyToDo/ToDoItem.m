//
//  ToDoItem.m
//  MyToDo
//
//  Created by Richard Herndon on 3/16/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _done = NO;
    }
    
    return self;
}


@end
