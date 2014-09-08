//
//  NSIdentityModel.m
//  NextIdentity
//
//  Created by Leon Fu on 9/1/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "NSAssetModel.h"


@implementation NSAssetList

@synthesize assetList, totalScore, totalAssetModel;

static NSAssetList *_sharedInstance;

+ (NSAssetList*) sharedInstance
{
    @synchronized(self)
    {
        if (!_sharedInstance)
        {
            _sharedInstance = [[NSAssetList alloc] init];
        }
    }
    
    return _sharedInstance;
}

@end


@implementation NSAssetModel

@synthesize isAuthed, accessToken, refreshToken, isExpired, image, name, userID, deltaScore, totalScore, vendorType;

- (id) initWithType: (VENDOR_TYPE)type Name:(NSString*)_name Image:(UIImage*)_image
{
    isAuthed = NO;
    if(self = [super init])
    {
        dictModel = [[NSMutableDictionary alloc] init];
        [dictModel setObject:@"" forKey:@"logon_tokens"];
        [self addNewKey: @"logon_tokens" SubKeys: @[@"token", @"refresh_token", @"expire_time"]];
        [dictModel setObject:@"" forKey:@"user_infos"];
        [self addNewKey:@"user_infos" SubKeys: @[@"user_id", @"user_nick", @"user_email", @"user_profile"]];
        [dictModel setObject:@"" forKey:@"user_favorites"];
        
        vendorType = type;
        self.name = _name;
        self.image = _image;
        self.deltaScore = @-1;
    }
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

- (void) addUserTokens:(NSString *)token RefreshToken:(NSString *)rtoken ExpireIn:(NSString *)expire UserID:(NSString *)userId UserNick:(NSString *)userNick
{
    dictModel[@"logon_tokens"][@"token"] = token; 
    dictModel[@"logon_tokens"][@"refresh_token"] = rtoken;
    dictModel[@"logon_tokens"][@"expire_time"] = expire;
    dictModel[@"user_infos"][@"user_id"] = userId;
    dictModel[@"user_infos"][@"user_nick"] = userNick;
    isAuthed = YES;
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

- (NSDictionary*) tokens
{
    return dictModel[@"logon_tokens"];
//    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dictModel[@"logon_tokens"] options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

@end
