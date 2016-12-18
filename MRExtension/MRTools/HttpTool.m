//
//  HttpTool.m
//  HXSD
//
//  Created by JackXu on 16/2/26.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "HttpTool.h"
#import "MBProgressHUD.h"

@implementation HttpTool

#pragma mark - Post/Get网络请求
+(void)createAsynchronousRequest:(NSString *)action isPost:(BOOL)isPost parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary *dic))success failure:(void(^)())failure{
    
    NSURL *url = [NSURL URLWithString:HttpURL];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    manager.requestSerializer.timeoutInterval = 10.f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    //打印
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@%@?",url,action];
    NSArray *keyArr = [parameters allKeys];
    for (NSString *key in keyArr) {
        [str appendString:[NSString stringWithFormat:@"%@=%@&",key,parameters[key]]];
    }
    NSRange range = NSMakeRange(str.length-1, 1);
    [str deleteCharactersInRange:range];
    JXLog(@"提交:%@",str);
    
    if (isPost) {
        //Post请求
        [manager POST:action parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure();
            NSLog(@"error: %@, \n error.localizedDescription: %@", error, [error localizedDescription]);
            
        }];
    }else{
        //Get请求
        [manager GET:action parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure();
            NSLog(@"error: %@, \n error.localizedDescription: %@", error, [error localizedDescription]);
        }];
    }
}

#pragma mark - 上传图片
+(void)createUploadImageAsynchronousRequest:(NSString *)action imageData:(NSData *)imageData parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary *dic))success failure:(void(^)())failure {
    
    NSURL *url = [NSURL URLWithString:HttpURL];
    AFHTTPSessionManager *requestManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    requestManager.requestSerializer.HTTPShouldHandleCookies = YES;
    requestManager.requestSerializer.timeoutInterval = 10.f;
    [requestManager.requestSerializer didChangeValueForKey:@"timeroutInterval"];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.png", [self getDateString]];
    [requestManager POST:action parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"uploadImg" fileName:fileName mimeType:@"image/*"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
        NSLog(@"error: %@, \n error.localizedDescription: %@", error, [error localizedDescription]);
    }];
}

#pragma mark - Post网络请求
+(void)createAsynchronousRequest:(NSString *)action parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary *dic))success failure:(void(^)())failure{
    [self createAsynchronousRequest:action isPost:YES parameters:parameters success:success failure:failure];
}

#pragma mark - 根据图片地址获取网络地址
+(NSURL*)getImageUrlWithName:(NSString*)name{
    NSString *urlStr = [NSString stringWithFormat:@"http://quzhihuo.image.alimmdn.com/zhihuo/%@",name];
    return [NSURL URLWithString:urlStr];
}

#pragma mark 获取时间
+ (NSString *)getDateString {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    return [[NSString alloc] initWithFormat:@"%ld", (long)time];
}

@end
