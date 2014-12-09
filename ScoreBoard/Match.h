//
//  Match.h
//  ScoreBoard
//
//  Created by Julien Chene on 10/9/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"

@interface Match : NSObject

@property (nonatomic, retain) Team              *teamOne;
@property (nonatomic, retain) Team              *teamTwo;
@property (nonatomic, assign) NSInteger         teamOneScore;
@property (nonatomic, assign) NSInteger         teamTwoScore;
@property (nonatomic, retain) NSMutableArray    *goalList;
@property (nonatomic, retain) NSMutableArray    *teamOneGoals;
@property (nonatomic, retain) NSMutableArray    *teamTwoGoals;
@property (nonatomic, retain) NSMutableArray    *matchsStars;
@property (nonatomic, retain) NSDate            *creationDate;
@property (nonatomic, retain) NSMutableArray    *bestPlayers;

- (id)initWithTeamOneName:(NSString*)teamOneName teamTwoName:(NSString*)teamTwoName teamOneList:(NSArray*)teamOneList teamTwoList:(NSArray*)teamTwoList teamOneScore:(NSInteger)scoreOne teamTwoScore:(NSInteger)scoreTwo goalList:(NSArray*)goals;
- (NSArray*)retrieveGoalsWithTeam:(int)teamNumber;
- (void)setPlayersMatches;

@end
