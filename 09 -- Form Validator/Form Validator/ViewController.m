//
//  ViewController.m
//  Form Validator
//
//  Created by Jordan Anderson on 3/9/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"
#import "FormValidator.h"


@interface ViewController () <UITextFieldDelegate>
{
    FormValidator *validator;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    validator = [[FormValidator alloc] init];
    self.title = @"Validator";
    [self.nameTextField isFirstResponder];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
//    UIResponder *nextTextField;

//        NSInteger nextTag = textField.tag + 1;
//        // Try to find next responder
//        UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
//        if (nextResponder)
//        {
//            // Found next responder, so set it.
//            [nextResponder becomeFirstResponder];
//        }
//        else
//        {
//            // Not found, so remove keyboard.
//            [textField resignFirstResponder];
//        }
//        return NO; // We do not want UITextField to insert line-breaks.


    if (textField == self.nameTextField)
    {
        rc = [validator validateName:self.nameTextField.text];
        if (rc)
        {
            [self.nameTextField resignFirstResponder];
            [self.addressTextField becomeFirstResponder];
        }
    }
        
     if (textField == self.addressTextField)
    {
        rc = [validator validateAddress:self.addressTextField.text];
        if (rc)
        {
            [self.addressTextField resignFirstResponder];
            [self.cityTextField becomeFirstResponder];
        }
        
    }
    
     if (textField == self.cityTextField)
    {
        rc = [validator validateCity:self.cityTextField.text];
        if (rc)
        {
            [self.cityTextField resignFirstResponder];
            [self.stateTextField becomeFirstResponder];
        }
    }
    
     if (textField == self.stateTextField)
    {
        rc = [validator validateState:self.stateTextField.text];
        if (rc)
        {
            [self.stateTextField resignFirstResponder];
            [self.zipCodeTextField becomeFirstResponder];
        }
    }

     if (textField == self.zipCodeTextField)
    {
        rc = [validator validateZipCode:self.zipCodeTextField.text];
        if (rc)
        {
            [self.zipCodeTextField resignFirstResponder];
            [self.phoneNumberTextField becomeFirstResponder];
        }
    }
    
     if (textField == self.phoneNumberTextField)
    {
        rc = [validator validatePhoneNumber:self.phoneNumberTextField.text];
        if (rc)
        {
            [self.phoneNumberTextField resignFirstResponder];
        }
    }
    
//   
//    if (rc)
//    {
//        [textField resignFirstResponder]; // makes keyboard hide
//    }
    return rc;
}










@end
