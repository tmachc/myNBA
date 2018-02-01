//
//  HCNetManager.m
//  myNBA
//
//  Created by ccwonline on 2017/11/20.
//  Copyright © 2017年 tmachc. All rights reserved.
//

#import "HCNetManager.h"

#define kBaseURLStr @"http://sportsnba.qq.com"
#define kNetworkMethodName @[@"Get", @"Post", @"Put", @"Delete"]

@implementation HCNetManager

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
    
    self.securityPolicy.allowInvalidCertificates = YES;
    
    return self;
}

+ (HCNetManager *)defaultManager
{
    static dispatch_once_t pred = 0;
    __strong static id defaultHttpManager = nil;
    dispatch_once( &pred, ^{
        defaultHttpManager = [[HCNetManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLStr]];
    });
    return defaultHttpManager;
}

- (void)getRequestToUrl:(NSString *)url
                 params:(NSDictionary *)params
               complete:(void (^)(BOOL successed, NSDictionary *result))complete
{
    [self requestToUrl:url method:Get useCache:NO params:params complete:complete];
}

- (void)requestToUrl:(NSString *)url
              method:(HTTPMethod)method
            useCache:(BOOL)useCache
              params:(NSDictionary *)params
            complete:(void (^)(BOOL successed, NSDictionary *result))complete
{
    if (!url || url.length <= 0) {
        return;
    }
    //CSRF - 跨站请求伪造
    NSHTTPCookie *_CSRF = nil;
    for (NSHTTPCookie *tempC in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        if ([tempC.name isEqualToString:@"XSRF-TOKEN"]) {
            _CSRF = tempC;
        }
    }
    if (_CSRF) {
        [self.requestSerializer setValue:_CSRF.value forHTTPHeaderField:@"X-XSRF-TOKEN"];
    }
    
    
    //log请求数据
//    NSLog(@"\n===========request===========\n%@\n%@:\n%@", kNetworkMethodName[method], url, params);
    url = [UrlConfig httpUrl:url];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //    发起请求
    switch (method) {
        case Get:{
            // 所有 Get 请求，增加缓存机制
            NSMutableString *localUrl = [url mutableCopy];
            if (params) {
                [localUrl appendString:params.description];
            }
            [self GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                NSLog(@"\n===========downloadProgress===========\n%@\n%@ -->> \n%@", url, params, downloadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"\n===========response===========\n%@\n%@ -->> \n%@", url, params, responseObject);
                complete(true, responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"\n===========failure===========\n%@\n%@ -->> \n%@", url, params, error);
                complete(false, @{});
            }];
            break;
        }
        default:
            break;
    }
    
}

@end
