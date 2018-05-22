//
//  InformationHandleTool.m
//  VersionUpdate
//
//  Created by hjbsj on 2018/5/22.
//  Copyright © 2018年 hjb. All rights reserved.
//

#import "InformationHandleTool.h"
#import <AFNetworking.h>

@implementation InformationHandleTool

+ (instancetype)sharedInfoTool
{
    static InformationHandleTool *infoTool;
    @synchronized(self) {
        if (!infoTool)
            infoTool = [[self alloc] init];
    }
    return infoTool;
}

/**
 * 查看版本更新
 */
- (void)checkUpdateWithAppID:(NSString *)appID success:(void (^)(NSDictionary *result,BOOL isNewVersion,NSString *newVersion))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *encodingUrl = [[NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",appID] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:encodingUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *versionStr = [[[resultDict objectForKey:@"results"] objectAtIndex:0] valueForKey:@"version"];
        float version = [versionStr floatValue];
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        float currentversion = [[infoDic valueForKey:@"CFBundleShortVersionString"] floatValue];
        if (version > currentversion) {
            success(resultDict,YES,versionStr);
        }
        else {
            success(resultDict,NO,versionStr);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
