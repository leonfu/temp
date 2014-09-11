//
//  RegisterViewController.m
//  NextIdentity
//
//  Created by Leon on 14-9-7.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "RegisterViewController.h"
#import "PNColor.h"
#import "TextFieldTableViewCell.h"
#import "NewUserTableViewController.h"
#import "ChangePwdTableViewController.h"
#import "AppDelegate.h"

#define URL_MOBILE_VERIFY "mobile/verify/"
#define URL_MOBILE_CONFIRM "mobile/confirm/"
#define BODY_MOBILE_VERIFY "{\"mobile\":\"%@\"}"
#define BODY_MOBILE_CONFIRM "{\"mobile\":\"%@\", \"key\":\"%@\"}"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize isNewUser, phoneNumber;

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
    self.tableView.backgroundColor = PNFreshGreen;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(Register)];
    [self enableBarButtonAction:NO];
    settingNameList = @[@"手机号", @"验证码"];
    if(phoneNumber == nil)
        phoneNumber = @"";
    settingValueList = [@[phoneNumber, @""] mutableCopy];
    if(isNewUser == NO)
        self.navigationItem.title = @"确认身份";
}

- (void) Register
{
    URLRequestHandler* handler = [[URLRequestHandler alloc] initWithURLStringPOST:@URL_SERVER_PATH @URL_MOBILE_CONFIRM Body:[NSString stringWithFormat:@BODY_MOBILE_CONFIRM, settingValueList[0], settingValueList[1]] Topic:TOPIC_MOBILE_CONFIRM];
    [handler startWithCompletion:^(BOOL isValid, NSString *result, NSInteger topic)
     {
        if(isValid)
        {
            if(isNewUser)
                [self performSegueWithIdentifier:@"presentNewUserIdentifier2" sender:self];
            else
                [self performSegueWithIdentifier:@"changePwdIdentifier" sender:self];
        }
        else
        {
            [Utility showErrorMessage:result];
            [self stopTimer];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TEXTFIELD_CELL" forIndexPath:indexPath];
    
    cell.textLabel.text = settingNameList[indexPath.row];
    cell.textField.delegate = self;
    cell.textField.placeholder = @"必填";
    cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    cell.textField.tag = indexPath.row;
    cell.textField.text = settingValueList[indexPath.row];
    CGRect rect = cell.textField.frame;
    switch (indexPath.row)
    {
        case 0:
            [cell.textField becomeFirstResponder];
            phoneField = cell.textField;
            break;
        case 1:
            cell.textField.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width/2, rect.size.height);
            tokenBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [tokenBtn setTitle:@"获取" forState:UIControlStateNormal];
            tokenBtn.frame = CGRectMake(0, 0, 100,35);
            tokenBtn.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
            [tokenBtn.layer setCornerRadius:10.0f];
            [tokenBtn addTarget:self action:@selector(getToken) forControlEvents:UIControlEventTouchUpInside];
            if(((NSString*)settingValueList[0]).length == 0)
                tokenBtn.hidden = YES;
            cell.accessoryView = tokenBtn;
            codeField = cell.textField;
            break;
    }
    return cell;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString* str = [textField.text mutableCopy];
    [str replaceCharactersInRange:range withString:string];
    settingValueList[textField.tag] = str;
    if (textField.tag == 0) //phone number
    {
        tokenBtn.hidden = YES;
        if(((NSString*)settingValueList[0]).length > 0)
            tokenBtn.hidden = NO;
    }

    [self enableBarButtonAction:YES];
    if (((NSString*)settingValueList[0]).length == 0 || ((NSString*)settingValueList[1]).length == 0)
    {
       [self enableBarButtonAction:NO];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self enableBarButtonAction:NO];
    if(textField.tag == 0) //phone number
        tokenBtn.hidden = YES;
    settingValueList[textField.tag] = @"";
    return YES;
}

- (void) getToken
{
    URLRequestHandler* handler = [[URLRequestHandler alloc] initWithURLStringPOST:@URL_SERVER_PATH @URL_MOBILE_VERIFY Body:[NSString stringWithFormat:@BODY_MOBILE_VERIFY, settingValueList[0]] Topic:TOPIC_MOBILE_VERIFY];
    [handler startWithCompletion:^(BOOL isValid, NSString *result, NSInteger topic) {
        if(!isValid)
        {
            [Utility showErrorMessage:result];
            [self stopTimer];
            
        }
    }];
    count = 60;
    tokenBtn.enabled = NO;
    [tokenBtn setTitle:[NSString stringWithFormat:@"%ds", count] forState:UIControlStateDisabled];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
}

- (void) stopTimer
{
    if(timer.isValid)
        [timer invalidate];
    tokenBtn.enabled = YES;
    [tokenBtn setTitle:@"获取" forState:UIControlStateNormal];
    count = 60;
}

- (void) countDown: (NSTimer*) timer
{
    count --;
    [tokenBtn setTitle:[NSString stringWithFormat:@"%ds", count] forState:UIControlStateDisabled];
    if(count == 0)
    {
        [self stopTimer];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if(isNewUser)
    {
        NewUserTableViewController* controller = [segue destinationViewController];
        controller.phoneNumber = phoneField.text;
    }
    else
    {
        ChangePwdTableViewController* controller = [segue destinationViewController];
        controller.tableView.backgroundColor = PNFreshGreen;
        controller.isForgotPwd = YES;
    }
}

@end
