//
//  PlayerProfileViewController.m
//  ScoreBoard
//
//  Created by Julien Chene on 10/3/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "PlayerProfileViewController.h"
#import "MySingleton.h"

@interface PlayerProfileViewController ()

@end

@implementation PlayerProfileViewController

@synthesize playerProfile;

int firstPlayerNumber = 0;

- (id) initWithPlayer:(Player*)newPlayer
{
    self = [super init];
    if (self)
    {
        [self setPlayerProfile:newPlayer];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    firstPlayerNumber = [playerProfile playerNumber];
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
    if (section == 0)
        return 2;
    else
        return [[playerProfile matchesPlayed] count];
}

-(UITextField*) makeTextFieldWithText:(NSString*)aText Placeholder: (NSString*)placeholder  {
    UITextField *tf = [[[UITextField alloc] init] autorelease];
    tf.placeholder = placeholder ;
    tf.text = aText;
    tf.autocorrectionType = UITextAutocorrectionTypeNo ;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.adjustsFontSizeToFitWidth = YES;
    tf.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    return tf ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    if (indexPath.section == 0)
        CellIdentifier = @"PlayerEditCell";
    else
        CellIdentifier = @"PlayerMatchesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSLog(@"CellIdentifier : %@", CellIdentifier);
    
    if (indexPath.section == 0)
    {
        UITextField *tf = nil;
        if (indexPath.row == 0 && (indexPath.section == 0))
        {
            cell.textLabel.text = @"Nom";
            tf = nameField = [self makeTextFieldWithText:[playerProfile playerName] Placeholder:@"Marc Dupont"];
            [cell addSubview:nameField];
        }
    
        if (indexPath.row == 1 && (indexPath.section == 0))
        {
            cell.textLabel.text = @"Numéro";
            tf = numberField = [self makeTextFieldWithText:[NSString stringWithFormat:@"%d", [playerProfile playerNumber]] Placeholder:@"18"];
            [numberField setKeyboardType:UIKeyboardTypeNumberPad];
            [cell addSubview:numberField];
        }
    
        tf.frame = CGRectMake(90, 8, 170, 30);
    }
    else
        if ([[playerProfile matchesPlayed] count] > 0)
        {
            Match *matchPlayed = [[playerProfile matchesPlayed] objectAtIndex:indexPath.row];
        
            UILabel *teamsLabel = (UILabel*) [cell viewWithTag:601];
            [teamsLabel setText:[NSString stringWithFormat:@"%@ vs %@", [[matchPlayed teamOne] teamName], [[matchPlayed teamTwo] teamName]]];
        
            UILabel *dateLabel = (UILabel*) [cell viewWithTag:602];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEEE dd MMMM yyyy"];
            [dateLabel setText:[dateFormatter stringFromDate:[matchPlayed creationDate]]];
        
            [dateFormatter release];
        }
    
    return cell;
}





#pragma mark - IBActions

- (IBAction)editPlayerProfile:(id)sender
{
    if (![[nameField text] isEqualToString:@""] && (![[numberField text] isEqualToString:@""]))
    {
        
    }
    
    if (firstPlayerNumber != [[numberField text] intValue])
    {
        
    }
}

@end
