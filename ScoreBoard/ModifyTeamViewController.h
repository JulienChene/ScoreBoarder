//
//  ModifyTeamViewController.h
//  ScoreBoard
//
//  Created by Julien Chene on 10/11/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModifyTeamViewControllerDelegate <NSObject>

- (void)modifyTeamWithIndexPath:(NSIndexPath*)indexPath andGesture:(UIGestureRecognizer*)gestureRecognizer;

@end

@interface ModifyTeamViewController : UITableViewController
{
    NSMutableArray *firstTeamArray;
    NSMutableArray *secondTeamArray;
    NSMutableArray *allPlayers;
}

@property (nonatomic, retain) NSMutableArray *firstTeamArray;
@property (nonatomic, retain) NSMutableArray *secondTeamArray;
@property (nonatomic, retain) NSMutableArray *allPlayers;
@property (nonatomic, assign) id<ModifyTeamViewControllerDelegate> delegate;

@end
