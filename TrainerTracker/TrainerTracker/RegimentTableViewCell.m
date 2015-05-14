//
//  RegimentTableViewCell.m
//  TrainerTracker
//
//  Created by Richard Herndon on 4/28/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import "RegimentTableViewCell.h"

@implementation RegimentTableViewCell

- (void)awakeFromNib {
    self.regimentNameLabel.text = @"";
    self.checkBoxButton.image = [UIImage imageNamed:@"Unchecked.png"];
}

@end
