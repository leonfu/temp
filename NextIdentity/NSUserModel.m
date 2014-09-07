//
//  NSUserModel.m
//  NextIdentity
//
//  Created by Leon on 14-9-6.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "NSUserModel.h"

@implementation NSUserModel

@synthesize isLogon, phone, email, sex, nick;

static NSUserModel *_sharedInstance;

+ (NSUserModel*) sharedInstance
{
    @synchronized(self)
    {
        if (!_sharedInstance)
        {
            _sharedInstance = [[NSUserModel alloc] init];
        }
    }
    
    return _sharedInstance;
}

- (id) init
{
    if(self = [super init])
    {
        self.isLogon = NO;
        dictModel = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) fillProfile: (NSDictionary*) dict
{
    dictModel = [dict mutableCopy];
}

- (void) setIsLogon: (BOOL) value
{
    isLogon = value;
    if(value == NO)
        [dictModel removeAllObjects];
}

- (NSString*) phone
{
    return dictModel[@"phone"];
}

- (NSString*) email
{
    return dictModel[@"email"];
}

- (NSString*) sex
{
    return ((NSString*)dictModel[@"sex"]).intValue == 0 ? @"男" : @"女" ;
}

- (NSString*) nick
{
    return dictModel[@"nick"];
}

@end
