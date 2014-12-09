//
//  Match.m
//  ScoreBoard
//
//  Created by Julien Chene on 10/9/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "Goal.h"
#import "Match.h"
#import "MatchPlayerInfo.h"
#import "Player.h"
#import "MySingleton.h"

@implementation Match

@synthesize teamOne;
@synthesize teamTwo;
@synthesize teamOneScore;
@synthesize teamTwoScore;
@synthesize goalList;
@synthesize teamOneGoals;
@synthesize teamTwoGoals;
@synthesize matchsStars;
@synthesize creationDate;
@synthesize bestPlayers;

- (id)initWithTeamOneName:(NSString*)teamOneName
              teamTwoName:(NSString*)teamTwoName
              teamOneList:(NSArray*)teamOneList
              teamTwoList:(NSArray*)teamTwoList
             teamOneScore:(NSInteger)scoreOne
             teamTwoScore:(NSInteger)scoreTwo
                 goalList:(NSArray*)goals
{
    self = [super init];
    
    if (self)
    {
        [self setTeamOne:[[Team alloc] initWithName:teamOneName andPlayersList:teamOneList]];
        [self setTeamTwo:[[Team alloc] initWithName:teamTwoName andPlayersList:teamTwoList]];
        
        [self setTeamOneScore:scoreOne];
        [self setTeamTwoScore:scoreTwo];
        
        [self setGoalList:[[NSMutableArray alloc] initWithArray:goals]];
        [self setTeamOneGoals:[[NSMutableArray alloc] init]];
        [self setTeamTwoGoals:[[NSMutableArray alloc] init]];
        
        creationDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    }

    return self;
}

- (NSArray*)retrieveGoalsWithTeam:(int)teamNumber
{
    NSMutableArray *finalArray = [[[NSMutableArray alloc] init] autorelease];
    NSArray *currentTeam;
    
    if (teamNumber == 1)
        currentTeam = [teamOne playerList];
    else
        currentTeam = [teamTwo playerList];
    
    for (Player *tmpPlayer in currentTeam)
    {
        int count = 0;
        
        MatchPlayerInfo *tmpInfoPlayer = [[MatchPlayerInfo alloc] init];
        [tmpInfoPlayer replaceWithPlayer:tmpPlayer];
        for (Goal *tmpGoal in goalList)
        {
            if ([tmpPlayer isEqualToPlayer:[[goalList objectAtIndex:count] strikerPlayer]])
                [tmpInfoPlayer setPlayerGoals:[tmpInfoPlayer playerGoals] + 1];
            else
                if ([tmpPlayer isEqualToPlayer:[[goalList objectAtIndex:count] assistPlayer]])
                    [tmpInfoPlayer setPlayerAssist:[tmpInfoPlayer playerAssist] + 1];
            count++;
        }
        [finalArray addObject:tmpInfoPlayer];
        [tmpInfoPlayer release];
    }

    return finalArray;
}

- (void)setPlayersMatches
{
    bool teamOneVictory = false;
    bool isDraw = false;
    if (teamOneScore > teamTwoScore)
        teamOneVictory = true;
    
    if (teamOneScore == teamTwoScore)
        isDraw = true;
        
    NSLog(@"setPlayersMatches");
    for (Player *player in [teamOne playerList])
    {
        for (Player *cstPlayer in [[MySingleton sharedMySingleton] playerList])
        {
            if ([cstPlayer isEqualToPlayer:player])
            {
                [[player matchesPlayed] insertObject:self atIndex:0];
                if (isDraw)
                {
                    [player setPlayerVictory:[player playerVictory] + teamOneVictory];
                    [player setPlayerAssists:[player playerAssists] + !teamOneVictory];
                }
            }
        }
    }
    
    for (Player *player in [teamTwo playerList])
    {
        for (Player *cstPlayer in [[MySingleton sharedMySingleton] playerList])
        {
            if ([cstPlayer isEqualToPlayer:player])
            {
                [[player matchesPlayed] insertObject:self atIndex:0];
                if (isDraw)
                {
                    [player setPlayerVictory:[player playerVictory] + !teamOneVictory];
                    [player setPlayerAssists:[player playerAssists] + teamOneVictory];
                }
            }
        }
    }
}

- (void)dealloc
{
    [teamOne        release];
    [teamTwo        release];
    
    [goalList       release];
    [teamOneGoals   release];
    [teamTwoGoals   release];
    
    [matchsStars    release];
    [creationDate   release];
    
    [super          dealloc];
}

@end
