//
//  PlayerListCell.h
//  myNBA
//
//  Created by ccwonline on 2017/11/16.
//  Copyright © 2017年 tmachc. All rights reserved.
//

#define kCellIdentifier_playerListCell @"playerListCell"

#import <UIKit/UIKit.h>
#import "Player.h"

@interface PlayerListCell : UITableViewCell

@property (nonatomic, strong) Player *player;

+ (CGFloat)cellHeight;

@end
