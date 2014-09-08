//
//  DetailTableViewController.m
//  DigitalAssets
//
//  Created by Leon on 14-9-8.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "DetailTableViewController.h"

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController

@synthesize chartView, model;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) showChartView
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
