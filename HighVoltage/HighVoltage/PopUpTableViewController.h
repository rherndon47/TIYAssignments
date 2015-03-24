//
//  PopUpTableViewController.h
//  HighVoltage
//
//  Created by Richard Herndon on 3/12/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighVoltageTableViewController.h"

@interface PopUpTableViewController : UITableViewController

@property (strong, nonatomic) id<PopupReturnDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *energy;
@property (strong, nonatomic) NSString *firstTimeThru;

@end
