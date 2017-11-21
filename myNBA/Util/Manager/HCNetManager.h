//
//  HCNetManager.h
//  myNBA
//
//  Created by ccwonline on 2017/11/20.
//  Copyright © 2017年 tmachc. All rights reserved.
//

#import "AFNetworking.h"
#import "UrlConfig.h"

typedef NS_ENUM(NSUInteger, HTTPMethod) {
    Get = 0,
    Post
};

@interface HCNetManager : AFHTTPSessionManager

+ (HCNetManager *)defaultManager;

- (void)getRequestToUrl:(NSString *)url
                 params:(NSDictionary *)params
               complete:(void (^)(BOOL successed, NSDictionary *result))complete;

@end
