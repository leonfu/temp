//
//  AssetTotalViewController.m
//  DigitalAssets
//
//  Created by Leon on 14-9-8.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "AssetTotalViewController.h"
#import "AppDelegate.h"
#import "AssetDetailViewController.h"

@interface AssetTotalViewController ()

@end

@implementation AssetTotalViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //name, value, percentage%
    data = @{@"values" : @[@[@"豆瓣", @"12",@"120"], @[@"QQ", @"14", @"140"], @[@"微博", @"28",@"280"], @[@"淘宝", @"10",@"100"], @[@"领英", @"5",@"50"], @[@"微信", @"31", @"310"]], @"total": @"1,234"};
    self.navigationItem.title = @"我的财产占比图";
    [self showChartView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showChartView
{
    NSMutableArray* items = [[NSMutableArray alloc] init];
    float n = 216.0;
    for (NSArray* array in data[@"values"])
    {
        UIColor* green = [UIColor colorWithRed:77.0 / 255.0 green:n / 255.0 blue:122.0 / 255.0 alpha:1.0f];
        n -= 20;
        NSString* title = [NSString stringWithFormat:@"%@ %@%%", array[0], array[1]];
        [items addObject:[PNPieChartDataItem dataItemWithValue:((NSString*)array[1]).floatValue color:green description: title]];
    }
 /*
    UILabel * pieChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    pieChartLabel.text = data[@"total"];
    pieChartLabel.textColor = PNBlack   ;
    pieChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:20.0];
    pieChartLabel.textAlignment = NSTextAlignmentCenter;
*/
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 40.0, 240.0, 220.0) items:items];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    pieChart.descriptionTextShadowColor = [UIColor clearColor];
    [pieChart strokeChart];
    
//    [self.chartView addSubview:pieChartLabel];
    [self.chartView addSubview:pieChart];

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
    return ALLTYPE+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALL_ASSET_DETAIL_CELL" forIndexPath:indexPath];
    
    cell.textLabel.text = data[@"values"][indexPath.row][0];
    cell.detailTextLabel.text = data[@"values"][indexPath.row][2];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
