//
//  ViewController.m
//  VersionUpdate
//
//  Created by hjbsj on 2018/5/22.
//  Copyright © 2018年 hjb. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "InformationHandleTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //检查版本更新
    [self checkUpdate];
}

- (void)checkUpdate
{
    InformationHandleTool *tool = [InformationHandleTool sharedInfoTool];
    [tool checkUpdateWithAppID:@"968615456" success:^(NSDictionary *result, BOOL isNewVersion, NSString *newVersion) {
        if (isNewVersion) {
            [self showUpdateView:newVersion];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)showUpdateView:(NSString *)newVersion
{
    NSString *alertMsg = [NSString stringWithFormat:@"贷款v%0.1f，赶快体验最新版本吧！",[newVersion floatValue]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:alertMsg preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"稍后再说" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *str = @"https://itunes.apple.com/cn/app/id968615456?mt=8";
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
                
            }];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
