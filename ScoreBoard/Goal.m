//
//  Goal.m
//  ScoreBoard
//
//  Created by Julien Chene on 10/9/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "Goal.h"

@implementation Goal

@synthesize strikerPlayer;
@synthesize assistPlayer;
@synthesize scoringTeam;

- (id)initWithStriker:(Player*)striker assist:(Player*)assist andTeamName:(NSString*)teamName
{
    self = [super init];
    
    if (self)
    {
        [self setStrikerPlayer:striker];
        [self setAssistPlayer:assist];
        [self setScoringTeam:teamName];
    }

    return self;
}

- (void)dealloc
{
    [strikerPlayer  release];
    [assistPlayer   release];
    [scoringTeam    release];
    
    [super          dealloc];
}

@end
