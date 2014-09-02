//
//  DoubanDetailViewController.m
//  NextIdentity
//
//  Created by Leon Fu on 9/1/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "DoubanDetailViewController.h"

@interface DoubanDetailViewController ()

@end

@implementation DoubanDetailViewController

@synthesize model;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.model.delegate = self;
    [self.model updateLogonToken:self.token];
    //[self.model buildUserInfo];
    //[self.model buildUserFavoriteBooks];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) modelComplete:(BOOL)result Type:(NETTYPE)type
{
    [data addObject:self.model.accessToken];
    [self.tableView reloadData];
    [indicator stopAnimating];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
