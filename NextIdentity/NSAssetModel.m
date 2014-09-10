//
//  NSIdentityModel.m
//  NextIdentity
//
//  Created by Leon Fu on 9/1/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "NSAssetModel.h"


@implementation NSAssetList

@synthesize assetList, totalAssetModel;

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

@synthesize isAuthed, isExpired, image, name, deltaScore, totalScore, vendorType, percentage, rank;

- (id) initWithType: (VENDOR_TYPE)type Name:(NSString*)_name Image:(UIImage*)_image
{
    isAuthed = NO;
    if(self = [super init])
    {
        tokenModel = [@{@"provider_name":@"", @"access_token":@"", @"refresh_token":@"", @"expire_in":@"", @"user_id":@""} mutableCopy];
        vendorType = type;
        name = _name;
        image = _image;
        deltaScore = @0;
        totalScore = @0;
    }
    return self;
}

- (void) updateAsset: (NSNumber*) total_score Delta: (NSNumber*) delta_socre Percentage:(NSNumber*) _percentage Rank:(NSNumber*)_rank
{
    totalScore = total_score;
    deltaScore = delta_socre;
    percentage = _percentage;
    rank = _rank;
}

- (void) addNewKey: (NSString*)key SubKeys: (NSArray*) subKeys
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    for(NSString* str in subKeys)
    {
        [dict setObject:@"" forKey:str];
    }
    tokenModel[key] = [NSMutableDictionary dictionaryWithDictionary:dict];
}

- (void) addUserTokens:(NSString *)token RefreshToken:(NSString *)rtoken ExpireIn:(NSString *)expire UserID:(NSString *)userId UserNick:(NSString *)userNick
{
    tokenModel[@"provider_name"] = self.name;
    tokenModel[@"access_token"] = token;
    tokenModel[@"refresh_token"] = rtoken;
    tokenModel[@"expire_in"] = expire;
    tokenModel[@"user_id"] = userId;
    isAuthed = YES;
}

- (NSDictionary*) tokens
{
    return tokenModel;
}

@end
