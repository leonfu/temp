//
//  HomeViewController.h
//  NextIdentity
//
//  Created by Leon on 14-9-4.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VendorCollectionViewController.h"
#import "VendorLogonViewController.h"

@interface HomeViewController : UIViewController<VendorLogonDelegate>
{
    VendorCollectionViewController* vendorViewController;
}
- (void) initHomeScreen;
@property (strong, nonatomic) IBOutlet UILabel* welcomeLabel;
@property (strong, nonatomic) IBOutlet UILabel* introLabel;
@property (strong, nonatomic) IBOutlet UILabel* firstLabel;
@property (strong, nonatomic) IBOutlet UILabel* scoreLabel;
@property (strong, nonatomic) IBOutlet UIView* touchView;

@end
