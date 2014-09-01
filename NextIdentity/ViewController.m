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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSDoubanIdentityModel* modelDouban = [[NSDoubanIdentityModel alloc]init];
    self.IdentityList = [[NSArray alloc] initWithObjects:modelDouban, nil];
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
    return 2;
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
        case 0:
            cell.textLabel.text = @"我的豆瓣身份";
            break;
        case 1:
            cell.textLabel.text = @"我的微博身份";
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIdentityModel* model = self.IdentityList[indexPath.row];
    if(model.isAuthed == NO) //unauthed
    {
        DoubanLogonViewController* logonViewControler = [[DoubanLogonViewController alloc] init];
        logonViewControler.delegate = self;
        logonViewControler.netType = DOUBAN;
        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:logonViewControler];
        [self presentViewController:navController animated:YES completion:nil];
    }
    else //authed
    {
        [self showDetailInfo: indexPath.row withLogonToken:nil];
    }
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
}

- (void) getLogonResult:(BOOL)result Type:(NETTYPE) type Info:(NSString *)info
{
    if(result == NO)
        return;
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData: [info dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    if(type == DOUBAN)
    {
        [self showDetailInfo:type withLogonToken:dict];
    }
}

@end
