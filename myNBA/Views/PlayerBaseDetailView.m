//
//  PlayerBaseDetailView.m
//  myNBA
//
//  Created by ccwonline on 2018/1/24.
//  Copyright © 2018年 tmachc. All rights reserved.
//

#import "PlayerBaseDetailView.h"

@interface PlayerBaseDetailView()

@property (nonatomic, strong) UIImageView *imgPlayer;
@property (nonatomic, strong) UILabel *labPlayerNum;
@property (nonatomic, strong) UILabel *labPlayerInfo;
@property (nonatomic, strong) UILabel *labPlayerDate;
@property (nonatomic, strong) UIView *stateView;
@property (nonatomic, strong) UILabel *labStatePoints;
@property (nonatomic, strong) UILabel *labStateRebounds;
@property (nonatomic, strong) UILabel *labStateAssists;
@property (nonatomic, strong) UILabel *labStateSteals;
@property (nonatomic, strong) UILabel *labStateBlocks;

@end

@implementation PlayerBaseDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = MainColor;
        _imgPlayer = [[UIImageView alloc] init];
        _imgPlayer.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgPlayer];
        [_imgPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(@5);
            make.left.mas_equalTo(@(5));
            make.height.mas_equalTo(@([PlayerBaseDetailView baseHeight] - 5));
            make.width.mas_equalTo(_imgPlayer.mas_height).multipliedBy(26.0/19.0);
        }];
        
        _labPlayerNum = ({
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, WINDOW_WIDTH - 10, 35)];
            lab.textAlignment = NSTextAlignmentRight;
            lab.textColor = [UIColor whiteColor];
            lab.font = [UIFont boldSystemFontOfSize:30];
            lab;
        });
        [self addSubview:_labPlayerNum];
        
        _labPlayerInfo = ({
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, _labPlayerNum.frame.origin.y + _labPlayerNum.frame.size.height + 7, WINDOW_WIDTH - 10, 14)];
            lab.textAlignment = NSTextAlignmentRight;
            lab.textColor = [UIColor whiteColor];
            lab.font = [UIFont boldSystemFontOfSize:11];
            lab;
        });
        [self addSubview:_labPlayerInfo];
        
        _labPlayerDate = ({
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, _labPlayerInfo.frame.origin.y + _labPlayerInfo.frame.size.height + 7, WINDOW_WIDTH - 10, 14)];
            lab.textAlignment = NSTextAlignmentRight;
            lab.textColor = [UIColor whiteColor];
            lab.font = [UIFont boldSystemFontOfSize:11];
            lab;
        });
        [self addSubview:_labPlayerDate];
        
        _stateView = [[UIView alloc] initWithFrame:CGRectMake(0, [PlayerBaseDetailView baseHeight], WINDOW_WIDTH, [PlayerBaseDetailView stateHeight])];
        _stateView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_stateView];
        
        CGFloat width = WINDOW_WIDTH/5;
        _labStatePoints = ({
            UILabel *lab = [[UILabel alloc] init];
            [self setStateLabel:lab];
            lab;
        });
        [_stateView addSubview:_labStatePoints];
        [_labStatePoints mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@0);
            make.top.mas_equalTo(@3);
            make.height.mas_equalTo(@35);
            make.width.mas_equalTo(width);
        }];
        
        _labStateRebounds = ({
            UILabel *lab = [[UILabel alloc] init];
            [self setStateLabel:lab];
            lab;
        });
        [_stateView addSubview:_labStateRebounds];
        [_labStateRebounds mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(_labStatePoints);
            make.left.mas_equalTo(_labStatePoints.mas_right);
            make.width.mas_equalTo(width);
        }];
        
        _labStateAssists = ({
            UILabel *lab = [[UILabel alloc] init];
            [self setStateLabel:lab];
            lab;
        });
        [_stateView addSubview:_labStateAssists];
        [_labStateAssists mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(_labStateRebounds);
            make.left.mas_equalTo(_labStateRebounds.mas_right);
            make.width.mas_equalTo(width);
        }];
        
        _labStateSteals = ({
            UILabel *lab = [[UILabel alloc] init];
            [self setStateLabel:lab];
            lab;
        });
        [_stateView addSubview:_labStateSteals];
        [_labStateSteals mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(_labStateAssists);
            make.left.mas_equalTo(_labStateAssists.mas_right);
            make.width.mas_equalTo(width);
        }];
        
        _labStateBlocks = ({
            UILabel *lab = [[UILabel alloc] init];
            [self setStateLabel:lab];
            lab;
        });
        [_stateView addSubview:_labStateBlocks];
        [_labStateBlocks mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(_labStateSteals);
            make.left.mas_equalTo(_labStateSteals.mas_right);
            make.width.mas_equalTo(width);
        }];
        
        NSArray *nameAry = @[@"场均得分", @"场均篮板", @"场均助攻", @"场均抢断", @"场均盖帽"];
        for (int i = 0; i < nameAry.count; i ++) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(i * width, [PlayerBaseDetailView stateHeight]/2 + 5, width, 20)];
            lab.text = nameAry[i];
            lab.textColor = [UIColor grayColor];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = [UIFont systemFontOfSize:12];
            [_stateView addSubview:lab];
        }
    }
    return self;
}

- (void)setStateLabel:(UILabel *)lab
{
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont boldSystemFontOfSize:25];
}

- (void)setPBaseInfo:(PlayerBaseInfo *)pBaseInfo
{
    _pBaseInfo = pBaseInfo;
    [_imgPlayer sd_setImageWithURL:[NSURL URLWithString:pBaseInfo.logo]];
    _labPlayerNum.text = [NSString stringWithFormat:@"#%@", pBaseInfo.jerseyNum];
    _labPlayerInfo.text = [NSString stringWithFormat:@"%@ %@ %@ %@", pBaseInfo.teamName, pBaseInfo.position, pBaseInfo.height, pBaseInfo.weight];
    _labPlayerDate.text = [NSString stringWithFormat:@"生日:%@ 选秀:%@年", pBaseInfo.birthDate, pBaseInfo.draftYear];
    _labStatePoints.text = pBaseInfo.stats[@"points"];
    _labStateRebounds.text = pBaseInfo.stats[@"rebounds"];
    _labStateAssists.text = pBaseInfo.stats[@"assists"];
    _labStateSteals.text = pBaseInfo.stats[@"steals"];
    _labStateBlocks.text = pBaseInfo.stats[@"blocks"];
}

+ (CGFloat)baseHeight
{
    return 100;
}

+ (CGFloat)stateHeight
{
    return 60;
}

@end
