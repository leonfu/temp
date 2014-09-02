//
//  ViewController.m
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "DoubanLogonViewController.h"
#import "SinaWeiboLogonController.h"
#import "TaobaoLogonViewController.h"
#import "TencentLogonController.h"
#import "NSIdentityModel.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for (int i = DOUBAN; i < TENCENT+1; i++)
    {
        NSIdentityModel* model = [[NSIdentityModel alloc]init];
        [array addObject:model];
    }
    self.IdentityList = array;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.IdentityList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CELL_LIST";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    switch (indexPath.row)
    {
        case DOUBAN:
            cell.textLabel.text = @"我的豆瓣身份";
            cell.imageView.image = [UIImage imageNamed:@"douban.png"];
            break;
        case SINA_WEIBO:
            cell.textLabel.text = @"我的微博身份";
            cell.imageView.image = [UIImage imageNamed:@"sina.png"];
            break;
        case TAOBAO:
            cell.textLabel.text = @"我的淘宝身份";
            cell.imageView.image = [UIImage imageNamed:@"taobao.png"];
            break;
        case TENCENT:
            cell.textLabel.text = @"我的QQ身份";
            cell.imageView.image = [UIImage imageNamed:@"qq.png"];
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIdentityModel* model = self.IdentityList[indexPath.row];
    if(model.isAuthed == NO) //unauthed
    {
        switch (indexPath.row)
        {
            case DOUBAN:
                [self showDoubanLogon];
                break;
            case SINA_WEIBO:
                [self showSinaWeiboLogon];
                break;
            case TAOBAO:
                [self showTaobaoLogon];
                break;
            case TENCENT:
                [self showTencentLogon];
                break;
            default:
                break;
        }
    }
    else //authed
    {
        [self showDetailInfo: (NETTYPE)indexPath.row withLogonToken:nil];
    }
}

- (void) showDoubanLogon
{
    DoubanLogonViewController* logonViewControler = [[DoubanLogonViewController alloc] init];
    logonViewControler.delegate = self;
    logonViewControler.netType = DOUBAN;
    logonViewControler.model = self.IdentityList[DOUBAN];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:logonViewControler];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void) showTaobaoLogon
{
    TaobaoLogonViewController* logonViewControler = [[TaobaoLogonViewController alloc] init];
    logonViewControler.delegate = self;
    logonViewControler.netType = TAOBAO;
    logonViewControler.model = self.IdentityList[TAOBAO];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:logonViewControler];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void) showSinaWeiboLogon
{
    sinaWeiboLogonController = [[SinaWeiboLogonController alloc] init];
    sinaWeiboLogonController.delegate = self;
    sinaWeiboLogonController.model = self.IdentityList[SINA_WEIBO];
    [sinaWeiboLogonController startLogon];
}

- (void) showTencentLogon
{
    tencentLogonController = [[TencentLogonController alloc] init];
    tencentLogonController.delegate = self;
    tencentLogonController.model = self.IdentityList[TENCENT];
    [tencentLogonController startLogon];
}

- (void) showDetailInfo: (NETTYPE) type withLogonToken:(NSDictionary*) dictToken
{
    DetailViewController* detailViewController = [[DetailViewController alloc] init];
    detailViewController.netType = type;
    detailViewController.model = self.IdentityList[type];
    [self.navigationController pushViewController:detailViewController animated:YES];
  }

- (BOOL) handleSinaWeiboUrl:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:sinaWeiboLogonController];
}

- (BOOL) handleTencentUrl:(NSURL *)url
{
    return [TencentOAuth HandleOpenURL:url];
}

- (void) getLogonResult:(BOOL)result Type:(NETTYPE) type Info:(NSDictionary *)info
{
    if(result == NO)
        return;
    [self showDetailInfo:type withLogonToken:info];
}

@end
