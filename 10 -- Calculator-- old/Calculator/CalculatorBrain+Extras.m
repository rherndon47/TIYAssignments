//
//  CalculatorBrain+Extras.m
//  Calculator
//
//  Created by Richard Herndon on 3/11/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CalculatorBrain+Extras.h"

@implementation CalculatorBrain (Extras)

- (float)squareRoot
{
    float rc = 0.0;
    self.operand1 = [self.operand1String floatValue];
    rc = sqrt(self.operand1);
    return rc;
}

- (float)square
{
    NSLog(@"entering square");

    float rc = 0.0;

    self.operand1 = [self.operand1String floatValue];
    self.result = self.operand1 * self.operand1;
    self.resultString = [NSString stringWithFormat:@"%g",self.result];
    NSLog(@"square %@",self.resultString);
    [self.operand1String setString:self.resultString];
    
    return rc;
}

@end
