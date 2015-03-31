//
//  TodoObject.m
//  True Todo
//
//  Created by Apple on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TodoObject.h"

@implementation TodoObject

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _done = NO; //setting the assigned BOOL property default to NO
    }
    
    return self;
}


@end
