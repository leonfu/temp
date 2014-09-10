//
//  Utility.m
//  DigitalAssets
//
//  Created by Leon Fu on 9/10/14.
//  Copyright (c) 2014 iShanghai Creative. All rights reserved.
//

#import "Utility.h"

@implementation Utility


+ (id) getObjectFromJSON:(NSString *)json
{
  return [NSJSONSerialization JSONObjectWithData: [json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
}

+ (NSString*) getJSONFromObject: (id) object
{
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
}

+ (void) showErrorMessage:(NSString *)json
{
    NSDictionary* dict = [Utility getObjectFromJSON:json];
    NSString* str = dict[@"message"];
    if(dict == nil)
        str = json;
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"出错啦" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

@end
