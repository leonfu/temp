//
//  VendorCollectionViewController.m
//  NextIdentity
//
//  Created by Leon on 14-9-4.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "VendorCollectionViewController.h"
#import "NSIdentityModel.h"
#import "VendorCollectionViewCell.h"

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
    NSString *plistpath = [[NSBundle mainBundle] pathForResource: @"IdentityType" ofType: @"plist"];
    NSArray *plist = [NSArray arrayWithContentsOfURL: [NSURL fileURLWithPath: plistpath]];
    for (int i = DOUBAN; i < TENCENT+1+2; i++)
    {
        NSIdentityModel* model = [[NSIdentityModel alloc] initWithType:i Name:plist[i][@"Name"] Image:[UIImage imageNamed:plist[i][@"Image"]]];
        [array addObject:model];
    }
    [NSIdentityList sharedInstance].identityList = array;
    vendorList = [NSIdentityList sharedInstance].identityList;
    
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
    NSIdentityModel* model = vendorList[indexPath.row];
    vendorCell.vendorIconView.image = model.image;
    vendorCell.vendorNameLabel.text = model.name;
    vendorCell.vendorScoreLabel.text = model.deltaScore.description;
    NSLog(@"%f, %f", vendorCell.bounds.size.width, vendorCell.bounds.size.height);
    return  vendorCell;
}

@end
