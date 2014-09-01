//
//  SinaWeiboDetailViewController.h
//  NextIdentity
//
//  Created by Leon on 14-9-1.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "DetailViewController.h"
#import "NSSinaWeiboIdentityModel.h"

@interface SinaWeiboDetailViewController : DetailViewController<ModelDoneDelegate>

@property (strong, nonatomic) NSSinaWeiboIdentityModel* model;
@end
