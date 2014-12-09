//
//  PlayerInfoViewController.m
//  ScoreBoard
//
//  Created by Julien Chene on 09/11/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "PlayerInfoViewController.h"

@interface PlayerInfoViewController ()

@end

@implementation PlayerInfoViewController

@synthesize playerInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:[playerInfo playerName]];
    
    [totalMatchLabel setText:[NSString stringWithFormat:@"%d", [[playerInfo matchesPlayed] count]]];
    [goalsLabel setText:[NSString stringWithFormat:@"%d", [playerInfo playerGoals]]];
    [assistsLabel setText:[NSString stringWithFormat:@"%d", [playerInfo playerAssists]]];
    [goalsPerMatchLabel setText:[NSString stringWithFormat:@"%d", [playerInfo playerGoals] / [[playerInfo matchesPlayed] count]]];
    [assistsPerMatchLabel setText:[NSString stringWithFormat:@"%d", [playerInfo playerAssists] / [[playerInfo matchesPlayed] count]]];
    [victoryLabel setText:[NSString stringWithFormat:@"%d", [playerInfo playerVictory]]];
    [defeatLabel setText:[NSString stringWithFormat:@"%d", [playerInfo playerDefeat]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
