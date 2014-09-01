//
//  URLRquestHandler.m
//  NextIdentity
//
//  Created by Leon on 14-8-31.
//  Copyright (c) 2014年 iShanghai Creative. All rights reserved.
//

#import "URLRquestHandler.h"

@implementation URLRquestHandler

@synthesize delegate;


- (id) initWithURLString:(NSString *)url Body:(NSString*) body
{
    
    NSData* data = [body dataUsingEncoding:NSUTF8StringEncoding];
    urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:data];
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
    [delegate getResponseResult:str];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [delegate getResponseResult:nil];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int statusCode = httpResponse.statusCode;
    if(statusCode != 200)
    {
        [connection cancel];
        [delegate getResponseResult:nil];
    }
}

@end
