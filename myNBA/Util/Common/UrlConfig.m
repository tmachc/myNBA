//
//  UrlConfig.m
//  myNBA
//
//  Created by ccwonline on 2017/11/20.
//  Copyright © 2017年 tmachc. All rights reserved.
//

#import "UrlConfig.h"
#import <UIKit/UIKit.h>

@implementation UrlConfig

+ (NSString *)httpUrl:(NSString *)url
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    int height = [@([[UIScreen mainScreen] bounds].size.height) intValue];
    int width = [@([[UIScreen mainScreen] bounds].size.width) intValue];
    NSString *model = [[UIDevice currentDevice] model];
    NSString *device = [[UIDevice currentDevice] systemVersion];
    return [NSString stringWithFormat:@"http://sportsnba.qq.com/%@?appver=4.0&appvid=4.0&deviceId=%@&from=app&guid=%@&height=%d&width=%d&network=WiFi&os=%@&osvid=%@&", url, uuidString, uuidString, height, width, model, device];
}

@end
