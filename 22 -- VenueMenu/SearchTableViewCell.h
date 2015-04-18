//
//  SearchTableViewCell.h
//  22 -- VenueMenu
//
//  Created by Richard Herndon on 4/3/15.
//  Copyright (c) 2015 Richard Herndon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell

@property (strong,nonatomic) NSString *searchViewField;

@property (nonatomic) IBOutlet UILabel *resultLabel;

@end
