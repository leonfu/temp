
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

@interface NSIdentityModel : NSObject
{
    NETTYPE netType;
}
@property (nonatomic, assign) id <ModelDoneDelegate> delegate;
@property (strong, nonatomic) NSMutableDictionary* dictModel;
@property (assign, nonatomic) BOOL isAuthed;
@property (readonly, nonatomic) NSString* userID;
@property (readonly, nonatomic) NSString* accessToken;
@property (readonly, nonatomic) NSString* refreshToken;
@property (readonly, nonatomic) BOOL isExpired;
@property (readonly, nonatomic) NSDictionary* userFavorites;
@property (readonly, nonatomic) NSDictionary* userProfile;


- (id) init;
- (void) addNewKey: (NSString*)key SubKeys: (NSArray*) subKeys;

@end
