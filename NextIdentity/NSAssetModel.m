//
//  NSIdentityModel.m
//  NextIdentity
//
//  Created by Leon Fu on 9/1/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "NSAssetModel.h"


@implementation NSAssetList

@synthesize assetList, totalAssetModel, isEmpty;

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

- (void) initInstance: (NSAssetList*) list
{
    if (list == nil)
    {
        NSMutableArray* array = [[NSMutableArray alloc] init];
        NSString *plistpath = [[NSBundle mainBundle] pathForResource: @"AssetType" ofType: @"plist"];
        NSArray *plist = [NSArray arrayWithContentsOfURL: [NSURL fileURLWithPath: plistpath]];
        for (int i = DOUBAN; i < ALLTYPE; i++)
        {
            NSAssetModel* model = [[NSAssetModel alloc] initWithType:i Name:plist[i][@"Name"] Image:[UIImage imageNamed:plist[i][@"Image"]]];
            [array addObject:model];
        }
        assetList = array;
        NSAssetModel* model = [[NSAssetModel alloc] initWithType:ALLTYPE Name:@"所有财产" Image:nil];
        totalAssetModel = model;
        [Utility saveAssetModel];
    }
    else
    {
        totalAssetModel = list.totalAssetModel;
        assetList = list.assetList;
    }
}

- (void) fillAssetInfo:(NSDictionary *)info
{
    [totalAssetModel updateAsset:info[@"total_score"] Delta:nil Percentage:nil Rank:nil];
    NSNumber* count = (NSNumber*)info[@"asset_activecount"];
    for (int i = 0; i < count.intValue; i ++)
    {
        NSDictionary* dict = info[@"assets"][i];
        VENDOR_TYPE type = [self getTypeByName:dict[@"provider_name"]];
        NSAssetModel* model = assetList[type];
        [model updateAsset:dict[@"total_score"] Delta:dict[@"delta_score"] Percentage:dict[@"percentage"] Rank:dict[@"rank"]];
    }
}

- (VENDOR_TYPE) getTypeByName: (NSString*) name
{
    for(VENDOR_TYPE type = 0; type < ALLTYPE; type ++)
    {
        NSAssetModel* model = assetList[type];
        NSString* _name = model.name;
        if ([_name isEqualToString:name])
            return type;
    }
    return ALLTYPE;
}

- (BOOL) isEmpty
{
    return (totalAssetModel == nil || totalAssetModel.totalScore.floatValue == 0.0f);
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:totalAssetModel forKey:@"totalAssetModel"];
	[aCoder encodeObject:assetList forKey:@"AssetList"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
	if (self=[super init])
	{
		totalAssetModel = [aDecoder decodeObjectForKey:@"totalAssetModel"];
		assetList = [aDecoder decodeObjectForKey:@"AssetList"];
	}
	return self;
}

- (void) updateAsset: (VENDOR_TYPE)type Total:(NSNumber*) total_score Delta: (NSNumber*) delta_socre Percentage:(NSNumber*) _percentage Rank:(NSNumber*)_rank
{
    NSAssetModel* model = assetList[type];
    [model updateAsset:total_score Delta:delta_socre Percentage:_percentage Rank:_rank];
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
    [Utility saveAssetModel];
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
    [Utility saveAssetModel];
}

- (NSDictionary*) tokens
{
    return tokenModel;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:tokenModel forKey:@"tokenModel"];
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
	if (self=[super init])
	{
		tokenModel = [aDecoder decodeObjectForKey:@"tokenModel"];
	}
	return self;
	
}


@end
