//
//  KeyValueTableViewController.h
//  NextIdentity
//
//  Created by Leon on 14-9-6.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyValueTableViewController : UITableViewController
{
@protected
    NSArray* settingNameList;
    NSMutableArray* settingValueList;
}
- (void) Cancel;
- (void) enableBarButtonAction: (BOOL)enabled;
@end
