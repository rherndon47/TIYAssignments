//
//  HighVoltageTableViewController.h
//  HighVoltage
//
//  Created by Richard Herndon on 3/12/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PopupReturnDelegate

- (void)energyTypeWasSelected:(NSString *)energyString;

@end

@interface HighVoltageTableViewController : UITableViewController <PopupReturnDelegate>
@property (nonatomic,strong) NSMutableArray *energy;
@property (nonatomic,strong) NSMutableArray *popUpEnergyArray;

#define ACONS

@end
