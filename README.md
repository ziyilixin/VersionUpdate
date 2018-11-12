# VersionUpdate
A VersionUpdate program

屏幕截图
![](https://github.com/ziyilixin/VersionUpdate/blob/master/VersionUpdate/VersionUpdate/Picture/Loan.png?raw=true)

## 检查版本
```objc
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
```

## 提示框
```objc
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
```
