//
//  ChangeProfileTableViewController.h
//  NextIdentity
//
//  Created by Leon on 14-9-6.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyValueTableViewController.h"

@interface ChangeProfileTableViewController : KeyValueTableViewController<UIActionSheetDelegate, UITextFieldDelegate>
{
    UITextField* sexField;
}
- (void) Update;

@end
