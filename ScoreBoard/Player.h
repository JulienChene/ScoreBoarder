//
//  Player.h
//  ScoreBoard
//
//  Created by Julien Chene on 9/1/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (retain, nonatomic) NSString          *playerName;
@property NSInteger                             playerNumber;
@property NSInteger                             playerGoals;
@property NSInteger                             playerAssists;
@property NSInteger                             playerVictory;
@property NSInteger                             playerDefeat;
@property (retain, nonatomic) NSMutableArray    *matchesPlayed;
@property (retain, nonatomic) NSDate            *playerAddedDate;

- (id)initWithName:(NSString*)name andNumber:(NSInteger)number;
- (BOOL)isEqualToPlayer:(Player*)anotherPlayer;

@end
