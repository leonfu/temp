//
//  SettingTableViewController.h
//  NextIdentity
//
//  Created by Leon on 14-9-5.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyValueTableViewController.h"

@interface SettingTableViewController : KeyValueTableViewController<UIActionSheetDelegate>
{
}

- (void) doAction;

@end