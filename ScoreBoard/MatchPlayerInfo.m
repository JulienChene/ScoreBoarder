//
//  MatchPlayerInfo.m
//  ScoreBoard
//
//  Created by Julien Chene on 29/10/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "MatchPlayerInfo.h"

@implementation MatchPlayerInfo

@synthesize playerName;
@synthesize playerGoals;
@synthesize playerAssist;

- (id)initWithName:(NSString*)name goalsNumber:(int)goals andAssists:(int)assist
{
    self = [super init];
    
    if (self)
    {
        [self setPlayerName:name];
        [self setPlayerGoals:goals];
        [self setPlayerAssist:assist];
    }
    
    return self;
}

- (void)replaceWithPlayer:(Player*)newPlayer
{
    [self setPlayerName:[newPlayer playerName]];
    [self setPlayerNumber:[newPlayer playerNumber]];
}

- (void)dealloc
{
    [playerName     release];
    
    [super          dealloc];
}

@end
