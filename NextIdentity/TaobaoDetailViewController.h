//
//  TaobaoDetailViewController.h
//  NextIdentity
//
//  Created by Leon Fu on 9/2/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "DetailViewController.h"
#import "NSTaobaoIdentityModel.h"

@interface TaobaoDetailViewController : DetailViewController<ModelDoneDelegate>

@property (strong, nonatomic) NSTaobaoIdentityModel* model;

@end
