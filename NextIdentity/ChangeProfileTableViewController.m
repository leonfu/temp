//
//  ChangeProfileTableViewController.m
//  NextIdentity
//
//  Created by Leon on 14-9-6.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "ChangeProfileTableViewController.h"
#import "TextFieldTableViewCell.h"
#import "NSUserModel.h"

@interface ChangeProfileTableViewController ()

@end

@implementation ChangeProfileTableViewController

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更新" style:UIBarButtonItemStylePlain target:self action:@selector(Update)];
    self.navigationItem.title = @"修改资料";
    settingNameList = @[@"手机号",  @"昵称", @"性别", @"邮箱"];
    NSUserModel *userModel = [NSUserModel sharedInstance];
    settingValueList = [@[userModel.phone, userModel.nick, userModel.sex, userModel.email] mutableCopy];
}

- (void) Update
{
    NSUserModel *userModel = [NSUserModel sharedInstance];
    [userModel fillUserBrief:[NSDictionary dictionaryWithObjects:settingValueList forKeys:@[@"phone", @"nick", @"sex", @"email"]]];
    [self dismissViewControllerAnimated:NO completion:NO];
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
    TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TEXTFIELD_CELL" forIndexPath:indexPath];
    
    cell.textLabel.text = settingNameList[indexPath.row];
    cell.textField.text = settingValueList[indexPath.row];
    cell.textField.tag = indexPath.row;
    cell.textField.delegate = self;
    if(indexPath.row == 0)
    {
        cell.textField.enabled = NO;
    }
    if(indexPath.row == 1)
    {
        [cell.textField becomeFirstResponder];
    }
    if(indexPath.row == 2)
    {
        cell.textField.enabled = NO;
    }
    return cell;

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString* str = [textField.text mutableCopy];
    [str replaceCharactersInRange:range withString:string];
    settingValueList[textField.tag] = str;
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location= [touch locationInView:self.view];
    TextFieldTableViewCell* cell = (TextFieldTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    sexField = cell.textField;
    if(CGRectContainsPoint(cell.frame, location))
    {
        UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
        [sheet showInView:self.view];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) //male
    {
        sexField.text = @"男";
    }
    else if(buttonIndex == 1) //female
    {
        sexField.text = @"女";
    }
    settingValueList[2] = [NSString stringWithFormat:@"%d", buttonIndex];
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
