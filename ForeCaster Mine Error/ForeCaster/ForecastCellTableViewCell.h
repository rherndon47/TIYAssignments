//
//  ForecastCellTableViewCell.h
//  ForeCaster
//
//  Created by Richard Herndon on 3/23/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *displaySummary;
@property (weak, nonatomic) IBOutlet UILabel *displayCity;
@property (weak, nonatomic) IBOutlet UILabel *displayTemp;

@end
