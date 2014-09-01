//
//  NSSinaWeiboIdentityModel.h
//  NextIdentity
//
//  Created by Leon on 14-9-1.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "NSIdentityModel.h"

@interface NSSinaWeiboIdentityModel : NSIdentityModel

- (void) updateLogonToken: (NSDictionary*)dict;

@end
