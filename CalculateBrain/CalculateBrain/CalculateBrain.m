//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Richard Herndon on 3/10/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CalculateBrain.h"


@implementation CalculatorBrain
{
    CalculatorBrain *brain;
}

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _operand1String = [[NSMutableString alloc] init];
        _operand2String = [[NSMutableString alloc] init];
        _operand1 = 0.0f;
        _operand2 = 0.0f;
        _operatorType = OperatorTypeNone;
        _userIsTypingANumber = NO;
        
    }
    
    return self;
}

- (NSString *) addOperandDigit:(NSString *)digit
{
    NSString *rc;
    if (self.operatorType == OperatorTypeNone)
    {
        [self.operand1String appendString:digit];
        rc = self.operand1String;
    }
    else
    {
        [self.operand2String appendString:digit];
        rc = self.operand2String;
    }
    
    return rc;
}

- (float) preformCalculation
{
    float returnValue;
    switch (_operatorType)
    {
            
        case OperatorTypeAddition:
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
            returnValue = self.operand1 + self.operand2;
            break;
        case OperatorTypeSubtraction:
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
            returnValue = self.operand1 - self.operand2;
            break;
        case OperatorTypeMultiplication:
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
            returnValue = self.operand1 * self.operand2;
            break;
        case OperatorTypeDivision:
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
            returnValue = self.operand1 / self.operand2;
            break;
            
        default:
            break;
    }
    return returnValue;
    
}

- (NSString *) insertDecimalPoint
{
    NSString *rc;
    
    if (self.operatorType == OperatorTypeNone)
    {
        if (![self.operand1String containsString:@"."])
        {
            [self.operand1String appendString:@"."];
        }
        
        rc = self.operand1String;
        
    }
    else if ([self.operand2String isEqualToString:@""])
    {
        self.operand2String = [@"0." mutableCopy];
        rc = self.operand2String;
        
    }
    else if (self.operand2String)
    {
        if (![self.operand2String containsString:@"."])
        {
            [self.operand2String appendString:@"."];
        }
        
        rc = self.operand2String;
        
    }
    
    return rc;
    
}

- (NSString *) percentConversion
{
    NSString *rc;
    if (![self.operand1String isEqualToString:@""])
    {
        float opReturn = [self.operand1String floatValue];
        rc = [NSString stringWithFormat:@"%.2f ",opReturn * .01];
        NSLog(@"holaaa");
    }
    return rc;
}

- (void) changeSign
{
    
    
    if (_operatorType == OperatorTypeNone)
    {
        self.operand1 = [self.operand1String floatValue];
        self.result = self.operand1 * -1.0;
        self.resultString = [NSString stringWithFormat:@"%g",self.result];
        [self.operand1String setString:self.resultString];
        
        
        //        return self.operand1;
    }
    else
    {
        self.operand2 = [self.operand2String floatValue];
        self.result = self.operand2 * -1.0;
        self.resultString = [NSString stringWithFormat:@"%.g",self.result];
        [self.operand2String setString:self.resultString];
        
        
    }
}

@end

