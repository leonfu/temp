//
//  AssetRankingViewController.m
//  DigitalAssets
//
//  Created by Leon on 14-9-8.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "AssetRankingViewController.h"
#import "AssetDetailViewController.h"

@interface AssetRankingViewController ()

@end

@implementation AssetRankingViewController

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
    //name, value, rank%
    data = @{@"values" : @[@[@"豆瓣", @"12", @"98"], @[@"QQ", @"14", @"95"], @[@"微博", @"28",@"82"], @[@"淘宝", @"10",@"33"], @[@"领英", @"5",@"50"], @[@"微信", @"31", @"10"], @[@"全部", @"1,234", @"88"]]};
    self.navigationItem.title = @"财富榜";
    [self showChartView];
}

- (void) showChartView
{
/*    UILabel * barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 30)];
    barChartLabel.text = data[@"total"];
    barChartLabel.textColor = PNFreshGreen;
    barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
    barChartLabel.textAlignment = NSTextAlignmentCenter;
*/
    PNChart * barChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 10.0, SCREEN_WIDTH, 200.0)];
    barChart.backgroundColor = [UIColor clearColor];
    barChart.type = PNBarType;
    NSMutableArray* arrayLabel = [[NSMutableArray alloc] init];
    NSMutableArray* arrayValue = [[NSMutableArray alloc] init];
    for (NSArray* array in data[@"values"])
    {
        [arrayLabel addObject:array[0]];
        [arrayValue addObject:array[2]];
    }
    [barChart setXLabels:arrayLabel];
    [barChart setYValues:arrayValue];
    [barChart strokeChart];
    
    //[self.chartView addSubview:barChartLabel];
    [self.chartView addSubview:barChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return ALLTYPE+3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASSET_DETAIL_CELL" forIndexPath:indexPath];
    
    cell.textLabel.text = data[@"values"][indexPath.row][0];
    int value = ((NSString*)data[@"values"][indexPath.row][2]).intValue;
    if(value >= 50)
        cell.detailTextLabel.text = [NSString stringWithFormat:@"前%d%%", 100 - value];
    else
        cell.detailTextLabel.text = [NSString stringWithFormat:@"后%d%%", value];
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"pushAssetDetailIdentifier"])
    {
        AssetDetailViewController* controller = [segue destinationViewController];
        controller.model = [NSAssetList sharedInstance].assetList[self.tableView.indexPathForSelectedRow.row];
    }
}


@end
