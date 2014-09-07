//
//  RegisterViewController.h
//  NextIdentity
//
//  Created by Leon on 14-9-7.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "KeyValueTableViewController.h"

@interface RegisterViewController : KeyValueTableViewController<UITextFieldDelegate>
{
    UIButton* tokenBtn;
    NSInteger count;
    UITextField* phoneField;
    UITextField* codeField;
}
@property (assign, nonatomic) NSString* phoneNumber;
@property (assign, nonatomic) BOOL isNewUser;
- (void) countDown: (NSTimer*) timer;
- (void) Register;
- (void) getToken;
@end
