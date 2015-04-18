//
//  TicketsTableViewController.h
//  Jackpot
//
//  Created by Jordan Anderson on 3/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TicketsTableViewControllerDelegate

- (void)winningTicketNumbersWasChosen:(NSArray *)lottoWinningNumbers;

@end

@interface TicketsTableViewController : UITableViewController <TicketsTableViewControllerDelegate>

@end
