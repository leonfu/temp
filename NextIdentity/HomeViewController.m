//
//  HomeViewController.m
//  NextIdentity
//
//  Created by Leon on 14-9-4.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "HomeViewController.h"
#import "NSAssetModel.h"
#import "PNColor.h"
#import "NSUserModel.h"
#import "AssetDetailViewController.h"

#define URL_ASSET_BIND "digitalassets/bind/"
#define URL_ASSET_TODAY "digitalassets/today/"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize touchView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scoreLabel.textColor = PNFreshGreen;
    self.firstLabel.textColor = PNFreshGreen;
    vendorViewController = self.childViewControllers[0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [Utility loadUserModel];
    BOOL isLogon = [NSUserModel sharedInstance].isLogon;
    if(isLogon == NO)
    {
        [self performSegueWithIdentifier:@"presentCoverIdentifier" sender:self];
    }
    else
    {
        [self updateHomeScreen];
    }
}

- (void) initHomeScreen
{
    self.scoreLabel.text = @"0";
    self.welcomeLabel.hidden = YES;
    self.scoreLabel.hidden = YES;
    self.firstLabel.hidden = NO;
    self.introLabel.hidden = NO;
    [vendorViewController.collectionView reloadData];
}

- (void) updateHomeScreen
{
    if([NSAssetList sharedInstance].isEmpty)
    {
        [self initHomeScreen];
        return;
    }
    self.scoreLabel.text = [NSAssetList sharedInstance].totalAssetModel.totalScore.description;
    self.welcomeLabel.hidden = NO;
    self.scoreLabel.hidden = NO;
    self.firstLabel.hidden = YES;
    self.introLabel.hidden = YES;
    [vendorViewController.collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getLogonResult:(BOOL)result Type:(VENDOR_TYPE) type Info:(NSDictionary *)info
{
    if(result == NO)
    {
        [Utility showErrorMessage:@"绑定财产提供商失败:("];
        return;
    }
    [self bindAssetProvider: type];
}

- (void) bindAssetProvider: (VENDOR_TYPE) type
{
    NSAssetModel* model = vendorViewController.vendorList[type];
    URLRequestHandler* handler = [[URLRequestHandler alloc]initWithURLStringPOST:@URL_SERVER_PATH @URL_ASSET_BIND Body:[Utility getJSONFromObject:model.tokens] Topic:TOPIC_ASSET_BIND];
    [handler startWithCompletion:^(BOOL isValid, NSString *result, NSInteger topic)
    {
        if(isValid == YES)
        {
            URLRequestHandler* handler2 = [[URLRequestHandler alloc] initWithURLStringPOST:@URL_SERVER_PATH @URL_ASSET_TODAY Body:nil Topic:TOPIC_ASSET_TODAY];
            [handler2 startWithCompletion:^(BOOL isValid, NSString *result, NSInteger topic) {
                if(isValid == YES)
                {
                    
                }
                else
                {
                    [Utility showErrorMessage:result];
                }
            }];
        }
        else
        {
            [Utility showErrorMessage:result];
        }
    }];
    [self updateHomeScreen];
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([NSAssetList sharedInstance].totalAssetModel.totalScore == 0)
    {
        [[self nextResponder] touchesEnded:touches withEvent:event];
        return;
    }
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    if(CGRectContainsPoint(touchView.frame, location))
    {
        [self performSegueWithIdentifier:@"pushTotalAssetIdentifier" sender:self];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"pushTotalAssetIdentifier"])
    {
        AssetDetailViewController* controller = [segue destinationViewController];
        controller.model = [NSAssetList sharedInstance].totalAssetModel;
    }
}


@end
