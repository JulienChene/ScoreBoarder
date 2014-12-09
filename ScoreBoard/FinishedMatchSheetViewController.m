//
//  FinishedMatchSheetViewController.m
//  ScoreBoard
//
//  Created by Julien Chene on 15/11/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "FinishedMatchSheetViewController.h"
#import "MatchPlayerInfo.h"

@interface FinishedMatchSheetViewController ()

@end

@implementation FinishedMatchSheetViewController

@synthesize finishedMatch;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Retour"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:nil
                                                                             action:nil] autorelease];
}

- (void)dealloc
{
    [finishedMatch  release];
    
    [super          dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
        return [[finishedMatch teamOne] countOfPlayerList];
    else
        return [[finishedMatch teamTwo] countOfPlayerList];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return [NSString stringWithFormat:@"%@ - %d buts", [[finishedMatch teamOne] teamName], [finishedMatch teamOneScore]];
    else
        return [NSString stringWithFormat:@"%@ - %d buts", [[finishedMatch teamTwo] teamName], [finishedMatch teamTwoScore]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MatchSheetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    MatchPlayerInfo *tmpPlayer = nil;
    
    if (indexPath.section == 0)
        tmpPlayer = [[finishedMatch teamOneGoals] objectAtIndex:indexPath.row];
    else
        tmpPlayer = [[finishedMatch teamTwoGoals] objectAtIndex:indexPath.row];
    
    UILabel *playerNameLabel = (UILabel*) [cell viewWithTag:401];
    [playerNameLabel setText:[NSString stringWithFormat:@"%@ Nº %d", [tmpPlayer playerName],[tmpPlayer playerNumber]]];
    [playerNameLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:18]];
    
    UILabel *playerGoalsLabel = (UILabel*) [cell viewWithTag:402];
    [playerGoalsLabel setText:[NSString stringWithFormat:@"%d", [tmpPlayer playerGoals]]];
    
    UILabel *playerAssistLabel = (UILabel*) [cell viewWithTag:403];
    [playerAssistLabel setText:[NSString stringWithFormat:@"%d", [tmpPlayer playerAssist]]];
    
    return cell;
}

@end
