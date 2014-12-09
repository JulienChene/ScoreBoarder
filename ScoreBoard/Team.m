//
//  Team.m
//  ScoreBoard
//
//  Created by Julien Chene on 9/1/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "Team.h"
#import "Player.h"

@implementation Team

@synthesize teamName;
@synthesize playerList;

- (id)initWithName:(NSString*)name andPlayersList:(NSArray*)list
{
    self = [super init];
    
    if (self)
    {
        [self setTeamName:name];
        [self setPlayerList:[[NSMutableArray alloc] initWithArray:list]];
    }
    
    return self;
}

- (int) countOfPlayerList
{
    return [playerList count];
}

- (void)dealloc
{
    [teamName   release];
    [playerList release];
    
    [super      dealloc];
}

@end
