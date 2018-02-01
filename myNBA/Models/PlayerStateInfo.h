//
//  PlayerStateInfo.h
//  myNBA
//
//  Created by ccwonline on 2018/2/1.
//  Copyright © 2018年 tmachc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerStateInfo : NSObject

@property (nonatomic, strong) NSDictionary *playoff;
@property (nonatomic, strong) NSDictionary *stats;
@property (nonatomic, strong) NSDictionary *lastMatches; // 最近五场
@property (nonatomic, strong) NSDictionary *reg; // 本赛季平均

@end
