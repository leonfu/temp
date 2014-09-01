//
//  NSDoubanIdentityModel.h
//  NextIdentity
//
//  Created by Leon Fu on 9/1/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "NSIdentityModel.h"
#import "URLRequestHandler.h"

@interface NSDoubanIdentityModel : NSIdentityModel<RequestDelegate>

- (void) updateLogonToken: (NSDictionary*)dict;
- (void) buildUserInfo;
- (void) buildUserFavoriteBooks;

@end
