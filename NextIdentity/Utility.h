//
//  Utility.h
//  DigitalAssets
//
//  Created by Leon Fu on 9/10/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (id) getObjectFromJSON:(NSString *)json;
+ (NSString*) getJSONFromObject: (id) object;
+ (void) showErrorMessage: (NSString *)json;
@end
