//
//  NSUserModel.m
//  NextIdentity
//
//  Created by Leon on 14-9-6.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "NSUserModel.h"

@implementation NSUserModel

@synthesize isLogon, phone, email, sex, nick, token, userid, userModel;

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

- (void) initInstance: (NSUserModel*) inst
{
    [self fillUserProfile: inst.userModel];
    isLogon = inst.isLogon;
    [Utility saveUserModel];
}

- (id) init
{
    if(self = [super init])
    {
        self.isLogon = NO;
    }
    return self;
}

- (void) fillUserProfile: (NSDictionary*) dict
{
    userModel = [dict mutableCopy];
    [Utility saveUserModel];
}

- (void) setIsLogon: (BOOL) value
{
    isLogon = value;
    if(value == NO)
        [userModel removeAllObjects];
}

- (NSString*) phone
{
    return userModel[@"mobile"] == nil ? @"": userModel[@"mobile"];
}

- (NSString*) email
{
    return userModel[@"profile"][@"email"] == nil ? @"": userModel[@"profile"][@"email"];
}

- (NSString*) sex
{
    return ((NSString*)userModel[@"profile"][@"sex"]).intValue == 0 ? @"男" : @"女" ;
}

- (NSString*) nick
{
    return userModel[@"username"] == nil ? @"": userModel[@"username"];
}

- (NSString*) token
{
    return userModel[@"token"] == nil? @"" : userModel[@"token"];
}

- (NSString*) userid
{
    return userModel[@"id"] == nil? @"": userModel[@"id"];
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:userModel forKey:@"userModel"];
    [aCoder encodeBool:isLogon forKey:@"isLogon"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
	if (self=[super init])
	{
		userModel = [[aDecoder decodeObjectForKey:@"userModel"] mutableCopy];
        isLogon = [aDecoder decodeBoolForKey:@"isLogon"];
	}
	return self;
	
}

@end
