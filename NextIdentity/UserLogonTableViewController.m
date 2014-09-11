//
//  UserLogonTableViewController.m
//  NextIdentity
//
//  Created by Leon on 14-9-6.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "UserLogonTableViewController.h"
#import "AppDelegate.h"
#import "PNColor.h"
#import "NSUserModel.h"
#import "NavigationController.h"
#import "RegisterViewController.h"

#define URL_USER_LOGON "users/login"
#define BODY_USER_LOGON "{\"username\":%@, \"password\":%@}"

@interface UserLogonTableViewController ()

@end

@implementation UserLogonTableViewController

@synthesize logonBtn, userField, pwdField, forgotBtn, indicator;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.backgroundColor = PNFreshGreen;
    self.logonBtn.hidden = YES;
    self.forgotBtn.hidden = YES;
    isForgotPwd = NO;
    isLogonProcessing = NO;
    valueList = [@[@"", @""] mutableCopy];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoLogon:) name:@"userLogon" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *UserCellIdentifier = @"LOGON_USERCELL";
    static NSString *PwdCellIdentifier = @"LOGON_PWDCELL";
    UITableViewCell *cell;
    if(indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:UserCellIdentifier forIndexPath:indexPath];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:PwdCellIdentifier forIndexPath:indexPath];
    }
    return cell;
}*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == userField) //phone number
    {
        [pwdField becomeFirstResponder];
        return YES;
    }
    else
    {
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        [self UserLogon: valueList[0] Password:valueList[1]];
    }
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSMutableString* str = [textField.text mutableCopy];
    [str replaceCharactersInRange:range withString:string];
    if (textField == userField) //phone number
    {
        valueList[0] = str;
        self.forgotBtn.hidden = YES;
        if(((NSString*)valueList[0]).length > 0)
           self.forgotBtn.hidden = NO;
    }
    if (textField == pwdField)
        valueList[1] = str;
    
    self.logonBtn.hidden = YES;
    if (((NSString*)valueList[0]).length > 0 && ((NSString*)valueList[1]).length > 0)
    {
        self.logonBtn.hidden = NO;
    }

    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.logonBtn.hidden = YES;
    if(textField == userField) //phone number
        self.forgotBtn.hidden = YES;
    if(textField == userField)
        valueList[0] = @"";
    else
        valueList[1] = @"";
    return YES;
}

- (void) autoLogon: (NSNotification*)notification
{
    valueList[0] = notification.userInfo[@"userInfo"][0];
    valueList[1] = notification.userInfo[@"userInfo"][1];
    userField.text = valueList[0];
    userField.text = valueList[1];
    [self UserLogon: valueList[0] Password: valueList[1]];
}

- (void) UserLogon: (NSString*) user Password: (NSString*) password
{
    NSLog(@"%@\n%@", user, password);
    userField.enabled = NO;
    pwdField.enabled = NO;
    logonBtn.hidden = YES;
    [forgotBtn setTitle:@"取消登录" forState:UIControlStateNormal];
    [indicator startAnimating];
    isLogonProcessing = YES;
    
    URLRequestHandler* handler = [[URLRequestHandler alloc] initWithURLStringPOST:@URL_SERVER_PATH @URL_USER_LOGON Body:[NSString stringWithFormat:@BODY_USER_LOGON, valueList[0], valueList[1]] Topic:TOPIC_USER_LOGON];
    [handler startWithCompletion:^(BOOL isValid, NSString *result, NSInteger topic)
    {
        if (isValid == YES && isLogonProcessing == YES)
        {
            NSDictionary* dict = [Utility getObjectFromJSON:result];
            [NSUserModel sharedInstance].isLogon = YES;
            [[NSUserModel sharedInstance] fillUserProfile:dict];
            [self dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        //error occurs
        if (isValid == NO && isLogonProcessing == YES)
        {
            [Utility showErrorMessage:result];
            [self cancelLogon];
            /////////////////////////
            //test code
            [NSUserModel sharedInstance].isLogon = YES;
            NSDictionary* dict = @{@"id":@"aaaa", @"mobile":@"1234", @"username":@"name"};
            [[NSUserModel sharedInstance] fillUserProfile:dict];
            [self dismissViewControllerAnimated:YES completion:nil];
            /////////////////////////
        }
    }];
    
}

- (void) NewUser
{
    [[NSAssetList sharedInstance] updateAsset:DOUBAN Total:@100 Delta:@10 Percentage:@70 Rank:@10];
    isForgotPwd = NO;
    [self performSegueWithIdentifier:@"presentNewUserIdentifier" sender:self];
}

- (void) cancelLogon
{
    [indicator stopAnimating];
    userField.enabled = YES;
    pwdField.enabled = YES;
    logonBtn.hidden = NO;
    [forgotBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    isLogonProcessing = NO;
}

- (void) forgotPwd
{
    if (isLogonProcessing)  //cancel log on
    {
        [self cancelLogon];
    }
    else //forgot password
    {
        isForgotPwd = YES;
        pwdField.text = @"";
        valueList[1] = @"";
        logonBtn.hidden = YES;
        [self performSegueWithIdentifier:@"presentNewUserIdentifier" sender:self];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
     [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"presentNewUserIdentifier"])
    {
        NavigationController* controller = [segue destinationViewController];
        RegisterViewController* regController = (RegisterViewController*)controller.topViewController;
        regController.isNewUser = !isForgotPwd;
        regController.phoneNumber = valueList[0];
    }
}
@end
