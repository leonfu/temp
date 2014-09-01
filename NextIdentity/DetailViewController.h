//
//  DetailViewController.h
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DetailViewController : UITableViewController<UITableViewDataSource, UITabBarControllerDelegate>
{
    BOOL m_isAuthed;
}

@property NETTYPE netType;

@end
