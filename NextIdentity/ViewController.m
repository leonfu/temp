//
//  ViewController.m
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"0" forKey:@"is_authed"];
    [dict setObject:@"" forKey:@"content"];
    [dict setObject:@"" forKey:@"token"];
    self.IdentityList = [[NSArray alloc] initWithObjects:dict, dict, nil];
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
    NSDictionary* dict = self.IdentityList[indexPath.row];
    NSString* authed = dict[@"is_authed"];
    if([authed compare:@"0"] == NSOrderedSame) //unauthed
    {
        DoubanLogonViewController* logonViewControler = [[DoubanLogonViewController alloc] init];
        logonViewControler.delegate = self;
        logonViewControler.netType = DOUBAN;
        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:logonViewControler];
        [self presentViewController:navController animated:YES completion:nil];
    }
    else
    {
        [self showDetailInfo: indexPath.row];
    }
}

- (void) showDetailInfo: (NSInteger) type
{
    DetailViewController* detailViewController = [[DetailViewController alloc] init];
    switch(type)
    {
        case 0:
            detailViewController.netType = DOUBAN;
            [self.navigationController pushViewController:detailViewController animated:YES];
            break;
        case 1:
            break;
    }
   
}

- (void) getLogonResult:(BOOL)result Type:(NETTYPE) type Info:(NSString *)info
{
    if(result == NO)
        return;
    if(type == DOUBAN)
    {
        self.IdentityList[DOUBAN][@"token"] = info;
        self.IdentityList[DOUBAN][@"is_authed"] = @"1";
        [self showDetailInfo: type];
    }
}

@end
