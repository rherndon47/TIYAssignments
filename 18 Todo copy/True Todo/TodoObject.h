//
//  TodoObject.h
//  True Todo
//
//  Created by Richard Herndon on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoObject : NSObject


@property (strong, nonatomic) NSString *todoObjectString;
@property (assign) BOOL done;
@property (strong, nonatomic) NSDate *dueDate;
@property (strong, nonatomic) NSString *taskNotes;
@property (strong, nonatomic) NSString *POISearhCriteria;
@property (strong, nonatomic) NSString *POIName;
@property (assign) double latitude;
@property (assign) double longitude;
@property (strong, nonatomic) NSString *POIAddress;

@end
