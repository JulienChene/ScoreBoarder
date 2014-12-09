//
//  PlayersViewController.m
//  ScoreBoard
//
//  Created by Julien Chene on 9/3/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "CreatePlayerViewController.h"
#import "MySingleton.h"
#import "PlayerProfileViewController.h"
#import "PlayersViewController.h"
#import "Player.h"

@interface PlayersViewController ()

@end

@implementation PlayersViewController

int playerProfileRow;

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

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Toolbar Button selectors

- (IBAction)addPlayer:(id)sender
{
    CreatePlayerViewController *createViewController = [[CreatePlayerViewController alloc] init];
    [createViewController setDelegate:self];
    [self performSegueWithIdentifier:@"CreatePlayerSegue" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"CreatePlayerSegue"])
    {
        CreatePlayerViewController *createViewController = [segue destinationViewController];
        [createViewController setDelegate:self];
    }
    
    if ([[segue identifier] isEqualToString:@"PlayerSelectedSegue"])
    {
        PlayerProfileViewController *profileViewController = [segue destinationViewController];
        [profileViewController setPlayerProfile:[[[MySingleton sharedMySingleton] playerList] objectAtIndex:playerProfileRow]];
    }
}

- (IBAction)editPlayers:(id)sender
{
    UIBarButtonItem *editButton = (UIBarButtonItem*)sender;
    if ([[editButton title] isEqualToString:@"Éditer"])
    {
        [self.tableView setEditing:true];
        [editButton setTitle:@"Terminer"];
    }
    else
    {
        [self.tableView setEditing:false];
        [editButton setTitle:@"Éditer"];
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"player number : %d", [[[MySingleton sharedMySingleton] playerList] count]);
    return [[[MySingleton sharedMySingleton] playerList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlayerListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Player *tmpPlayer = [[[MySingleton sharedMySingleton] playerList] objectAtIndex:indexPath.row];
    
    UILabel *playerNameLabel = (UILabel*) [cell viewWithTag:101];
    [playerNameLabel setText:[tmpPlayer playerName]];
    [playerNameLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:18]];
    
    UILabel *playerGoalsLabel = (UILabel*) [cell viewWithTag:102];
    [playerGoalsLabel setText:[NSString stringWithFormat:@"%d Buts/match", ([tmpPlayer playerGoals] / ([[tmpPlayer matchesPlayed] count] == 0 ? 1 : [[tmpPlayer matchesPlayed] count]))]];
    
    UILabel *playerNumberLabel = (UILabel*) [cell viewWithTag:103];
    [playerNumberLabel setText:[NSString stringWithFormat:@"Nº %d", [tmpPlayer playerNumber]]];
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[[MySingleton sharedMySingleton] playerNumberIndex] removeIndex:[[[[MySingleton sharedMySingleton] playerList] objectAtIndex:indexPath.row] playerNumber]];
        [[[MySingleton sharedMySingleton] playerList] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tableView isEditing])
    {
        playerProfileRow = indexPath.row;
        [self performSegueWithIdentifier:@"PlayerSelectedSegue" sender:nil];
    }
}




#pragma mark - CreatePlayerDelegate

- (void)addPlayerToListWithName:(NSString *)playerName andNumber:(NSInteger)playerNumber
{
    Player *newPlayer = [[Player alloc] initWithName:playerName andNumber:playerNumber];
    
    [[[MySingleton sharedMySingleton] playerList] addObject:newPlayer];
    [self.tableView reloadData];
    [newPlayer release];
    NSLog(@"Player added %@", [newPlayer playerName]);
}

@end
