//
//  ToDoItem.h
//  ToDo
//
//  Created by Richard Herndon on 3/12/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    TaskPriorityNone,
    TaskPriorityLow,
    TaskPriorityMedium,
    TaskPriorityHigh
} TaskPriority;

@interface ToDoItem : NSObject

@property (strong, nonatomic) NSString *taskName;
@property (assign) TaskPriority priority;

+ (NSArray *)allPriorityTypes;

- (NSString *)priorityAsString;

@end
