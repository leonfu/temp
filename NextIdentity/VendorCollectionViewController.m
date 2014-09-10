//
//  VendorCollectionViewController.m
//  NextIdentity
//
//  Created by Leon on 14-9-4.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "VendorCollectionViewController.h"
#import "NSAssetModel.h"
#import "VendorCollectionViewCell.h"
#import "DoubanLogonViewController.h"
#import "SinaWeiboLogonController.h"
#import "TaobaoLogonViewController.h"
#import "TencentLogonController.h"
#import "LinkedInLogonViewController.h"
#import "NSAssetModel.h"
#import "TencentOpenAPI/TencentOAuth.h"
#import "AssetDetailViewController.h"
#import "NavigationController.h"
#import "HomeViewController.h"

@interface VendorCollectionViewController ()

@end

@implementation VendorCollectionViewController

@synthesize vendorList;

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
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSString *plistpath = [[NSBundle mainBundle] pathForResource: @"AssetType" ofType: @"plist"];
    NSArray *plist = [NSArray arrayWithContentsOfURL: [NSURL fileURLWithPath: plistpath]];
    for (int i = DOUBAN; i < ALLTYPE; i++)
    {
        NSAssetModel* model = [[NSAssetModel alloc] initWithType:i Name:plist[i][@"Name"] Image:[UIImage imageNamed:plist[i][@"Image"]]];
        [array addObject:model];
    }
    [NSAssetList sharedInstance].assetList = array;
    NSAssetModel* model = [[NSAssetModel alloc] initWithType:ALLTYPE Name:@"所有财产" Image:nil];
    [NSAssetList sharedInstance].totalAssetModel = model;
    vendorList = [NSAssetList sharedInstance].assetList;
    
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return vendorList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VendorCollectionViewCell* vendorCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VENDOR_COLL_CELL" forIndexPath:indexPath];
    NSAssetModel* model = vendorList[indexPath.row];
    vendorCell.vendorIconView.image = model.image;
    vendorCell.vendorNameLabel.text = model.name;
    vendorCell.vendorScoreLabel.text = model.isAuthed? model.deltaScore.description : @"--";
    return  vendorCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.alpha = 1.0;

/*    NSAssetModel* model = self.vendorList[indexPath.row];
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
            case LINKEDIN:
                [self showLinkedInLogon];
                break;
            default:
                break;
        }
    }
    else //authed
*/    {
        [self showDetailInfo: (VENDOR_TYPE)indexPath.row withLogonToken:nil];
    }
}
- (void) showLinkedInLogon
{
    LinkedInLogonViewController* logonViewControler = [[LinkedInLogonViewController alloc] init];
    logonViewControler.delegate = (HomeViewController*)self.parentViewController;
    logonViewControler.netType = LINKEDIN;
    logonViewControler.model = self.vendorList[LINKEDIN];
    NavigationController* navController = [[NavigationController alloc] initWithRootViewController:logonViewControler];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void) showDoubanLogon
{
    DoubanLogonViewController* logonViewControler = [[DoubanLogonViewController alloc] init];
    logonViewControler.delegate = (HomeViewController*)self.parentViewController;
    logonViewControler.netType = DOUBAN;
    logonViewControler.model = self.vendorList[DOUBAN];
    NavigationController* navController = [[NavigationController alloc] initWithRootViewController:logonViewControler];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void) showTaobaoLogon
{
    TaobaoLogonViewController* logonViewControler = [[TaobaoLogonViewController alloc] init];
    logonViewControler.delegate = (HomeViewController*)self.parentViewController;
    logonViewControler.netType = TAOBAO;
    logonViewControler.model = self.vendorList[TAOBAO];
    NavigationController* navController = [[NavigationController alloc] initWithRootViewController:logonViewControler];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void) showSinaWeiboLogon
{
    sinaWeiboLogonController = [[SinaWeiboLogonController alloc] init];
    sinaWeiboLogonController.delegate = (HomeViewController*)self.parentViewController;
    sinaWeiboLogonController.model = self.vendorList[SINA_WEIBO];
    [sinaWeiboLogonController startLogon];
}

- (void) showTencentLogon
{
    tencentLogonController = [[TencentLogonController alloc] init];
    tencentLogonController.delegate = (HomeViewController*)self.parentViewController;
    tencentLogonController.model = self.vendorList[TENCENT];
    [tencentLogonController startLogon];
}

- (void) showDetailInfo: (VENDOR_TYPE) type withLogonToken:(NSDictionary*) dictToken
{
    vendorType = type;
    [self performSegueWithIdentifier:@"pushAssetDetailIdentifier" sender:self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    AssetDetailViewController* controller = [segue destinationViewController];
    controller.model = vendorList[vendorType];
}

- (BOOL) handleSinaWeiboUrl:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:sinaWeiboLogonController];
}

- (BOOL) handleTencentUrl:(NSURL *)url
{
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL) openType:(VENDOR_TYPE)type URL:(NSURL*)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if(type == SINA_WEIBO)
    {
        return [self handleSinaWeiboUrl: url];
    }
    else if(type == TENCENT)
    {
        return [self handleTencentUrl: url];
    }
    return YES;
}

@end
