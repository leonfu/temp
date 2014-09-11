//
//  NewUserTableViewController.m
//  NextIdentity
//
//  Created by Leon on 14-9-7.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "NewUserTableViewController.h"
#import "PNColor.h"
#import "TextFieldTableViewCell.h"
#import "AppDelegate.h"

#define URL_USER_REG "users/"
#define BODY_USER_REG "{\"mobile\":\"%@\", \"password\":\"%@\", \"username\":\"%@\", \"sex\":\"%@\", \"email\":\"%@\"}"

@interface NewUserTableViewController ()

@end

@implementation NewUserTableViewController

@synthesize phoneNumber;

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(Register)];
    [self enableBarButtonAction:NO];
    settingNameList = @[@"手机号", @"密码", @"重复密码", @"昵称", @"性别", @"邮箱"];
    settingValueList = [@[phoneNumber, @"", @"", @"", @"", @"", @""] mutableCopy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) Register
{
    NSLog(@"%@\n%@\n%@\n%@\n%@", settingValueList[0], settingValueList[1], settingValueList[3], settingValueList[4], settingValueList[5]);
    URLRequestHandler* handler = [[URLRequestHandler alloc] initWithURLStringPOST:@URL_SERVER_PATH @URL_USER_REG Body:[NSString stringWithFormat:@BODY_USER_REG, settingValueList[0], settingValueList[1], settingValueList[3], settingValueList[4], settingValueList[5]] Topic:TOPIC_USER_REG];
    [handler startWithCompletion:^(BOOL isValid, NSString *result, NSInteger topic)
    {
        if(isValid)
        {
             [self dismissViewControllerAnimated:YES completion:
              ^{
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogon"
                                                                      object:self
                                                                    userInfo:[NSDictionary dictionaryWithObject:settingValueList forKey:@"userInfo"]];
              }];
        }
        else
        {
            [Utility showErrorMessage:result];
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TEXTFIELD_CELL" forIndexPath:indexPath];
    
    cell.textLabel.text = settingNameList[indexPath.row];
    cell.textField.delegate = self;
    cell.textField.tag = indexPath.row;
    switch (indexPath.row)
    {
        case 0:
            cell.textField.text = phoneNumber;
            cell.textField.userInteractionEnabled = NO;
            break;
        case 1:
            cell.textField.placeholder = @"必填";
            cell.textField.secureTextEntry = YES;
            [cell.textField becomeFirstResponder];
            break;
        case 2:
            cell.textField.placeholder = @"必填";
            cell.textField.secureTextEntry = YES;
            break;
        case 4: //sex
            cell.textField.enabled = NO;
            break;
        case 5:
            cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
            break;
    }
    return cell;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self enableBarButtonAction:YES];
    NSMutableString* str = [textField.text mutableCopy];
    [str replaceCharactersInRange:range withString:string];
    settingValueList[textField.tag] = str;
    if([settingValueList[1] isEqualToString: settingValueList[2]] == NO || ((NSString*)settingValueList[1]).length == 0)
    {
        [self enableBarButtonAction:NO];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if(textField.tag == 1 || textField.tag == 2) //password required
        [self enableBarButtonAction:NO];
    settingValueList[textField.tag] = @"";
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location= [touch locationInView:self.view];
    TextFieldTableViewCell* cell = (TextFieldTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
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
    settingValueList[4] = [NSString stringWithFormat:@"%d", buttonIndex];
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
