//
//  PlayerInfoViewController.h
//  ScoreBoard
//
//  Created by Julien Chene on 09/11/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface PlayerInfoViewController : UIViewController
{
    UILabel IBOutlet *totalMatchLabel;
    UILabel IBOutlet *goalsLabel;
    UILabel IBOutlet *assistsLabel;
    UILabel IBOutlet *goalsPerMatchLabel;
    UILabel IBOutlet *assistsPerMatchLabel;
    UILabel IBOutlet *victoryLabel;
    UILabel IBOutlet *defeatLabel;
}

@property (nonatomic, retain) Player *playerInfo;

@end
