//
//  PlayerListCell.m
//  myNBA
//
//  Created by ccwonline on 2017/11/16.
//  Copyright © 2017年 tmachc. All rights reserved.
//

#import "PlayerListCell.h"

@interface PlayerListCell ()

@property (nonatomic, strong) UIView *viewContent;
@property (nonatomic, strong) UILabel *labPlayerCNName;
@property (nonatomic, strong) UILabel *labPlayerENName;
@property (nonatomic, strong) UILabel *labTeamName;
@property (nonatomic, strong) UILabel *labPositionAndNum;
@property (nonatomic, strong) UIImageView *imgPlayer;
@property (nonatomic, strong) UIImageView *imgTeam;

@end

@implementation PlayerListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!_viewContent) {
            _viewContent = [[UIView alloc] init];
            _viewContent.backgroundColor = [UIColor whiteColor];
            [self.contentView addSubview:_viewContent];
            [_viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.mas_equalTo(@0);
                make.right.mas_equalTo(@(-5));
                make.bottom.mas_equalTo(@(-5));
            }];
        }
        if (!_labPlayerCNName) {
            _labPlayerCNName = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 320, 25)];
            _labPlayerCNName.font = [UIFont boldSystemFontOfSize:20];
            [_viewContent addSubview:_labPlayerCNName];
        }
        if (!_labPlayerENName) {
            _labPlayerENName = [[UILabel alloc] initWithFrame:CGRectMake(10, 38, 320, 15)];
            _labPlayerENName.font = [UIFont systemFontOfSize:12];
            _labPlayerENName.textColor = [UIColor grayColor];
            [_viewContent addSubview:_labPlayerENName];
        }
        if (!_labTeamName) {
            _labTeamName = [[UILabel alloc] initWithFrame:CGRectMake(10, 68, 320, 16)];
            _labTeamName.font = [UIFont boldSystemFontOfSize:14];
            [_viewContent addSubview:_labTeamName];
        }
        if (!_labPositionAndNum) {
            _labPositionAndNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 320, 15)];
            _labPositionAndNum.font = [UIFont systemFontOfSize:12];
            _labPositionAndNum.textColor = [UIColor grayColor];
            [_viewContent addSubview:_labPositionAndNum];
        }
        if (!_imgPlayer) {
            _imgPlayer = [[UIImageView alloc] init];
            _imgPlayer.contentMode = UIViewContentModeScaleAspectFit;
            [_viewContent addSubview:_imgPlayer];
            [_imgPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(@15);
                make.right.mas_equalTo(@(-15));
                make.bottom.mas_equalTo(@0);
                make.width.mas_equalTo(_imgPlayer.mas_height).multipliedBy(26.0/19.0);
            }];
        }
        if (!_imgTeam) {
            _imgTeam = [[UIImageView alloc] init];
            [_viewContent addSubview:_imgTeam];
            [_imgTeam mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(@10);
                make.right.mas_equalTo(@(-8));
                make.width.height.mas_equalTo(@30);
            }];
        }
    }
    return self;
}

- (void)setPlayer:(Player *)player
{
    _player = player;
    _labPlayerCNName.text = player.cnName;
    _labPlayerENName.text = player.enName;
    _labTeamName.text = player.teamName;
    _labPositionAndNum.text = [NSString stringWithFormat:@"%@ ∙ #%@", player.position, player.jerseyNum];
    [_imgPlayer sd_setImageWithURL:[NSURL URLWithString:player.icon]];
    [_imgTeam sd_setImageWithURL:[NSURL URLWithString:player.teamLogo]];
}

+ (CGFloat)cellHeight
{
    return 113;
}

@end
