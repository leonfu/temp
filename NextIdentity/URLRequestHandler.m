//
//  URLRquestHandler.m
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "URLRequestHandler.h"

@implementation URLRequestHandler

@synthesize delegate;


- (id) initWithURLStringPOST:(NSString *)url Body:(NSString*) body Topic:(NSInteger) base
{
    topic = base;

    NSData* data = [body dataUsingEncoding:NSUTF8StringEncoding];
    urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:data];
    return self;
}

- (id) initWithURLStringGET: (NSString*)url Headers:(NSDictionary*)headers Topic:(NSInteger) base
{
    topic = base;

    urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [urlRequest setHTTPMethod:@"GET"];
    for (NSString* key in headers.allKeys)
        [urlRequest addValue:headers[key] forHTTPHeaderField:key];
    return self;
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
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [delegate getResponseResult:NO Result: nil Topic:topic];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    statusCode = httpResponse.statusCode;
    if(statusCode != 200)
        NSLog(@"%@", httpResponse.allHeaderFields.description);
}

@end
