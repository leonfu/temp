//
//  DetailViewController.m
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "AssetDetailViewController.h"

@interface AssetDetailViewController ()

@end

@implementation AssetDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.hidesWhenStopped = YES;
    [indicator startAnimating];
    indicator.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2 - self.view.frame.origin.y);
    [self.tableView addSubview:indicator];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [NSString stringWithFormat:@"我在%@的财产", self.model.name];
    if(self.model.vendorType == ALLTYPE)
        self.navigationItem.title = [NSString stringWithFormat:@"我的总财产"];
    //date, value
    data = @{@"values": @{@"09-01":@"18", @"09-08":@"7", @"09-15":@"12", @"09-22":@"4", @"08-25":@"15", @"08-18":@"5", @"08-11":@"10", @"08-04":@"11", @"07-23":@"10", @"07-16":@"11"}, @"total":@"1,234"};
    key = [((NSDictionary*)data[@"values"]).allKeys sortedArrayUsingComparator:^(id a, id b)
           {
               return [b compare:a];
           }];
    [self.tableView reloadData];
    [self showChartView];
    [indicator stopAnimating];
}

- (void) showChartView
{
    NSMutableArray* arrayValues = [[NSMutableArray alloc] init];
    for(NSString* k in key)
    {
        [arrayValues addObject:data[@"values"][k]];
    }
    UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    lineChartLabel.text = data[@"total"];
    lineChartLabel.textColor = PNBlack;
    lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:16.0];
    lineChartLabel.textAlignment = NSTextAlignmentCenter;
    
    PNChart * lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 200.0)];
    lineChart.backgroundColor = [UIColor clearColor];
    [lineChart setXLabels:key];
    [lineChart setYValues:arrayValues];
    [lineChart strokeChart];
    
    [self.chartView addSubview:lineChartLabel];
    [self.chartView addSubview:lineChart];
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
    return ((NSDictionary*)data[@"values"]).count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ASSET_DETAIL_CELL" forIndexPath:indexPath];
    cell.textLabel.text = key[indexPath.row];
    cell.detailTextLabel.text = data[@"values"][key[indexPath.row]];
    return cell;
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
