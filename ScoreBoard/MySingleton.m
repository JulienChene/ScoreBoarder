//
//  MySingleton.m
//  ScoreBoard
//
//  Created by Julien Chene on 10/3/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "MySingleton.h"

@implementation MySingleton

static MySingleton* _sharedMySingleton = nil;

@synthesize firstTeamName;
@synthesize secondTeamName;
@synthesize playerList;
@synthesize playerNumberIndex;
@synthesize matchList;

+(MySingleton*)sharedMySingleton
{
    if (_sharedMySingleton == nil)
    {
        _sharedMySingleton = [[super alloc] init];
    }
    
    return _sharedMySingleton;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self setFirstTeamName:[[NSString alloc] initWithFormat:@""]];
        [self setSecondTeamName:[[NSString alloc] initWithFormat:@""]];
        [self setPlayerList:[[NSMutableArray alloc] init]];
        [self setPlayerNumberIndex:[[NSMutableIndexSet alloc] init]];
        [self setMatchList:[[NSMutableArray alloc] init]];
    }
    
    return self;
}

- (void)dealloc
{
    [firstTeamName  release];
    [secondTeamName release];
    [playerList     release];
    
    [super          dealloc];
}

@end
