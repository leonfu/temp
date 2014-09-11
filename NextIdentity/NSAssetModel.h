
//
//  NSIdentityModel.h
//  NextIdentity
//
//  Created by Leon Fu on 9/1/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

typedef enum {DOUBAN=0, TENCENT, SINA_WEIBO, TAOBAO, LINKEDIN, WECHAT, ALLTYPE} VENDOR_TYPE;

@class NSAssetModel, NSAssetList;

@interface NSAssetList: NSObject<NSCoding>

+ (NSAssetList*) sharedInstance;
- (void) initInstance: (NSAssetList*) list;
- (void) updateAsset: (VENDOR_TYPE)type Total:(NSNumber*) total_score Delta: (NSNumber*) delta_socre Percentage:(NSNumber*) _percentage Rank:(NSNumber*)_rank;
- (void) fillAssetInfo: (NSDictionary*) info;
@property (readonly, nonatomic) BOOL isEmpty;
@property (strong, nonatomic) NSAssetModel* totalAssetModel;
@property (strong, nonatomic) NSMutableArray* assetList;
@end

@interface NSAssetModel : NSObject<NSCoding>
{
    NSMutableDictionary* tokenModel;
    NSString* accessToken;
    NSString* refreshToken;
    NSString* userID;
}
@property (readonly, nonatomic) UIImage* image;
@property (readonly, nonatomic) NSString* name;
@property (readonly, nonatomic) NSNumber* deltaScore;
@property (readonly, nonatomic) NSNumber* totalScore;
@property (readonly, nonatomic) NSNumber* rank;
@property (readonly, nonatomic) NSNumber* percentage;
@property (readonly, nonatomic) VENDOR_TYPE vendorType;
@property (readonly, nonatomic) BOOL isAuthed;
@property (readonly, nonatomic) BOOL isExpired;
@property (readonly, nonatomic) NSDictionary* tokens;

- (id) initWithType: (VENDOR_TYPE)type Name:(NSString*)_name Image:(UIImage*)_image;
- (void) addNewKey: (NSString*)key SubKeys: (NSArray*) subKeys;
- (void) addUserTokens: (NSString*)token RefreshToken: (NSString*)rtoken ExpireIn: (NSString*)expire UserID: (NSString*)userId UserNick: (NSString*) userNick;
- (void) updateAsset: (NSNumber*) total_score Delta: (NSNumber*) delta_socre Percentage:(NSNumber*) _percentage Rank:(NSNumber*)_rank;
@end