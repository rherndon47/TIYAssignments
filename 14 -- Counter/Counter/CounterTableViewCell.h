//
//  CounterTableViewCell.h
//  Counter
//
//  Created by Richard Herndon on 3/17/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CounterItem.h"

@interface CounterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *addToCounterButton;
@property (weak, nonatomic) IBOutlet UIButton *subtractFromCounterButton;
@property (weak, nonatomic) IBOutlet UITextField *counterNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *displayCounterLabel;



@end
