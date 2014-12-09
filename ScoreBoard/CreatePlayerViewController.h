//
//  CreatePlayerViewController.h
//  ScoreBoard
//
//  Created by Julien Chene on 9/30/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreatePlayerViewControllerDelegate <NSObject>

- (void)addPlayerToListWithName:(NSString*)playerName andNumber:(NSInteger)playerNumber;

@end

@interface CreatePlayerViewController : UITableViewController <UITextFieldDelegate>
{
    UITextField         *nameField;
    UITextField         *numberField;
    UILabel IBOutlet    *errorLabel;
}

@property (nonatomic, assign) id<CreatePlayerViewControllerDelegate> delegate;

@end
