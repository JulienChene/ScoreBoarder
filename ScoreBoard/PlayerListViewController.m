//
//  PlayerListViewController.m
//  ScoreBoard
//
//  Created by Julien Chene on 08/11/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "PlayerListViewController.h"
#import "Player.h"
#import "PlayerInfoViewController.h"
#import "MySingleton.h"

@interface PlayerListViewController ()

@end

@implementation PlayerListViewController

int chosenRow = 0;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[MySingleton sharedMySingleton] playerList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlayerListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Player *tmpPlayer = [[[MySingleton sharedMySingleton] playerList] objectAtIndex:indexPath.row];
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag:701];
    [nameLabel setText:[tmpPlayer playerName]];
    
    UILabel *numberLabel = (UILabel*) [cell viewWithTag:702];
    [numberLabel setText:[NSString stringWithFormat:@"Nº %d", [tmpPlayer playerNumber]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    chosenRow = indexPath.row;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PlayerInfoViewController *playerInfoVC = [segue destinationViewController];
    
    [playerInfoVC setPlayerInfo:[[[MySingleton sharedMySingleton] playerList] objectAtIndex:chosenRow]];
}




#pragma mark - IBAction

- (IBAction)backToMenu:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
