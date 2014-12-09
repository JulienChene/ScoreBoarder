//
//  PlayerProfileViewController.h
//  ScoreBoard
//
//  Created by Julien Chene on 10/3/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface PlayerProfileViewController : UITableViewController
{
    UITextField     *nameField;
    UITextField     *numberField;
}

@property (nonatomic, retain) Player *playerProfile;

@end
