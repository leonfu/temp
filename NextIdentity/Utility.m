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

+ (void) removeCurrentUser
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"current_user"];
}

+ (BOOL) saveAssetModel
{
    NSString* userid = [NSUserModel sharedInstance].userid;
    if(userid.length == 0 || [NSAssetList sharedInstance].isEmpty)
        return NO;
    NSString* strFileName = [NSString stringWithFormat:@"%@_asset.plist", userid];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:[NSAssetList sharedInstance]];
    return [data writeToFile:strFileName atomically:YES];
}

+ (BOOL) saveUserModel
{
    NSString* userid = [NSUserModel sharedInstance].userid;
    if(userid.length == 0)
        return NO;
    [[NSUserDefaults standardUserDefaults] setObject:userid forKey:@"current_user"];
    NSString* strFileName = [NSString stringWithFormat:@"%@_user.plist", userid];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:[NSUserModel sharedInstance]];
    return [data writeToFile:strFileName atomically:YES];
}

+ (BOOL) loadUserModel
{
    NSString* userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"current_user"];
    if(userid == nil)
        return NO;
    NSString* strFileName = [NSString stringWithFormat:@"%@_user.plist", userid];
    NSData* data = [NSData dataWithContentsOfFile:strFileName];
    if(data == nil)
        return NO;
    [[NSUserModel sharedInstance] initInstance:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    return YES;
}

+ (BOOL) loadAssetModelList
{
    NSString* strFileName = [NSString stringWithFormat:@"%@_asset.plist", [NSUserModel sharedInstance].userid];
    NSData* data = [NSData dataWithContentsOfFile:strFileName];
    if(data == nil)
        return NO;
    [[NSAssetList sharedInstance] initInstance:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    return YES;
}

@end
