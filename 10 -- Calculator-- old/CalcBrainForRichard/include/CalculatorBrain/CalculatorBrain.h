//
//  CalculatorBrain.h
//  CalculatorBrain
//
//  Created by Jim on 3/10/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//


#import <Foundation/Foundation.h>


typedef enum
{
    OperatorTypeNone,     // first operand in edited
    OperatorTypeAddition,
    OperatorTypeSubtraction,
    OperatorTypeMultiplication,
    OperatorTypeDivision,
    OperatorTypePercent,
    OperatorTypePlusMinus
    
} OperatorType;

@interface CalculatorBrain : NSObject


//inputs
@property (strong, nonatomic) NSMutableString *operand1String; // inputs in MSMutableString format
@property (strong, nonatomic) NSMutableString *operand2String;


//outputs
@property (strong, nonatomic) NSString *resultString;          // output in NSString format


// access to floats internal useage, just in case...
@property (assign) float operand1;
@property (assign) float operand2;
@property (assign) float result;


//Enums indicating which operator has been pressed
// set these before calling completeEquate when equals
// button is pressed.
@property (assign) OperatorType operatorType;


// not used
@property (assign) BOOL userIsTypingANumber;


// when equal sign is pressed call this method
- (void) completeEquate;

// single operand functions.
// (note these methods do not work on
// the calculated result, only the operands.)
- (void) plusMinusOperand;
- (void) percentOperand;

// stuff for future reference examples
//- (void) plusMinusOperand:(BOOL)firstOperandSelected;


@end
