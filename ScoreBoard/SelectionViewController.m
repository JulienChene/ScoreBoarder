//
//  SelectionViewController.m
//  ScoreBoard
//
//  Created by Julien Chene on 9/27/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "SelectionViewController.h"
#import "MatchBoardViewController.h"
#import "MySingleton.h"
#import "Player.h"

#define FIRST_TEAM_SECTION 0
#define SECOND_TEAM_SECTION 1
#define ALL_PLAYERS_SECTION 2

@interface SelectionViewController ()

@end

@implementation SelectionViewController

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
    
    firstTeamArray = [[NSMutableArray alloc] init];
    secondTeamArray = [[NSMutableArray alloc] init];
    allPlayers = [[NSMutableArray alloc] initWithArray:[[MySingleton sharedMySingleton] playerList]];

    Player *marc = [[Player alloc] initWithName:@"Marc" andNumber:19];
    Player *philippe = [[Player alloc] initWithName:@"Philippe" andNumber:20];
    Player *jean = [[Player alloc] initWithName:@"Jean" andNumber:28];
    Player *paul = [[Player alloc] initWithName:@"Paul" andNumber:30];
    
    Player *jacques = [[Player alloc] initWithName:@"Jacques" andNumber:30];
    Player *etienne = [[Player alloc] initWithName:@"Etienne" andNumber:30];
    Player *louis = [[Player alloc] initWithName:@"Louis" andNumber:30];
    Player *pierre = [[Player alloc] initWithName:@"Pierre" andNumber:30];
    
    [firstTeamArray addObject:marc];
    [firstTeamArray addObject:philippe];
    [firstTeamArray addObject:jean];
    [firstTeamArray addObject:paul];

    [secondTeamArray addObject:jacques];
    [secondTeamArray addObject:etienne];
    [secondTeamArray addObject:louis];
    [secondTeamArray addObject:pierre];
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
    
    UITapGestureRecognizer *tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell:)] autorelease];
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

                [cell addGestureRecognizer:swipeLeft];
                [cell addGestureRecognizer:tapGesture];
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
    [swipeLeft  release];
    
    UILabel *playerNameLabel = (UILabel*) [cell viewWithTag:201];
    UILabel *playerGoalsLabel = (UILabel*) [cell viewWithTag:202];
    
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
        //Get the cell out of the table view
        //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
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
        

        [self.tableView reloadData];
    }
}

- (void)swipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    CGPoint location = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    if(indexPath)
    {
        //Get the cell out of the table view
        //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
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
        
        [self.tableView reloadData];
    }
}



#pragma mark - Navigation

- (IBAction)validateToMatch:(id)sender
{
    if ([firstTeamArray count] > 0 && [secondTeamArray count] > 0)
        [self performSegueWithIdentifier:@"MatchBoardSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MatchBoardSegue"])
    {
        MatchBoardViewController *matchBoardVC = [segue destinationViewController];
  
        [matchBoardVC setTeamOnePlayers:firstTeamArray];
        [matchBoardVC setTeamTwoPlayers:secondTeamArray];
        [matchBoardVC setRemainingPlayers:allPlayers];
    }
}


@end
