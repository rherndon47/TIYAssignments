//
//  ToDoItem.m
//  ToDo
//
//  Created by Richard Herndon on 3/12/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

// TODO: override init so priority can be initially set to none

- (instancetype)init
{
    // instanceType is a generic variable for any kind of instance class
    self = [super init]; // creates an instance of the NSObject class
    if (self)
    {
        _priority = TaskPriorityNone;
    }
    
    return self;
    
    
}

+ (NSArray *)allPriorityTypes
{
    return @[@"low", @"Medium", @"High"];
}

- (NSString *)priorityAsString
{
    NSString *rc;
    
    switch (self.priority)
    {
        case TaskPriorityLow:
            rc = @"Low";
            break;
            
        case TaskPriorityMedium:
            rc = @"Medium";
            break;
            
        case TaskPriorityHigh:
            rc = @"High";
            break;
            
        default:
            rc = @"";
            break;
    }
    return rc;
}

@end
