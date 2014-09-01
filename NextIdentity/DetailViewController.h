//
//  DetailViewController.h
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NSIdentityModel.h"

@interface DetailViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
{
@protected
    BOOL m_isAuthed;
    NSInteger rowNumber;
    NSMutableArray* data;
    UIActivityIndicatorView* indicator;
}

@property NETTYPE netType;
@property NSDictionary* token;

@end
