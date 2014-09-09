//
//  LogonViewController.m
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "VendorLogonViewController.h"

@interface VendorLogonViewController ()

@end

@implementation VendorLogonViewController

@synthesize webView, netType, delegate, model;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录认证";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeView)];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
}

- (void) closeView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) parseURLQuery:(NSString *)query forKey:(NSString *)key
{
    NSArray *urlComponents = [query componentsSeparatedByString:@"&"];
    for (NSString *keyValuePair in urlComponents)
    {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *k = [pairComponents objectAtIndex:0];
        NSString *v = [pairComponents objectAtIndex:1];
        if([k isEqualToString:key])
            return v;
    }
    return @"";
}

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
