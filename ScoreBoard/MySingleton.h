//
//  MySingleton.h
//  ScoreBoard
//
//  Created by Julien Chene on 10/3/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Match.h"

@interface MySingleton : NSObject

@property (nonatomic, retain) NSString          *firstTeamName;
@property (nonatomic, retain) NSString          *secondTeamName;
@property (nonatomic, retain) NSMutableArray    *playerList;
@property (nonatomic, retain) NSMutableIndexSet *playerNumberIndex;
@property (nonatomic, retain) NSMutableArray    *matchList;

+(MySingleton*)sharedMySingleton;

@end
