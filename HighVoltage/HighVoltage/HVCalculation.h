//
//  HVCalculation.h
//  HighVoltage
//
//  Created by Richard Herndon on 3/12/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    EngergyTypeNone,
    EngergyTypeWatts,
    EngergyTypeVolts,
    EngergyTypeamps,
    EngergyTypeohms
} EngergyType;

@interface HVCalculation : NSObject

@property (strong, nonatomic) NSString *highVoltageName;
@property (assign) EngergyType energy;

+ (NSArray *)allEnergyTypes;

- (NSString *)energyTypeAsString;

@end
