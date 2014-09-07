//
//  ChangePwdTableViewController.m
//  NextIdentity
//
//  Created by Leon on 14-9-6.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "ChangePwdTableViewController.h"
#import "TextFieldTableViewCell.h"

@interface ChangePwdTableViewController ()

@end

@implementation ChangePwdTableViewController

@synthesize isForgotPwd;

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更新" style:UIBarButtonItemStylePlain target:self action:@selector(Update)];
    self.navigationItem.title = @"修改密码";
    settingNameList = @[@"旧密码", @"新密码", @"重复新密码"];
    settingValueList = [@[@"", @"", @""] mutableCopy];
    [self enableBarButtonAction:NO];
}
- (void) Update
{
    NSLog (@"%@\n%@", settingValueList[0], settingValueList[1]);
    [self dismissViewControllerAnimated:YES completion:NO];
}

- (void) Cancel
{
    [self dismissViewControllerAnimated:YES completion:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return settingNameList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TEXTFIELD_CELL" forIndexPath:indexPath];
    
    cell.textLabel.text = settingNameList[indexPath.row];
    cell.textField.secureTextEntry = YES;
    cell.textField.tag = indexPath.row;
    cell.textField.delegate = self;
    if(indexPath.row == 0)
    {
        if(isForgotPwd)
        {
            settingValueList[0] = @"RESERVED";
            cell.hidden = YES;
        }
        else
            [cell.textField becomeFirstResponder];
    }
    return cell;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self enableBarButtonAction:YES];
    NSMutableString* str = [textField.text mutableCopy];
    [str replaceCharactersInRange:range withString:string];
    settingValueList[textField.tag] = str;
    if([settingValueList[1] isEqualToString: settingValueList[2]] == NO || ((NSString*)settingValueList[1]).length == 0 || ((NSString*)settingValueList[0]).length == 0)
    {
        [self enableBarButtonAction:NO];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self enableBarButtonAction:NO];
    settingValueList[textField.tag] = @"";
    return YES;
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
