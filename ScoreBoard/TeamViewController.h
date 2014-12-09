//
//  TeamViewController.h
//  ScoreBoard
//
//  Created by Julien Chene on 9/1/13.
//  Copyright (c) 2013 Julien Chene. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamViewController : UIViewController   <UITextFieldDelegate,
                                                    UINavigationBarDelegate>
{
    IBOutlet UITextField        *teamOneField;
    IBOutlet UITextField        *teamTwoField;
    IBOutlet UILabel            *emptyWarningLabel;
}

- (IBAction)teamEntryDone:(id)sender;
- (IBAction)goBackHome:(id)sender;

@end
