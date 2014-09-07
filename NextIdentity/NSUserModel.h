//
//  NSUserModel.h
//  NextIdentity
//
//  Created by Leon on 14-9-6.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserModel : NSObject
{
    NSMutableDictionary* dictModel;
}
+ (NSUserModel*) sharedInstance;

- (void) fillProfile: (NSDictionary*) dict;
@property (assign, nonatomic) BOOL isLogon;
@property (readonly, nonatomic) NSString* phone;
@property (readonly, nonatomic) NSString* nick;
@property (readonly, nonatomic) NSString* email;
@property (readonly, nonatomic) NSString* sex;
@end
