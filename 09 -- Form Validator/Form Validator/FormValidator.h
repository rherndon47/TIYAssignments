//
//  FormValidator.h
//  Form Validator
//
//  Created by Jordan Anderson on 3/9/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FormValidator : NSObject

- (BOOL)validateName:(NSString *)name;
- (BOOL)validateAddress:(NSString *)address;
- (BOOL)validateCity:(NSString *)city;
- (BOOL)validateState:(NSString *)state;
- (BOOL)validateZipCode:(NSString *)zipCode;
- (BOOL)validatePhoneNumber:(NSString *)phoneNumber;


@end
