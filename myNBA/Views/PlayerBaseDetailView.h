//
//  PlayerBaseDetailView.h
//  myNBA
//
//  Created by ccwonline on 2018/1/24.
//  Copyright © 2018年 tmachc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerBaseInfo.h"

@interface PlayerBaseDetailView : UIView

@property (nonatomic, strong) PlayerBaseInfo *pBaseInfo;

+ (CGFloat)baseHeight;
+ (CGFloat)stateHeight;

@end
