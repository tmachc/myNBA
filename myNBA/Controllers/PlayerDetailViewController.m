//
//  PlayerDetailViewController.m
//  myNBA
//
//  Created by ccwonline on 2017/11/21.
//  Copyright © 2017年 tmachc. All rights reserved.
//

#import "PlayerDetailViewController.h"
#import "PlayerBaseDetailView.h"
#import "PlayerBaseInfo.h"

@interface PlayerDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) PlayerBaseDetailView *baseDetail;
@property (nonatomic, strong) UISegmentedControl *segControl;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UILabel *labPlayerCName;
@property (nonatomic, strong) UILabel *labPlayerEName;
@property (nonatomic, strong) UIImageView *imgTeamLogo;

@end

@implementation PlayerDetailViewController

- (UILabel *)labPlayerCName
{
    if (!_labPlayerCName) {
        _labPlayerCName = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, WINDOW_WIDTH, 24)];
        _labPlayerCName.textAlignment = NSTextAlignmentCenter;
        _labPlayerCName.textColor = [UIColor whiteColor];
        _labPlayerCName.font = [UIFont systemFontOfSize:18];
    }
    return _labPlayerCName;
}

- (UILabel *)labPlayerEName
{
    if (!_labPlayerEName) {
        _labPlayerEName = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, WINDOW_WIDTH, 22)];
        _labPlayerEName.textAlignment = NSTextAlignmentCenter;
        _labPlayerEName.textColor = [UIColor grayColor];
        _labPlayerEName.font = [UIFont systemFontOfSize:10];
    }
    return _labPlayerEName;
}

- (UIImageView *)imgTeamLogo
{
    if (!_imgTeamLogo) {
        _imgTeamLogo = [[UIImageView alloc] initWithFrame:CGRectMake(WINDOW_WIDTH - 42 - 10, 6, 42, 30)];
    }
    return _imgTeamLogo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // /player/baseInfo?appver=4.1&appvid=4.1&deviceId=bea3b78ae172482cb1055658897c18d2&from=app&guid=bea3b78ae172482cb1055658897c18d2&height=736&network=WiFi&os=iphone&osvid=11.2.2&playerId=4305&width=414
    // /player/stats?appver=4.1&appvid=4.1&deviceId=bea3b78ae172482cb1055658897c18d2&from=app&guid=bea3b78ae172482cb1055658897c18d2&height=736&network=WiFi&os=iphone&osvid=11.2.2&playerId=4305&tabType=1&width=414
    WS(ws);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT - 64)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    self.baseDetail = [[PlayerBaseDetailView alloc] init];
    [self.scrollView addSubview:self.baseDetail];
    [self.baseDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.width.mas_equalTo(WINDOW_WIDTH);
        make.height.mas_equalTo(@([PlayerBaseDetailView baseHeight] + [PlayerBaseDetailView stateHeight]));
    }];
    NSLog(@"self.baseDetail -->> %@", self.baseDetail.backgroundColor);
    
    self.segControl = [[UISegmentedControl alloc] initWithItems:@[@"赛季数据", @"生涯数据"]];
    self.segControl.selectedSegmentIndex = 0;
    [self.segControl addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:self.segControl];
    [self.segControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.baseDetail.mas_centerX);
        make.top.mas_equalTo(ws.baseDetail.mas_bottom).offset(5);
    }];
    
    self.table = [[UITableView alloc] init];
    self.table.backgroundColor = [UIColor greenColor];
    [self.scrollView addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.baseDetail);
        make.top.mas_equalTo(ws.segControl.mas_bottom).offset(5);
        make.height.mas_equalTo(WINDOW_HEIGHT - 64 - [PlayerBaseDetailView stateHeight] - 5 - 5 - ws.segControl.frame.size.height);
        make.bottom.mas_equalTo(ws.scrollView.mas_bottom);
    }];
    
    [self getDetailData];
    [self getStateDataWithType:1];
}

- (IBAction)changeState:(UISegmentedControl *)sender
{
    [self getStateDataWithType:(int)self.segControl.selectedSegmentIndex + 1];
}

- (void)getDetailData
{
    [[HCNetManager manager] getRequestToUrl:@"player/baseInfo" params:@{@"playerId": self.playerId} complete:^(BOOL successed, NSDictionary *result) {
        if (successed) {
            PlayerBaseInfo *pBaseInfo = [PlayerBaseInfo yy_modelWithJSON:result[@"data"]];
            self.baseDetail.pBaseInfo = pBaseInfo;
            self.labPlayerCName.text = pBaseInfo.cnName;
            self.labPlayerEName.text = pBaseInfo.enName;
            [self.imgTeamLogo sd_setImageWithURL:[NSURL URLWithString:pBaseInfo.simpleTeamLogo]];
        }
    }];
}

- (void)getStateDataWithType:(int)type
{
    [[HCNetManager manager] getRequestToUrl:@"player/stats" params:@{@"playerId": self.playerId, @"tabType": @(type)} complete:^(BOOL successed, NSDictionary *result) {
        if (successed) {
            
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.labPlayerCName];
    [self.navigationController.navigationBar addSubview:self.labPlayerEName];
    [self.navigationController.navigationBar addSubview:self.imgTeamLogo];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.labPlayerCName removeFromSuperview];
    [self.labPlayerEName removeFromSuperview];
    [self.imgTeamLogo removeFromSuperview];
}

@end
