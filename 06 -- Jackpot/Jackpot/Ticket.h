//
//  Ticket.h
//  Jackpot
//
//  Created by Jordan Anderson on 3/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject

+ (instancetype)ticketUsingQuickPick;
+ (instancetype)ticketUsingArray:(NSArray *)winningNumbers; // take in winning numbers and turn into a ticket object

@end
