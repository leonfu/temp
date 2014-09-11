//
//  URLRquestHandler.m
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "URLRequestHandler.h"
#import "Utility.h"
#import "NSUserModel.h"

@implementation URLRequestHandler

@synthesize delegate;

- (id) initWithURLStringPOST:(NSString *)url Body:(NSString*) body Topic:(NSInteger) base
{
    topic = base;
   
    urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [urlRequest setHTTPMethod:@"POST"];
    if(body)
    {
        NSData* data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [urlRequest setHTTPBody:data];
    }
    if (topic != TOPIC_USER_LOGON && topic != TOPIC_MOBILE_VERIFY && topic != TOPIC_GET_ACCESS_TOKEN)
        [urlRequest addValue:[NSUserModel sharedInstance].token forHTTPHeaderField:@"AUTHORIZATION"];
    return self;
}

- (id) initWithURLStringGET: (NSString*)url Headers:(NSDictionary*)headers Topic:(NSInteger) base
{
    topic = base;

    urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [urlRequest setHTTPMethod:@"GET"];
    if(headers)
    {
        for (NSString* key in headers.allKeys)
            [urlRequest addValue:headers[key] forHTTPHeaderField:key];
    }
    if (topic != TOPIC_USER_LOGON && topic != TOPIC_MOBILE_VERIFY && topic != TOPIC_GET_ACCESS_TOKEN)
        [urlRequest addValue:[NSUserModel sharedInstance].token forHTTPHeaderField:@"AUTHORIZATION"];
    return self;
}

- (void) startWithCompletion:(responseCompletion)completion
{
    [self start];
    completionBlock = completion;
}

- (void) start
{
    urlConnection=[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    dataResponse = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [dataResponse appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString* str = [[NSString alloc] initWithData:dataResponse encoding:NSUTF8StringEncoding];
    [delegate getResponseResult:statusCode Result:str Topic:topic];
    if (statusCode != 200)
    {
        if(completionBlock)
            completionBlock(NO, str, topic);
        return;
    }
    //status code = 200
    if(completionBlock)
        completionBlock(YES, str, topic);
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [delegate getResponseResult:NO Result: nil Topic:topic];
    if(completionBlock)
        completionBlock(NO, @"网络不给力啊", topic);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    statusCode = httpResponse.statusCode;
    if(statusCode != 200)
    {
        NSLog(@"%@", httpResponse.allHeaderFields.description);
    }
}

@end
