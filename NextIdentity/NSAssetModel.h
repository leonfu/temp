
//
//  NSIdentityModel.h
//  NextIdentity
//
//  Created by Leon Fu on 9/1/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface NSAssetModel : NSObject
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
@end

@interface NSAssetList: NSObject
{
    
}
+ (NSAssetList*) sharedInstance;
@property (strong, nonatomic) NSAssetModel* totalAssetModel;
@property (strong, nonatomic) NSMutableArray* assetList;
@end