//
//  TeamViewController.m
//  ScoreBoard
//
//  Created by Julien Chene on 9/1/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "TeamViewController.h"
#import "MySingleton.h"

@implementation TeamViewController

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
    
    [teamOneField setDelegate:self];
    [teamTwoField setDelegate:self];
    
    [teamOneField setText:@"Équipe 1"];
    [teamTwoField setText:@"Équipe 2"];
    
    [emptyWarningLabel setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button Handler

- (IBAction)teamEntryDone:(id)sender
{
    if ([[teamOneField text] isEqualToString:@""] || [[teamTwoField text] isEqualToString:@""])
        [emptyWarningLabel setHidden:NO];
    else
    {
        [emptyWarningLabel setHidden:YES];
        
        if ([teamOneField isEditing])
            [self textFieldShouldReturn:teamOneField];
        if ([teamTwoField isEditing])
            [self textFieldShouldReturn:teamTwoField];
        
        [[MySingleton sharedMySingleton] setFirstTeamName:[teamOneField text]];
        [[MySingleton sharedMySingleton] setSecondTeamName:[teamTwoField text]];
        
        [self performSegueWithIdentifier:@"teamFilled" sender:sender];
    }
}

- (IBAction)goBackHome:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark TextField handling

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // do whatever you have to do
    CGRect frame;
    frame = self.view.frame;
    frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{self.view.frame = frame;
                                  [textField resignFirstResponder];
                                }
                     completion:nil];

    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.view.frame.origin.y == 0)
    {
        CGRect frame;
        frame = self.view.frame;
        frame = CGRectMake(0, -50, frame.size.width, frame.size.height);
        [UIView animateWithDuration:0.2
                              delay:0
                            options:UIViewAnimationOptionTransitionNone
                         animations:^{self.view.frame = frame;}
                         completion:nil];
        self.view.frame = frame;
    }
    
    return YES;
}

@end
