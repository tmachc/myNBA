//
//  HCSingleton.h
//  myNBA
//
//  Created by ccwonline on 2018/2/8.
//  Copyright © 2018年 tmachc. All rights reserved.
//

#ifndef HCSingleton_h
#define HCSingleton_h

// .h文件
#define HCSingletonH(name) + (instancetype)shared##name;

// .m文件
#define HCSingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        if (!_instance) { \
            _instance = [[self alloc] init]; \
        } \
    }); \
    return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        if (!_instance) { \
            _instance = [[self alloc] init]; \
        } \
    }); \
    return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
    return _instance; \
}

#endif /* HCSingleton_h */
