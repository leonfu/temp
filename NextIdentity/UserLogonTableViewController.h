//
//  UserLogonTableViewController.h
//  NextIdentity
//
//  Created by Leon on 14-9-6.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchTableView.h"

@interface UserLogonTableViewController : UITableViewController<UITextFieldDelegate>
{
    NSMutableArray* valueList;
    BOOL isLogonProcessing;
    BOOL isForgotPwd;
}
@property (strong, nonatomic) IBOutlet UIButton* logonBtn;
@property (strong, nonatomic) IBOutlet UIButton* forgotBtn;
@property (strong, nonatomic) IBOutlet UITextField* userField;
@property (strong, nonatomic) IBOutlet UITextField* pwdField;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView* indicator;
- (IBAction)UserLogon: (NSString*) user Password: (NSString*) password;
- (IBAction)NewUser;
- (IBAction)forgotPwd;
- (void) cancelLogon;
- (void) autoLogon: (NSNotification*)notification;

@end
