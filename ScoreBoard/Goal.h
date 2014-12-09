//
//  Goal.h
//  ScoreBoard
//
//  Created by Julien Chene on 10/9/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Team.h"

@interface Goal : NSObject

@property (nonatomic, retain) Player    *strikerPlayer;
@property (nonatomic, retain) Player    *assistPlayer;
@property (nonatomic, retain) NSString  *scoringTeam;

- (id)initWithStriker:(Player*)striker assist:(Player*)assist andTeamName:(NSString*)teamName;

@end
