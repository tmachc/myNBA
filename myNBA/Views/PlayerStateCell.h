//
//  PlayerStateCell.h
//  myNBA
//
//  Created by ccwonline on 2018/2/1.
//  Copyright © 2018年 tmachc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerStateCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
- (void)setState:(NSArray *)ary withFirstWidth:(CGFloat)width;

+ (CGFloat)cellHeight;

@end
