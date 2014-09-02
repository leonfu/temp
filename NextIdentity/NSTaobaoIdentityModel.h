//
//  NSTaobaoIdentityModel.h
//  NextIdentity
//
//  Created by Leon Fu on 9/2/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "NSIdentityModel.h"

@interface NSTaobaoIdentityModel : NSIdentityModel

- (void) updateLogonToken: (NSDictionary*)dict;
@end
