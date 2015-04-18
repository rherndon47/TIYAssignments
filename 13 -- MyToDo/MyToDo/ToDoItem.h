//
//  ToDoItem.h
//  MyToDo
//
//  Created by Richard Herndon on 3/16/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject
@property (strong, nonatomic) NSString *todoObjectString;
@property (strong, nonatomic) NSString *title;
@property (assign) BOOL done;

@end
