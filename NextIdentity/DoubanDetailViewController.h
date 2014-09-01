//
//  DoubanDetailViewController.h
//  NextIdentity
//
//  Created by Leon Fu on 9/1/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "DetailViewController.h"
#import "NSDoubanIdentityModel.h"

@interface DoubanDetailViewController : DetailViewController<ModelDoneDelegate>

@property (strong, nonatomic) NSDoubanIdentityModel* model;
@end
