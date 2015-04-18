//
//  FormValidator.m
//  Form Validator
//
//  Created by Jordan Anderson on 3/9/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "FormValidator.h"

@implementation FormValidator

- (BOOL)validateName:(NSString *)name
{
    BOOL rc = NO;
    
    if ([name containsString:@" "])
    {
        rc = YES;
    }
    
    return rc;
}

- (BOOL)validateAddress:(NSString *)address
{
    __block BOOL rc = NO;
    NSError *error = nil;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeAddress error:&error];
    
    [detector enumerateMatchesInString:address 
                               options:kNilOptions
                                 range:NSMakeRange(0, [address length])
                            usingBlock:
     ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
         rc = YES;
     }];

    return rc;
}

- (BOOL)validateCity:(NSString *)city
{
    BOOL rc = NO;
    
    if (![city isEqualToString:@""])
    {
        rc = YES;
        
    }
    
    return rc;
}

- (BOOL)validateState:(NSString *)state
{
    BOOL rc = NO;
    
    if ((state.length == 2)  && ([state uppercaseString]))
    {
        rc = YES;
    }
    
    return rc;
}

- (BOOL)validateZipCode:(NSString *)zipCode
{
    BOOL rc = NO;
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    if ([zipCode length] == 5 && [zipCode rangeOfCharacterFromSet:set].location != NSNotFound)
    {
        rc = YES;
    }
    
    return rc;
}

- (BOOL)validatePhoneNumber:(NSString *)phoneNumber
{
    __block BOOL rc = NO;
    NSError *error = nil;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:&error];
    
    [detector enumerateMatchesInString:phoneNumber
                               options:kNilOptions
                                 range:NSMakeRange(0, [phoneNumber length])
                            usingBlock:
     ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
         rc = YES;
     }];

    
    
    return rc;
}




@end
