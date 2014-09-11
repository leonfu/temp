//
//  NSUserModel.h
//  NextIdentity
//
//  Created by Leon on 14-9-6.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

@interface NSUserModel : NSObject<NSCoding>
{
    NSMutableDictionary* userModel;
}
+ (NSUserModel*) sharedInstance;
- (void) initInstance: (NSUserModel*) inst;
- (void) fillUserProfile: (NSDictionary*) dict;

@property (assign, nonatomic) BOOL isLogon;
@property (readonly, nonatomic) NSString* phone;
@property (readonly, nonatomic) NSString* nick;
@property (readonly, nonatomic) NSString* email;
@property (readonly, nonatomic) NSString* sex;
@property (readonly, nonatomic) NSString* token;
@property (readonly, nonatomic) NSString* userid;
@property (readonly, nonatomic) NSMutableDictionary* userModel;
@end
