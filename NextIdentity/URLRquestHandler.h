//
//  URLRquestHandler.h
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RequestDelegate

- (void) getResponseResult: (NSString*)result;

@end

@interface URLRquestHandler : NSObject<NSURLConnectionDelegate>
{
    NSMutableURLRequest* urlRequest;
    NSURLConnection* urlConnection;
    NSMutableData* dataResponse;
}
@property (nonatomic, assign) id <RequestDelegate> delegate;

- (id) initWithURLString: (NSString*)url Body:(NSString*)body;

- (void) start;

@end
