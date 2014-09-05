
//
//  NSIdentityModel.h
//  NextIdentity
//
//  Created by Leon Fu on 9/1/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@protocol ModelDoneDelegate

- (void) modelComplete:(BOOL)result Type:(NETTYPE)type;

@end

@interface NSIdentityList: NSObject
{

}
+ (NSIdentityList*) sharedInstance;
@property (strong, nonatomic) NSMutableArray* identityList;

@end

@interface NSIdentityModel : NSObject
{
    NETTYPE netType;
    NSMutableDictionary* dictModel;
    
}
@property (strong, nonatomic) UIImage* image;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSNumber* deltaScore;
@property (strong, nonatomic) NSNumber* totalScore;

@property (nonatomic, assign) id <ModelDoneDelegate> delegate;

@property (readonly, nonatomic) BOOL isAuthed;
@property (readonly, nonatomic) NSString* userID;
@property (readonly, nonatomic) NSString* accessToken;
@property (readonly, nonatomic) NSString* refreshToken;
@property (readonly, nonatomic) BOOL isExpired;
@property (readonly, nonatomic) NSDictionary* tokens;

- (id) initWithType: (NETTYPE)type Name:(NSString*)name Image:(UIImage*)image;
- (void) addNewKey: (NSString*)key SubKeys: (NSArray*) subKeys;
- (void) addUserTokens: (NSString*)token RefreshToken: (NSString*)rtoken ExpireIn: (NSString*)expire UserID: (NSString*)userId UserNick: (NSString*) userNick;
@end
