//
//  MatchBoardViewController.h
//  ScoreBoard
//
//  Created by Julien Chene on 10/9/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goal.h"
#import "ModifyTeamViewController.h"

@interface MatchBoardViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, ModifyTeamViewControllerDelegate>
{
    UILabel IBOutlet            *firstTeamName;
    UILabel IBOutlet            *secondTeamName;
    UILabel IBOutlet            *firstTeamScore;
    UILabel IBOutlet            *secondTeamScore;
    
    UIButton IBOutlet           *toolBarTitle;
    UIBarButtonItem IBOutlet    *nextButton;
    
    UIView IBOutlet             *strikerView;
    UIPickerView IBOutlet       *picker;
    
    NSMutableArray              *tmpArray;
}

@property (nonatomic, retain) NSMutableArray            *teamOnePlayers;
@property (nonatomic, retain) NSMutableArray            *teamTwoPlayers;
@property (nonatomic, retain) NSMutableArray            *remainingPlayers;


@property (nonatomic, retain) NSMutableArray            *goals;
@property (nonatomic, retain) UITapGestureRecognizer    *firstLabelGesture;
@property (nonatomic, retain) UITapGestureRecognizer    *secondLabelGesture;

@end
