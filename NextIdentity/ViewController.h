//
//  ViewController.h
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoubanLogonViewController.h"

@interface ViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, LogonDelegate>

@property(strong, nonatomic) NSArray* IdentityList;

- (void) showDetailInfo: (NSInteger) type;

@end
