//
//  SettingTableViewController.m
//  NextIdentity
//
//  Created by Leon on 14-9-5.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "SettingTableViewController.h"
#import "ChangePwdTableViewController.h"
#import "NavigationController.h"
#import "ChangeProfileTableViewController.h"
#import "NSUserModel.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

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
    self.navigationItem.leftBarButtonItem = nil;
    settingNameList = @[@"手机号",  @"昵称", @"性别", @"邮箱"];
    NSUserModel *userModel = [NSUserModel sharedInstance];
    settingValueList = [@[userModel.phone, userModel.nick, userModel.sex, userModel.email] mutableCopy];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(doAction)];
}

- (void) doAction
{
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"修改密码" otherButtonTitles:@"修改资料", @"登出", nil];
    [sheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    if(buttonIndex == 0) //change password
    {
        ChangePwdTableViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"ChangePwdIdentifier"];
        controller.isForgotPwd = NO;
        NavigationController* navController = [[NavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navController animated:YES completion:nil];
    }
    else if(buttonIndex == 1) //change profile
    {
        ChangeProfileTableViewController* controller = [storyboard instantiateViewControllerWithIdentifier:@"ChangeProfileIdentifier"];
        NavigationController* navController = [[NavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navController animated:NO completion:nil];
    }
    else if(buttonIndex == 2) //log out
    {
        [NSUserModel sharedInstance].isLogon = NO;
        [Utility removeCurrentUser];
        self.tabBarController.selectedIndex = 0;
        
    }
}

- (void) viewDidAppear:(BOOL)animated
{
    NSUserModel *userModel = [NSUserModel sharedInstance];
    settingValueList = [@[userModel.phone, userModel.nick, userModel.sex, userModel.email] mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return settingNameList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SETTING_CELL_LIST";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = settingNameList[indexPath.row];;
    cell.detailTextLabel.text = settingValueList[indexPath.row];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
