//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Richard Herndon on 3/10/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

typedef enum
{
  OperatorTypeNone,
  OperatorTypeAddition,
  OperatorTypeSubtraction,
  OperatorTypeMultiplication,
  OperatorTypeDivision,
  OperatorTypeSignChange
} OperatorType;


@interface CalculatorBrain : NSObject

@property (strong, nonatomic) NSMutableString *operand1String;
@property (strong, nonatomic) NSMutableString *operand2String;

@property (assign) float operand1;
@property (assign) float operand2;
@property (assign) OperatorType operatorType;
@property (assign) BOOL userIsTypingANumber;
@property (strong, nonatomic) NSString *resultString;
@property (assign) float result;

- (NSString *) addOperandDigit:(NSString *)digit;
- (NSString *) insertDecimalPoint;

- (float) preformCalculation;

- (NSString *) percentConversion;
- (void) changeSign;




@end
