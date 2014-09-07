//
//  HomeViewController.m
//  NextIdentity
//
//  Created by Leon on 14-9-4.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "HomeViewController.h"
#import "NSIdentityModel.h"
#import "PNColor.h"
#import "NSUserModel.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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

    float value = [NSIdentityList sharedInstance].totalScore.floatValue;
    if(value == 0) //no any binding
    {
        [self initHomeScreen];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    BOOL isLogon = [NSUserModel sharedInstance].isLogon;
    if(isLogon == NO)
    {
        [self performSegueWithIdentifier:@"presentCoverIdentifier" sender:self];
    }   
}

- (void) initHomeScreen
{
    self.scoreLabel.text = @"0";
    self.welcomeLabel.hidden = YES;
    self.scoreLabel.hidden = YES;
    self.firstLabel.hidden = NO;
    self.introLabel.hidden = NO;
}

- (void) updateHomeScreen
{
    self.scoreLabel.text = [NSIdentityList sharedInstance].totalScore.description;
    self.welcomeLabel.hidden = NO;
    self.scoreLabel.hidden = NO;
    self.firstLabel.hidden = YES;
    self.introLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getLogonResult:(BOOL)result Type:(VENDORTYPE) type Info:(NSDictionary *)info
{
    if(result == NO)
        return;
    NSIdentityModel* model = vendorViewController.vendorList[type];
    model.deltaScore = @100;
    [vendorViewController.collectionView reloadData];
    float value = [NSIdentityList sharedInstance].totalScore.floatValue;
    [NSIdentityList sharedInstance].totalScore = @(value + model.deltaScore.floatValue);
    [self updateHomeScreen];
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
