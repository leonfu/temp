//
//  NSIdentityModel.m
//  NextIdentity
//
//  Created by Leon Fu on 9/1/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "NSIdentityModel.h"

@implementation NSIdentityModel

@synthesize delegate, isAuthed, dictModel, accessToken, refreshToken, isExpired;

- (id) init
{
    self.isAuthed = NO;
    self = [super init];
    dictModel = [[NSMutableDictionary alloc] init];
    [dictModel setObject:@"" forKey:@"logon_tokens"];
    [self addNewKey: @"logon_tokens" SubKeys: [NSArray arrayWithObjects:@"token", @"refresh_token", @"expire_time", nil]];
    [dictModel setObject:@"" forKey:@"user_infos"];
    [self addNewKey:@"user_infos" SubKeys: [NSArray arrayWithObjects:@"user_id", @"user_nick", @"user_email", @"user_profile", nil]];
    [dictModel setObject:@"" forKey:@"user_favorites"];
    return self;
}


- (void) addNewKey: (NSString*)key SubKeys: (NSArray*) subKeys
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    for(NSString* str in subKeys)
    {
        [dict setObject:@"" forKey:str];
    }
    dictModel[key] = [NSMutableDictionary dictionaryWithDictionary:dict];
}

- (NSString*) accessToken
{
    return dictModel[@"logon_tokens"][@"token"];
}

- (NSString*) refreshToken
{
    return dictModel[@"logon_tokens"][@"refresh_token"];
}

- (BOOL) isExpired
{
    return NO;
}

- (NSString*) userID
{
    return dictModel[@"user_infos"][@"user_id"];
}

- (NSDictionary*) userFavorites
{
    return dictModel[@"user_favorites"];
}

- (NSString*) userProfile
{
    return dictModel[@"user_infos"][@"user_profile"];
}

@end
