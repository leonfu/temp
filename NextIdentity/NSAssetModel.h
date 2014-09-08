
//
//  NSIdentityModel.h
//  NextIdentity
//
//  Created by Leon Fu on 9/1/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
/*
@protocol ModelDoneDelegate

- (void) modelComplete:(BOOL)result Type:(VENDORTYPE)type;

@end
*/

@interface NSAssetModel : NSObject
{
    NSMutableDictionary* dictModel;
}
@property (strong, nonatomic) UIImage* image;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSNumber* deltaScore;
@property (strong, nonatomic) NSNumber* totalScore;

//@property (nonatomic, assign) id <ModelDoneDelegate> delegate;
@property (readonly, nonatomic) VENDOR_TYPE vendorType;
@property (readonly, nonatomic) BOOL isAuthed;
@property (readonly, nonatomic) NSString* userID;
@property (readonly, nonatomic) NSString* accessToken;
@property (readonly, nonatomic) NSString* refreshToken;
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
@property (strong, nonatomic) NSNumber* totalScore;
@end