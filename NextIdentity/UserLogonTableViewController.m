//
//  UserLogonTableViewController.m
//  NextIdentity
//
//  Created by Leon on 14-9-6.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "UserLogonTableViewController.h"
#import "PNColor.h"
#import "NSUserModel.h"
#import "NavigationController.h"
#import "RegisterViewController.h"

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
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(test:) userInfo:nil repeats:NO];
}

- (void) test:(NSTimer*)timer
{
    isLogonProcessing = NO;
    [timer invalidate];
    [NSUserModel sharedInstance].isLogon = YES;
    NSDictionary* dict = @{@"phone":valueList[0], @"email": @"test@email.com", @"sex":@"0", @"nick":@"test"};
    [[NSUserModel sharedInstance] fillProfile:dict];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) NewUser
{
    isForgotPwd = NO;
    [self performSegueWithIdentifier:@"presentNewUserIdentifier" sender:self];
}

- (void) forgotPwd
{
    if (isLogonProcessing)  //cancel log on
    {
        [indicator stopAnimating];
        userField.enabled = YES;
        pwdField.enabled = YES;
        logonBtn.hidden = NO;
        [forgotBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        isLogonProcessing = NO;
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
