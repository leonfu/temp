//
//  URLRquestHandler.h
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import <Foundation/Foundation.h>

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
}
@property (nonatomic, assign) id <RequestDelegate> delegate;

- (id) initWithURLStringPOST: (NSString*)url Body:(NSString*)body Topic:(NSInteger)base;
- (id) initWithURLStringGET: (NSString*)url Headers:(NSDictionary*)headers Topic:(NSInteger)base;
- (void) start;

@end
