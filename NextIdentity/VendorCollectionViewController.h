//
//  VendorCollectionViewController.h
//  NextIdentity
//
//  Created by Leon on 14-9-4.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VendorCollectionViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate>


@property (assign, nonatomic) NSMutableArray* vendorList;
@end
