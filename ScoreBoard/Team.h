//
//  Team.h
//  ScoreBoard
//
//  Created by Julien Chene on 9/1/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Team : NSObject

@property (retain, nonatomic) NSString          *teamName;
@property (retain, nonatomic) NSMutableArray    *playerList;

- (id)initWithName:(NSString*)name andPlayersList:(NSArray*)list;
- (int)countOfPlayerList;

@end
