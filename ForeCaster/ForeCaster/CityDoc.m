//
//  CityDoc.m
//  Forecaster
//
//  Created by Richard Herndon on 3/24/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CityDoc.h"
#import "CityDatabase.h"

#define kDataFile @"data.plist"
#define kDataKey @"data"


@implementation CityDoc

- (instancetype)init
{
    return self;
}

- (instancetype)initWithDocPath:(NSString *)docPath
{
    self = [super init];
    if (self)
    {
        _docPath = [docPath copy];
    }
    return self;
}

- (BOOL)createDataPath
{
    if (!self.docPath)
    {
        self.docPath = [CityDatabase nextCityDocPath];
    }
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:self.docPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success)
    {
        NSLog(@"Error creatring data path: %@", [error localizedDescription]);
    }
    
    return success;
}
- (void)saveData
{
    if (!self.city)
    {
        NSString *dataPath = [self.docPath stringByAppendingPathComponent:kDataFile];
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:self.city forKey:kDataKey];
        [archiver finishEncoding];
        [data writeToFile:dataPath atomically:YES];
    }
}

- (void)deleteDoc
{
    
}

@end
