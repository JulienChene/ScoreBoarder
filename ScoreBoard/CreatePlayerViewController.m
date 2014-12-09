//
//  CreatePlayerViewController.m
//  ScoreBoard
//
//  Created by Julien Chene on 9/30/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import "CreatePlayerViewController.h"
#import "MySingleton.h"
#import "PlayersViewController.h"

@interface CreatePlayerViewController ()

@end

@implementation CreatePlayerViewController

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

    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Retour"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:nil
                                                                             action:nil] autorelease];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CreatePlayerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UITextField *tf = nil;
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"Nom";
        tf = nameField = [self makeTextFieldWithPlaceholder:@"Marc Dupont"];
        [cell addSubview:nameField];
    }
    
    if (indexPath.row == 1)
    {
        cell.textLabel.text = @"Numéro";
        tf = numberField = [self makeTextFieldWithPlaceholder:@"18"];
        [cell addSubview:numberField];
    }
    
    tf.frame = CGRectMake(90, 8, 170, 30);
    [tf setDelegate:self];
    
    return cell;
}

#pragma mark - Cell conditioning

-(UITextField*) makeTextFieldWithPlaceholder: (NSString*)placeholder  {
    UITextField *tf = [[[UITextField alloc] init] autorelease];
    tf.placeholder = placeholder ;
    tf.autocorrectionType = UITextAutocorrectionTypeNo ;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.adjustsFontSizeToFitWidth = YES;
    tf.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    return tf ;
}

#pragma mark - IBActions handler

//static bool TextIsValidValue( NSString* newText, double &value )

- (IBAction)createPlayer:(id)sender
{
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[numberField text]];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    
    if ([[nameField text] isEqualToString:@""] || [[numberField text] isEqualToString:@""])
    {
        [errorLabel setText:@"Tous les champs doivent être remplis"];
        [errorLabel setHidden:false];
    }
    else
        if (!valid)
        {
            [numberField setTextColor:[UIColor redColor]];
            [errorLabel setText:@"Le numéro doit être numérique"];
            [errorLabel setHidden:false];
        }
        else
            if ([numberField text].integerValue > 99)
            {
                [numberField setTextColor:[UIColor redColor]];
                [errorLabel setText:@"Le numéro doit être inférieur à 99"];
                [errorLabel setHidden:false];
            }
            else
                if ([[[MySingleton sharedMySingleton] playerNumberIndex] containsIndex:[[numberField text] intValue]])
                {
                    [numberField setTextColor:[UIColor redColor]];
                    [errorLabel setText:@"Ce numéro est déjà utilisé"];
                    [errorLabel setHidden:false];
                }
                else
                {
                    [self.delegate addPlayerToListWithName:[nameField text] andNumber:[numberField text].integerValue];
                    [[[MySingleton sharedMySingleton] playerNumberIndex] addIndex:[[numberField text] intValue]];
                    [self.navigationController popViewControllerAnimated:YES];
                }
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [numberField setTextColor:[UIColor blackColor]];
    if (textField == nameField)
        [textField setKeyboardType:UIKeyboardTypeDefault];
    else
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
    
    return YES;
}

@end
