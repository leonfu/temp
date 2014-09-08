//
//  DetailTableViewController.h
//  DigitalAssets
//
//  Created by Leon on 14-9-8.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NSAssetModel.h"
#import "ChartView.h"

@interface DetailTableViewController : UITableViewController
{
@protected
    NSDictionary* data;
    NSArray* key;
    UIActivityIndicatorView* indicator;
}

@property (strong, nonatomic) IBOutlet ChartView* chartView;
@property (assign, nonatomic) NSAssetModel* model;
- (void) showChartView;
@end
