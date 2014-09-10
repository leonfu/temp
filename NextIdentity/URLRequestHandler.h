//
//  URLRquestHandler.h
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TOPIC_GET_ACCESS_TOKEN 0
#define TOPIC_USER_LOGON 1
#define TOPIC_USER_PROFILE 2
#define TOPIC_ASSET_BIND 3
#define TOPIC_ASSET_TODAY 4

NSString* g_token;

typedef void (^responseCompletion) (BOOL isValid, NSString* result, NSInteger topic);

@protocol RequestDelegate

- (void) getResponseResult: (BOOL)isValid Result:(NSString*)result Topic:(NSInteger)topic;

@end

@interface URLRequestHandler : NSObject<NSURLConnectionDelegate>
{
    NSMutableURLRequest* urlRequest;
    NSURLConnection* urlConnection;
    NSMutableData* dataResponse;
    NSInteger statusCode;
    NSInteger topic;
    responseCompletion completionBlock;
}

@property (nonatomic, assign) id <RequestDelegate> delegate;

- (id) initWithURLStringPOST: (NSString*)url Body:(NSString*)body Topic:(NSInteger)base;
- (id) initWithURLStringGET: (NSString*)url Headers:(NSDictionary*)headers Topic:(NSInteger)base;
- (void) start;
- (void) startWithCompletion: (responseCompletion) completion;

@end
