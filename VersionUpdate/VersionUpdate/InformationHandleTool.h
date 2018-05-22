//
//  InformationHandleTool.h
//  VersionUpdate
//
//  Created by hjbsj on 2018/5/22.
//  Copyright © 2018年 hjb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationHandleTool : NSObject

+ (instancetype)sharedInfoTool;

/**
 * 查看版本更新
 */
- (void)checkUpdateWithAppID:(NSString *)appID success:(void (^)(NSDictionary *result,BOOL isNewVersion,NSString *newVersion))success failure:(void (^)(NSError *error))failure;

@end
