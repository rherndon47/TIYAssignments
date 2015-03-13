//
//  ViewController.m
//  Calculator
//
//  Created by Richard Herndon on 3/10/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain+Extras.h"

@interface ViewController ()
{
    CalculatorBrain *brain;
}

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;

-(IBAction)operandTapped:(UIButton *)sender;

-(IBAction)allClearButton:(UIButton *)sender;
//-(IBAction)decimalPointButton:(UIButton *)sender;
-(IBAction)percentConvertButton:(UIButton *)sender;
-(IBAction)additionTapped:(UIButton *)sender;
-(IBAction)subtractionTapped:(UIButton *)sender;
-(IBAction)multiplicationTapped:(UIButton *)sender;
-(IBAction)divisionTapped:(UIButton *)sender;
-(IBAction)equalTapped:(UIButton *)sender;
-(IBAction)signChangeTapped:(UIButton *)sender;
-(IBAction)squareRootTapped:(UIButton *)sender;
-(IBAction)squareTapped:(UIButton *)sender;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Calculator";
    self.displayLabel.text = @"0";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)operandTapped:(UIButton *)sender
{
    
    //    Old code before changing
    //
    //    if (!brain)
    //    {
    //        brain =[[CalculatorBrain alloc] init];
    //    }
    //
    //    self.displayLabel.text = [brain addOperandDigit:sender.titleLabel.text];
    
    //    New code received from Jim
    // operand tapped  section in Jims Calculator view controller
    
    
    // We have an operand button press , lets pull in numbers from operand buttons
    // and instanciate "brain"
    
    //- (IBAction)operandTapped:(UIButton *)sender
    //    {
    
    //        _showsTouchWhenHighlighted = NO;
    
    if (!brain)
    {
        brain = [[CalculatorBrain alloc] init];
        //          firstOperandSelected = YES;
    }
    
    
    
    if (brain.operatorType == OperatorTypeNone)
        
        // first operand picked
    {
        
        // operator (+ , -, * etc ) yet chosen
        // load first operand
        
        //        firstOperandSelected = YES;
        [brain.operand1String appendString:sender.titleLabel.text];
        self.displayLabel.text = brain.operand1String;
        
    }
    
    else
        
        //second operand picked
    {
        //       firstOperandSelected = NO;
        [brain.operand2String appendString:sender.titleLabel.text];
        self.displayLabel.text = brain.operand2String;
    }
    
    //    }
    
}

#pragma mark - Actions Handlers

-(IBAction)additionTapped:(UIButton *)sender
{
    brain.operatorType = OperatorTypeAddition;
    
}

-(IBAction)subtractionTapped:(UIButton *)sender
{
    brain.operatorType = OperatorTypeSubtraction;
}

-(IBAction)multiplicationTapped:(UIButton *)sender
{
    brain.operatorType = OperatorTypeMultiplication;
}

-(IBAction)divisionTapped:(UIButton *)sender
{
    brain.operatorType = OperatorTypeDivision;
}

-(IBAction)signChangeTapped:(UIButton *)sender
{
    NSLog(@"Entered signChangeTapped");
    //    brain.operatorType = OperatorTypeSignChange;
    
    [brain plusMinusOperand];
    
    self.displayLabel.text = [NSString stringWithFormat:@"%@", brain.resultString];
}

-(IBAction)squareRootTapped:(UIButton *)sender
{

    float squareRootTemp;
    
    squareRootTemp = [brain squareRoot];
    self.displayLabel.text = [NSString stringWithFormat:@"%@", brain.resultString];

}

-(IBAction)squareTapped:(UIButton *)sender
{
    
}

-(IBAction)equalTapped:(UIButton *)sender
{
    //    float returnValue = [brain performCalculation];
    [brain completeEquate];
    
    if ((brain.operatorType == OperatorTypeDivision) && (brain.operand2 == 0))
    {
        self.displayLabel.text = @"Error";
    }
    else
    {
        self.displayLabel.text = [NSString stringWithFormat:@"%g", brain.result];
        brain = nil;
    }
    
}

-(IBAction)allClearButton:(UIButton *)sender
{
    
    if (brain)
        
    {
        brain = nil;
        
        
    }
    self.displayLabel.text = @"0";
}


//   Old code removed because of changes when adding Jim's Brain method

//-(IBAction)decimalPointButton:(UIButton *)sender
//{
//    if (!brain)
//    {
//        brain =[[CalculatorBrain alloc] init];
//    }
//    self.displayLabel.text = [brain insertDecimalPoint];
//}
//
-(IBAction)percentConvertButton:(UIButton *)sender
{
    
    //    NSString *percent = [brain percentConversion];
    [brain percentOperand];
    self.displayLabel.text = brain.resultString;
    
}

@end
