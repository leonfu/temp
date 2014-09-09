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

    float value = [NSAssetList sharedInstance].totalScore.floatValue;
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
    self.scoreLabel.text = [NSAssetList sharedInstance].totalScore.description;
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

- (void) getLogonResult:(BOOL)result Type:(VENDOR_TYPE) type Info:(NSDictionary *)info
{
    if(result == NO)
        return;
    NSAssetModel* model = vendorViewController.vendorList[type];
    model.deltaScore = @100;
    [vendorViewController.collectionView reloadData];
    float value = [NSAssetList sharedInstance].totalScore.floatValue;
    [NSAssetList sharedInstance].totalScore = @(value + model.deltaScore.floatValue);
    [self updateHomeScreen];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([NSAssetList sharedInstance].totalScore == 0)
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
