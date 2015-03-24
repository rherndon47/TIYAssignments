//
//  HVCalculation.m
//  HighVoltage
//
//  Created by Richard Herndon on 3/12/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "HVCalculation.h"

@implementation HVCalculation

- (instancetype)init
{
    // instanceType is a generic variable for any kind of instance class
    self = [super init]; // creates an instance of the NSObject class
    if (self)
    {
        _ienergy = EngergyTypeNone;
    }
    
    return self;
}

+ (NSArray *)allEnergyTypes
{
    
    return @[@"Watts", @"Volts", @"amps", @"ohms"];
}

- (NSString *)energyTypeAsString
{
    NSString *rc;
    
    switch (self.ienergy)
    {
        case EngergyTypeWatts:
            rc = @"Watts";
            break;
            
        case EngergyTypeVolts:
            rc = @"Volts";
            break;
            
        case EngergyTypeamps:
            rc = @"amps";
            break;
            
        case EngergyTypeohms:
            rc = @"ohms";
            break;
        default:
            rc = @"";
            break;
    }
    return rc;
}
@end
