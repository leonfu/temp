//
//  NewUserTableViewController.h
//  NextIdentity
//
//  Created by Leon on 14-9-7.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyValueTableViewController.h"

@interface NewUserTableViewController : KeyValueTableViewController<UITextFieldDelegate, UIActionSheetDelegate>
{
    UITextField* sexField;
}

@property (strong, nonatomic) NSString* phoneNumber;
- (void) Register;
@end
