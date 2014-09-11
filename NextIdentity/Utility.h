//
//  Utility.h
//  DigitalAssets
//
//  Created by Leon Fu on 9/10/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSUserModel.h"
#import "NSAssetModel.h"

@class NSAssetList;

@interface Utility : NSObject

+ (id) getObjectFromJSON:(NSString *)json;
+ (NSString*) getJSONFromObject: (id) object;
+ (void) showErrorMessage: (NSString *)json;
+ (void) removeCurrentUser;
+ (BOOL) saveUserModel;
+ (BOOL) saveAssetModel;

+ (BOOL) loadUserModel;
+ (BOOL) loadAssetModelList;
@end
