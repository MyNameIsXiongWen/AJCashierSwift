//
//  JZNetWorking.m
//  FirstDemo
//
//  Created by jiazhuo1 on 2018/3/30.
//  Copyright © 2018年 JIAZHUO. All rights reserved.
//

#import "JZNetWorking.h"

@implementation JZNetWorking

static id _instance = nil;

+ (instancetype)sharedInstance {
    static JZNetWorking *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [JZNetWorking manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html",@"text/plain", nil];
        manager.requestSerializer.timeoutInterval = 30;
    });
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (void)monitorInternet {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                // 位置网络
                NSLog(@"未知网络");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                // 无法联网
                NSLog(@"无法联网");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                // WIFI
                NSLog(@"当前在WIFI网络下");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                // 手机自带网络
                NSLog(@"当前使用的是2G/3G/4G网络");
            }
        }
    }];
}

#pragma mark -- GET请求 --
- (void)getWithURLString:(NSString *)URLString
                  method:(NSString *)method
              parameters:(id)parameters
                 success:(void (^)(id))success
                 failure:(void (^)(NSError *))failure {
    
    [[JZNetWorking sharedInstance] GET:[NSString stringWithFormat:@"%@/%@",URLString,method] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- POST请求 --
- (void)postWithURLString:(NSString *)URLString
                   method:(NSString *)method
               parameters:(id)parameters
                  success:(void (^)(id))success
                  failure:(void (^)(NSError *))failure {
    [[JZNetWorking sharedInstance] POST:[NSString stringWithFormat:@"%@/%@",URLString,method] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[JZNetWorking sharedInstance] monitorInternet];
    }];
}

@end
