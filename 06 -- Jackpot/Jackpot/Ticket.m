//
//  Ticket.m
//  Jackpot
//
//  Created by Jordan Anderson on 3/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "Ticket.h"

@interface Ticket ()
{
    NSMutableArray *picks;
    NSNumber *aNumber;
}

@end

@implementation Ticket

+ (instancetype)ticketUsingQuickPick
{
    Ticket *aTicket = [[Ticket alloc] init]; //create the ticket object
    if (aTicket)
    {
        for (int i = 0; i < 6; i++)
        {
            [aTicket createPick];
        }
    }
    
    return aTicket;
    
}

+ (instancetype)ticketUsingArray:(NSArray *)winningNumbers
{
    Ticket *winningTicket = [[Ticket alloc] init]; // for winning ticket object
    if (winningTicket)
    {
        [winningTicket createPicksWithArray:winningNumbers];
    }
    
    return winningTicket;
}


- (instancetype)init //creating a method to overwrite init
{
    if (self = [super init]) // says go to NSObject and run the init method
    {
        picks = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(NSString *)description
{
    // you want to use this to be able to call it in the view contrller, this changes the ticket to a nice formatted string with 6 numbers
    
    return [NSString stringWithFormat:@"%@  %@  %@  %@  %@  %@", picks[0], picks[1], picks[2], picks[3], picks[4], picks[5]];
    
}


-(void)createPick
{
    int pickInt = arc4random() % 53 + 1;
    aNumber = [NSNumber numberWithInt:pickInt];
    [picks addObject:aNumber]; // create a pick at random, turn it into a number, add it to the picks array
    NSSortDescriptor *numericalSortingUp = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [picks sortUsingDescriptors:@[numericalSortingUp]];
}

- (void)createPicksWithArray:(NSArray *)winningPicks
{
    picks = [winningPicks mutableCopy];

    
}



@end
