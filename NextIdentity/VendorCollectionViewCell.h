//
//  VendorCollectionViewCell.h
//  NextIdentity
//
//  Created by Leon on 14-9-4.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VendorCollectionViewCell : UICollectionViewCell


@property (strong, nonatomic) IBOutlet UIImageView* vendorIconView;
@property (strong, nonatomic) IBOutlet UILabel* vendorNameLabel;
@property (strong, nonatomic) IBOutlet UILabel* vendorScoreLabel;
@end
