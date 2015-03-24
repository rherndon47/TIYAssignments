//
//  CounterTableViewCell.m
//  Counter
//
//  Created by Richard Herndon on 3/17/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "CounterTableViewCell.h"
#import "CounterItem.h"

@implementation CounterTableViewCell


- (void)awakeFromNib {
    // Initialization code
    NSLog(@"Entered awakeFromNib in CounterTableViewCell");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    NSLog(@"Entered setSelected in CounterTableViewCell");
}

@end
