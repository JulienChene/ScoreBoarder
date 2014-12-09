//
//  MatchPlayerInfo.h
//  ScoreBoard
//
//  Created by Julien Chene on 29/10/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface MatchPlayerInfo : NSObject

@property (nonatomic, retain) NSString  *playerName;
@property NSInteger                     playerNumber;
@property NSInteger                     playerGoals;
@property NSInteger                     playerAssist;

- (void)replaceWithPlayer:(Player*)newPlayer;

@end
