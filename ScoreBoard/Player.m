//
//  Player.m
//  ScoreBoard
//
//  Created by Julien Chene on 9/1/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize playerName;
@synthesize playerNumber;
@synthesize playerGoals;
@synthesize playerAssists;
@synthesize matchesPlayed;
@synthesize playerAddedDate;

- (id)initWithName:(NSString*)name andNumber:(NSInteger)number
{
    self = [super init];
    
    if (self)
    {
        [self setPlayerName:name];
        [self setPlayerNumber:number];
        [self setPlayerGoals:0];
        [self setPlayerAssists:0];
        [self setPlayerVictory:0];
        [self setPlayerDefeat:0];
        [self setMatchesPlayed:[[NSMutableArray alloc] init]];
        [self setPlayerAddedDate:[NSDate date]];
    }
    return self;
}

- (BOOL)isEqualToPlayer:(Player*)anotherPlayer
{
    if ([[self playerName] isEqualToString:[anotherPlayer playerName]] &
        ([self playerNumber] == [anotherPlayer playerNumber]) &
        [[self playerAddedDate] compare:[anotherPlayer playerAddedDate]] == NSOrderedSame)
        return true;
    else
        return false;
}

- (void)dealloc
{
    [playerName         release];
    [playerAddedDate    release];
    [matchesPlayed      release];
    
    [super              dealloc];
}

@end
