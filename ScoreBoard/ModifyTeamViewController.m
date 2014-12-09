//
//  ModifyTeamViewController.m
//  ScoreBoard
//
//  Created by Julien Chene on 10/11/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "ModifyTeamViewController.h"
#import "MySingleton.h"
#import "Player.h"

#define FIRST_TEAM_SECTION 0
#define SECOND_TEAM_SECTION 1
#define ALL_PLAYERS_SECTION 2

@interface ModifyTeamViewController ()

@end

@implementation ModifyTeamViewController

@synthesize firstTeamArray;
@synthesize secondTeamArray;
@synthesize allPlayers;
@synthesize delegate;

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

    [self.navigationController setToolbarHidden:YES animated:YES];
    
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Retour"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:nil
                                                                             action:nil] autorelease];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [firstTeamArray     release];
    [secondTeamArray    release];
    [allPlayers         release];
    
    [super              dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int arrayCount = 0;
    
    switch (section) {
        case FIRST_TEAM_SECTION:
            arrayCount = [firstTeamArray count];
            break;
            
        case SECOND_TEAM_SECTION:
            arrayCount = [secondTeamArray count];
            break;
            
        case ALL_PLAYERS_SECTION:
            arrayCount = [allPlayers count];
            break;
            
        default:
            break;
    }
    
    return arrayCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlayerTeamCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Player *tmpPlayer = nil;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell:)];
    [tapGesture setNumberOfTapsRequired:2];
    [tapGesture setNumberOfTouchesRequired:1];
    
    switch (indexPath.section) {
        case FIRST_TEAM_SECTION:
            if ([firstTeamArray count] > 0)
            {
                tmpPlayer = [firstTeamArray objectAtIndex:indexPath.row];
                
                [cell addGestureRecognizer:swipeRight];
                [cell addGestureRecognizer:tapGesture];
            }
            break;
            
        case SECOND_TEAM_SECTION:
            if ([secondTeamArray count] > 0)
            {
                tmpPlayer = [secondTeamArray objectAtIndex:indexPath.row];

                [cell addGestureRecognizer:tapGesture];
                [cell addGestureRecognizer:swipeLeft];
            }
            break;
            
        case ALL_PLAYERS_SECTION:
            tmpPlayer = [allPlayers objectAtIndex:indexPath.row];
            
            [cell addGestureRecognizer:swipeLeft];
            [cell addGestureRecognizer:swipeRight];
            
            break;
            
        default:
            break;
    }
    
    [swipeRight release];
    [swipeLeft release];
    
    UILabel *playerNameLabel = (UILabel*) [cell viewWithTag:301];
    UILabel *playerGoalsLabel = (UILabel*) [cell viewWithTag:302];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [playerNameLabel setText:[NSString stringWithFormat:@"%@ - %d", [tmpPlayer playerName], [tmpPlayer playerNumber]]];
    [playerNameLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:18]];
    
    [playerGoalsLabel setText:[NSString stringWithFormat:@"%d Buts/match", ([tmpPlayer playerGoals] / ([[tmpPlayer matchesPlayed] count] == 0 ? 1 : [[tmpPlayer matchesPlayed] count]))]];
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = @"";
    
    switch (section) {
        case FIRST_TEAM_SECTION:
            sectionTitle = [NSString stringWithFormat:@"%@", [[MySingleton sharedMySingleton] firstTeamName]];
            break;
            
        case SECOND_TEAM_SECTION:
            sectionTitle = [NSString stringWithFormat:@"%@", [[MySingleton sharedMySingleton] secondTeamName]];
            break;
            
        case ALL_PLAYERS_SECTION:
            sectionTitle = [NSString stringWithFormat:@"Joueurs"];
            break;
            
        default:
            break;
    }
    
    return sectionTitle;
}


#pragma  mark - Gesture Recognizer methods

- (void)swipeRight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    if(indexPath)
    {
        switch (indexPath.section) {
            case ALL_PLAYERS_SECTION:
                [secondTeamArray addObject:[allPlayers objectAtIndex:indexPath.row]];
                [allPlayers removeObjectAtIndex:indexPath.row];
                break;
                
            case FIRST_TEAM_SECTION:
                [secondTeamArray addObject:[firstTeamArray objectAtIndex:indexPath.row]];
                [firstTeamArray removeObjectAtIndex:indexPath.row];
                
            default:
                break;
        }
        
    //    [[self delegate] modifyTeamWithIndexPath:indexPath andGesture:gestureRecognizer];
        [self.tableView reloadData];
    }
}

- (void)swipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    if(indexPath)
    {
        switch (indexPath.section) {
            case ALL_PLAYERS_SECTION:
                [firstTeamArray addObject:[allPlayers objectAtIndex:indexPath.row]];
                [allPlayers removeObjectAtIndex:indexPath.row];
                break;
                
            case SECOND_TEAM_SECTION:
                [firstTeamArray addObject:[secondTeamArray objectAtIndex:indexPath.row]];
                [secondTeamArray removeObjectAtIndex:indexPath.row];
            default:
                break;
        }
        
        [[self delegate] modifyTeamWithIndexPath:indexPath andGesture:gestureRecognizer];
        [self.tableView reloadData];
    }
}

- (void)tapCell:(UITapGestureRecognizer*)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    if(indexPath)
    {
        switch (indexPath.section) {
            case FIRST_TEAM_SECTION:
                [allPlayers addObject:[firstTeamArray objectAtIndex:indexPath.row]];
                [firstTeamArray removeObjectAtIndex:indexPath.row];
                break;
                
            case SECOND_TEAM_SECTION:
                [allPlayers addObject:[secondTeamArray objectAtIndex:indexPath.row]];
                [secondTeamArray removeObjectAtIndex:indexPath.row];
            default:
                break;
        }

        [[self delegate] modifyTeamWithIndexPath:indexPath andGesture:gestureRecognizer];
        [self.tableView reloadData];
    }
}



#pragma mark - Navigation

- (IBAction)changeTeams:(id)sender
{
    if ([firstTeamArray count] > 0 && [secondTeamArray count] > 0)
        [self.navigationController popViewControllerAnimated:true];
}

@end

