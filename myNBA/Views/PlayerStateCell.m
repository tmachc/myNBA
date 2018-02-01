//
//  PlayerStateCell.m
//  myNBA
//
//  Created by ccwonline on 2018/2/1.
//  Copyright © 2018年 tmachc. All rights reserved.
//

#define kCellNSNotification_playerStateScroll @"kCellNSNotification_playerStateScroll"

#import "PlayerStateCell.h"

@interface PlayerStateCell() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrView;

@end

@implementation PlayerStateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.scrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, [PlayerStateCell cellHeight])];
        self.scrView.backgroundColor = [UIColor whiteColor];
        self.scrView.bounces = NO;
        self.scrView.showsVerticalScrollIndicator = NO;
        self.scrView.showsHorizontalScrollIndicator = NO;
        self.scrView.delegate = self;
        [self.contentView addSubview:self.scrView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scroll:) name:kCellNSNotification_playerStateScroll object:nil];
    }
    return self;
}

- (void)setState:(NSArray *)ary withFirstWidth:(CGFloat)width
{
    CGFloat w = 60;
    for (int i = 0; i < ary.count; i ++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((i - 1) * w + width, 0, w, [PlayerStateCell cellHeight])];
        lab.text = ary[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = [UIColor blackColor];
        [self.scrView addSubview:lab];
        if (!i) {
            lab.frame = CGRectMake(0, 0, width, [PlayerStateCell cellHeight]);
        }
    }
    [self.scrView setContentSize:CGSizeMake(width + w * (ary.count - 1), [PlayerStateCell cellHeight])];
}

+ (CGFloat)cellHeight
{
    return 40;
}

- (void)scroll:(NSNotification *)notification
{
    if ([notification.userInfo[@"section"] intValue] == self.indexPath.section) {
        [self.scrView setContentOffset:CGPointFromString(notification.object) animated:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kCellNSNotification_playerStateScroll object:NSStringFromCGPoint(scrollView.contentOffset) userInfo:@{@"section": @(self.indexPath.section)}];
}

- (void)dealloc
{
    NSLog(@"PlayerStateCell dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
