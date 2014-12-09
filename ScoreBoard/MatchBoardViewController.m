//
//  MatchBoardViewController.m
//  ScoreBoard
//
//  Created by Julien Chene on 10/9/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "MatchBoardViewController.h"
#import "MatchSheetViewController.h"
#import "Match.h"
#import "ModifyTeamViewController.h"
#import "MySingleton.h"
#import "Player.h"

#define STRIKER_VIEW_ORIGIN_Y   ([[UIScreen mainScreen] bounds].size.height * 0.4375)
#define TOOLBAR_HEIGHT          44
#define NO_ASSIST               @"No assist"

@interface MatchBoardViewController ()

@property (nonatomic, retain) Goal              *tmpGoal;
@property (nonatomic, retain) NSMutableArray    *bestPlayers;

@end

@implementation MatchBoardViewController

@synthesize teamOnePlayers;
@synthesize teamTwoPlayers;
@synthesize remainingPlayers;

@synthesize tmpGoal;
@synthesize goals;
@synthesize bestPlayers;
@synthesize firstLabelGesture;
@synthesize secondLabelGesture;

bool    isTeamOneScoring = false;
bool    isAssistSelecting = false;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = true;
    
    [picker setDataSource:self];
    [picker setDelegate:self];
    
    [firstTeamName setText:[[MySingleton sharedMySingleton] firstTeamName]];
    [secondTeamName setText:[[MySingleton sharedMySingleton] secondTeamName]];
    
    firstLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerAppearance:)];
    [firstLabelGesture setNumberOfTapsRequired:1];
    [firstLabelGesture setNumberOfTouchesRequired:1];
    
    secondLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerAppearance:)];
    [secondLabelGesture setNumberOfTapsRequired:1];
    [secondLabelGesture setNumberOfTouchesRequired:1];
    
    [firstTeamScore setUserInteractionEnabled:YES];
    [secondTeamScore setUserInteractionEnabled:YES];
    
    [firstTeamScore addGestureRecognizer:firstLabelGesture];
    [secondTeamScore addGestureRecognizer:secondLabelGesture];
    
    [self   setBestPlayers:[[NSMutableArray alloc] init]];
    [bestPlayers addObjectsFromArray:teamOnePlayers];
    [bestPlayers addObjectsFromArray:teamTwoPlayers];
    
    tmpArray = [[NSMutableArray alloc] init];
    tmpGoal = [[Goal alloc] init];
    goals = [[NSMutableArray alloc] init];
    
    [firstLabelGesture  release];
    [secondLabelGesture release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [tmpArray               release];
    
    [teamOnePlayers         release];
    [teamTwoPlayers         release];
    [remainingPlayers       release];
    
    [tmpGoal                release];
    [goals                  release];
    [bestPlayers            release];
    [firstLabelGesture      release];
    [secondLabelGesture     release];
    
    [super                  dealloc];
}





#pragma mark - PickerView Data Source

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (isAssistSelecting)
        return [tmpArray count];
    if (isTeamOneScoring)
        return [teamOnePlayers count];
    return [teamTwoPlayers count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}




#pragma mark - PickerView Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *playerName = @"";
    
    if (isAssistSelecting)
    {
        if (row == 0)
            playerName = @"Pas d'assist";
        else
            playerName = [NSString stringWithFormat:@"%@ - %d", [[tmpArray objectAtIndex:row] playerName], [[tmpArray objectAtIndex:row] playerNumber]];
    }
    else
    {
        if (isTeamOneScoring)
            playerName = [NSString stringWithFormat:@"%@ - %d", [[teamOnePlayers objectAtIndex:row] playerName], [[teamOnePlayers objectAtIndex:row] playerNumber]];
        else
            playerName = [NSString stringWithFormat:@"%@ - %d", [[teamTwoPlayers objectAtIndex:row] playerName], [[teamTwoPlayers objectAtIndex:row] playerNumber]];
    }
    
    return playerName;
}




#pragma mark - Score Label Handling

- (NSString*)getScoreFormated:(NSInteger)score
{
    NSString *formatedString = @"00";
    
    if (score < 10)
        formatedString = [NSString stringWithFormat:@"0%d", score];
    else
        formatedString = [NSString stringWithFormat:@"%d", score];
    
    return formatedString;
}

- (void)changeScoreWithTeam:(BOOL)isFirstTeamScoring
{
    if (isFirstTeamScoring)
        [firstTeamScore setText:[self getScoreFormated:[firstTeamScore text].intValue + 1]];
    else
        [secondTeamScore setText:[self getScoreFormated:[secondTeamScore text].intValue + 1]];
}




#pragma mark - IBAction Handler

- (IBAction)addStriker:(id)sender
{
    if ([[[toolBarTitle titleLabel] text] isEqualToString:@"Buteur"])
    {
        isAssistSelecting = true;
        [[toolBarTitle titleLabel] setText:@"Assist"];
        [nextButton setTitle:@"Ajouter"];
        
        [self selectPlayerWithRow:[picker selectedRowInComponent:0]];
        [self animatePickerView];
    }
    else
    {
        CGRect viewFrame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - TOOLBAR_HEIGHT, strikerView.frame.size.width, strikerView.frame.size.height);
        [UIView animateWithDuration:0.2
                         animations:^{strikerView.frame = viewFrame;}
                         completion:^(BOOL finished){
                             if (finished)
                             {
                                 [[toolBarTitle titleLabel] setText:@"Buteur"];
                                 [nextButton setTitle:@"Suivant"];
                                 [firstTeamScore setUserInteractionEnabled:true];
                                 [secondTeamScore setUserInteractionEnabled:true];
                                 isAssistSelecting = false;
                                 [self addAssistToGoal];
                                 [tmpArray removeAllObjects];
                             }
                         }];
        
        [self changeScoreWithTeam:isTeamOneScoring];
    }
}

- (void)selectPlayerWithRow:(NSInteger)row
{
    [tmpArray addObject:[[Player alloc] initWithName:NO_ASSIST andNumber:0]];
    
    if (isTeamOneScoring)
        [tmpArray addObjectsFromArray:teamOnePlayers];
    else
        [tmpArray addObjectsFromArray:teamTwoPlayers];
    
    Player *tmpPlayer = [tmpArray objectAtIndex:row + 1];
    [tmpGoal setStrikerPlayer:tmpPlayer];
    [tmpArray removeObjectAtIndex:row + 1];
}

- (void)addAssistToGoal
{
    Player *tmpPlayer = [tmpArray objectAtIndex:[picker selectedRowInComponent:0]];
    
    if ([[tmpPlayer playerName] isEqualToString:@"No assist"] && [tmpPlayer playerNumber] == 0)
        [tmpGoal setAssistPlayer:nil];
    else
        [tmpGoal setAssistPlayer:tmpPlayer];
    
    Goal *uniqueGoal = [[Goal alloc] initWithStriker:[tmpGoal strikerPlayer] assist:[tmpGoal assistPlayer] andTeamName:[tmpGoal scoringTeam]];
    
    [goals addObject:uniqueGoal];
    [self addGoalForPlayer:[tmpGoal strikerPlayer] andAssist:[tmpGoal assistPlayer]];
    
    [uniqueGoal release];
    [tmpPlayer release];
}

- (IBAction)cancelStrikerSelection:(id)sender
{
    CGRect viewFrame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - TOOLBAR_HEIGHT, strikerView.frame.size.width, strikerView.frame.size.height);
    [UIView animateWithDuration:0.2
                     animations:^{strikerView.frame = viewFrame;}
                     completion:^(BOOL finished){
                         [[toolBarTitle titleLabel] setText:@"Buteur"];
                         [nextButton setTitle:@"Suivant"];
                         [firstTeamScore setUserInteractionEnabled:true];
                         [secondTeamScore setUserInteractionEnabled:true];
                         isAssistSelecting = false;
                         [tmpArray removeAllObjects];
                     }];
}

- (void)pickerAppearance:(UIGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer == firstLabelGesture)
    {
        isTeamOneScoring = true;
        [secondTeamScore setUserInteractionEnabled:false];
        [tmpGoal setScoringTeam:[firstTeamName text]];
    }
    else
    {
        isTeamOneScoring = false;
        [firstTeamScore setUserInteractionEnabled:false];
        [tmpGoal setScoringTeam:[secondTeamName text]];
    }
    
    [picker reloadAllComponents];
    
    if (strikerView.frame.origin.y > 400)
    {
        CGRect viewFrame = CGRectMake(0, STRIKER_VIEW_ORIGIN_Y, strikerView.frame.size.width, strikerView.frame.size.height);
        [UIView animateWithDuration:0.2
                         animations:^{strikerView.frame = viewFrame;}
                         completion:nil];
    }
}

- (IBAction)finishMatch:(id)sender
{
    [self performSegueWithIdentifier:@"MatchSheetSegue" sender:self];
}

- (void)addGoalForPlayer:(Player*)strikerPlayer andAssist:(Player*)assistPlayer
{
    for (Player *player in bestPlayers)
    {
        if ([player isEqualToPlayer:strikerPlayer])
            [player setPlayerGoals:[player playerGoals] + 2];
        if (assistPlayer && [player isEqualToPlayer:assistPlayer])
            [player setPlayerAssists:[player playerAssists] + 1];
    }
    
    [bestPlayers sortUsingComparator:^NSComparisonResult (id obj1, id obj2){
        Player *firstPlayer = (Player*) obj1;
        Player *secondPlayer = (Player*) obj2;
        
        int firstScore = [firstPlayer playerGoals] + [firstPlayer playerAssists];
        int secondScore = [secondPlayer playerGoals] + [secondPlayer playerAssists];
        
        if (firstScore > secondScore)
            return (NSComparisonResult)NSOrderedSame;
        else
            if (firstScore < secondScore)
                return (NSComparisonResult)NSOrderedDescending;
            else
                if (firstScore == secondScore)
                {
                    if ([firstPlayer playerGoals] > [secondPlayer playerGoals])
                        return (NSComparisonResult)NSOrderedSame;
                    
                    if ([firstPlayer playerGoals] < [secondPlayer playerGoals])
                        return (NSComparisonResult)NSOrderedDescending;
                }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSLog(@"%@ with %d points", [[bestPlayers objectAtIndex:0] playerName], [[bestPlayers objectAtIndex:0] playerGoals] + [[bestPlayers objectAtIndex:0] playerAssists]);
    NSLog(@"%@ with %d points", [[bestPlayers objectAtIndex:1] playerName], [[bestPlayers objectAtIndex:1] playerGoals] + [[bestPlayers objectAtIndex:1] playerAssists]);
    NSLog(@"%@ with %d points", [[bestPlayers objectAtIndex:2] playerName], [[bestPlayers objectAtIndex:2] playerGoals] + [[bestPlayers objectAtIndex:2] playerAssists]);
}




#pragma mark - Animation

- (void)animatePickerView
{
    CGRect pickerFrame = CGRectMake(strikerView.frame.size.width , picker.frame.origin.y, picker.frame.size.width, picker.frame.size.height);
    [UIView animateWithDuration:0.2
                     animations:^{[picker setFrame:pickerFrame];}
                     completion:^(BOOL finished){
                         CGRect newFrame = CGRectMake(- picker.frame.size.width , picker.frame.origin.y, picker.frame.size.width, picker.frame.size.height);
                         CGRect basicFrame = CGRectMake(0 , picker.frame.origin.y, picker.frame.size.width, picker.frame.size.height);
                         [picker reloadAllComponents];
                         [picker setFrame:newFrame];
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                              [picker setFrame:basicFrame];
                                          }];
                     }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] class] == [ModifyTeamViewController class])
    {
        ModifyTeamViewController *MTViewController = [segue destinationViewController];
        
        [MTViewController setFirstTeamArray:teamOnePlayers];
        [MTViewController setSecondTeamArray:teamTwoPlayers];
        [MTViewController setAllPlayers:remainingPlayers];
        [MTViewController setDelegate:self];
    }
    else
    {
        MatchSheetViewController *viewController = [segue destinationViewController];
        Match *finishedMatch = [[Match alloc] initWithTeamOneName:[firstTeamName text]
                                                      teamTwoName:[secondTeamName text]
                                                      teamOneList:teamOnePlayers
                                                      teamTwoList:teamTwoPlayers
                                                     teamOneScore:[[firstTeamScore text] intValue]
                                                     teamTwoScore:[[secondTeamScore text] intValue]
                                                         goalList:goals];
        [[finishedMatch teamOneGoals] addObjectsFromArray:[finishedMatch retrieveGoalsWithTeam:1]];
        [[finishedMatch teamTwoGoals] addObjectsFromArray:[finishedMatch retrieveGoalsWithTeam:2]];
        [finishedMatch setPlayersMatches];
        
        if ([[bestPlayers objectAtIndex:2] playerGoals] + [[bestPlayers objectAtIndex:2] playerAssists] > 0)
            [[finishedMatch bestPlayers] addObject:[bestPlayers objectAtIndex:2]];
        if ([[bestPlayers objectAtIndex:1] playerGoals] + [[bestPlayers objectAtIndex:1] playerAssists] > 0)
            [[finishedMatch bestPlayers] addObject:[bestPlayers objectAtIndex:1]];
        if ([[bestPlayers objectAtIndex:0] playerGoals] + [[bestPlayers objectAtIndex:0] playerAssists] > 0)
            [[finishedMatch bestPlayers] addObject:[bestPlayers objectAtIndex:0]];
        
        [[[MySingleton sharedMySingleton] matchList] insertObject:finishedMatch atIndex:0];
        [viewController setFinishedMatch:finishedMatch];
        [finishedMatch release];
    }
}

- (void)modifyTeamWithIndexPath:(NSIndexPath *)indexPath andGesture:(UIGestureRecognizer *)gestureRecognizer
{
    UISwipeGestureRecognizer *swipeGesture;
    
    switch (indexPath.section) {
        case 0:
            if ([gestureRecognizer class] == [UISwipeGestureRecognizer class])
                [teamTwoPlayers addObject:[teamOnePlayers objectAtIndex:indexPath.row]];
            
            if ([gestureRecognizer class] == [UITapGestureRecognizer class])
                [remainingPlayers addObject:[teamOnePlayers objectAtIndex:indexPath.row]];
            
            [teamOnePlayers removeObjectAtIndex:indexPath.row];
            break;
            
        case 1:
            if ([gestureRecognizer class] == [UISwipeGestureRecognizer class])
                [teamOnePlayers addObject:[teamTwoPlayers objectAtIndex:indexPath.row]];
            
            if ([gestureRecognizer class] == [UITapGestureRecognizer class])
                [remainingPlayers addObject:[teamTwoPlayers objectAtIndex:indexPath.row]];
            
            [teamTwoPlayers removeObjectAtIndex:indexPath.row];
            break;
            
        case 2:
            swipeGesture = (UISwipeGestureRecognizer*)gestureRecognizer;
            if ([swipeGesture direction] == UISwipeGestureRecognizerDirectionLeft)
                [teamOnePlayers addObject:[remainingPlayers objectAtIndex:indexPath.row]];
            
            if ([swipeGesture direction] == UISwipeGestureRecognizerDirectionRight)
                [teamTwoPlayers addObject:[remainingPlayers objectAtIndex:indexPath.row]];
            
            [remainingPlayers removeObjectAtIndex:indexPath.row];
            break;
            
        default:
            break;
    }
}

@end
