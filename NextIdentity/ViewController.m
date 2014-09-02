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
#import "NSDoubanIdentityModel.h"
#import "DoubanDetailViewController.h"
#import "NSSinaWeiboIdentityModel.h"
#import "SinaWeiboLogonController.h"
#import "SinaWeiboDetailViewController.h"
#import "TaobaoLogonViewController.h"
#import "NSIdentityModel.h"
#import "TaobaoDetailViewController.h"
#import "NSTaobaoIdentityModel.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize sinaWeiboLogonController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSDoubanIdentityModel* modelDouban = [[NSDoubanIdentityModel alloc]init];
    NSSinaWeiboIdentityModel* modelSina = [[NSSinaWeiboIdentityModel alloc] init];
    NSTaobaoIdentityModel* modelTaobao = [[NSTaobaoIdentityModel alloc] init];
    self.IdentityList = [[NSArray alloc] initWithObjects:modelDouban, modelSina, modelTaobao, nil];
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
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:logonViewControler];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void) showTaobaoLogon
{
    TaobaoLogonViewController* logonViewControler = [[TaobaoLogonViewController alloc] init];
    logonViewControler.delegate = self;
    logonViewControler.netType = TAOBAO;
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:logonViewControler];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void) showSinaWeiboLogon
{
    sinaWeiboLogonController = [[SinaWeiboLogonController alloc] init];
    sinaWeiboLogonController.delegate = self;
    [sinaWeiboLogonController startLogon];
}

- (void) showDetailInfo: (NETTYPE) type withLogonToken:(NSDictionary*) dictToken
{
    if(type == DOUBAN)
    {
        DoubanDetailViewController* detailViewController =[[DoubanDetailViewController alloc] init];
        detailViewController.netType = DOUBAN;
        detailViewController.model = self.IdentityList[DOUBAN];
        detailViewController.token = dictToken;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else if(type == SINA_WEIBO)
    {
        SinaWeiboDetailViewController* detailViewController = [[SinaWeiboDetailViewController alloc] init];
        detailViewController.netType = SINA_WEIBO;
        detailViewController.model = self.IdentityList[SINA_WEIBO];
        detailViewController.token = dictToken;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else if(type == TAOBAO)
    {
        TaobaoDetailViewController* detailViewController = [[TaobaoDetailViewController alloc] init];
        detailViewController.netType = TAOBAO;
        detailViewController.model = self.IdentityList[TAOBAO];
        detailViewController.token = dictToken;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

- (BOOL) handleSinaWeiboUrl:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:sinaWeiboLogonController];
}

- (void) getLogonResult:(BOOL)result Type:(NETTYPE) type Info:(NSDictionary *)info
{
    if(result == NO)
        return;
    [self showDetailInfo:type withLogonToken:info];
}

@end
