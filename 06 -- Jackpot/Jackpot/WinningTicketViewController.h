//
//  WinningTicketViewController.h
//  Jackpot
//
//  Created by Jordan Anderson on 3/4/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketsTableViewController.h"
#import "Ticket.h"

@interface WinningTicketViewController : UIViewController

@property (strong, nonatomic) id<TicketsTableViewControllerDelegate> delegate;

@end
