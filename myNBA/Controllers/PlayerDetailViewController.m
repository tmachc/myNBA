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
#import "PlayerStateInfo.h"
#import "PlayerStateCell.h"

@interface PlayerDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) PlayerBaseDetailView *baseDetail;
@property (nonatomic, strong) UISegmentedControl *segControl;
@property (nonatomic, strong) PlayerStateInfo *pStateInfo;
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
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.tableFooterView = [UIView new];
    self.table.backgroundColor = [UIColor whiteColor];
    self.table.showsVerticalScrollIndicator = NO;
    self.table.showsHorizontalScrollIndicator = NO;
    self.table.bounces = NO;
    self.table.dataSource = self;
    self.table.delegate = self;
    [self.scrollView addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.baseDetail);
        make.top.mas_equalTo(ws.segControl.mas_bottom).offset(5);
        make.height.mas_equalTo(WINDOW_HEIGHT - 64 - [PlayerBaseDetailView stateHeight] - 5 - 5 - ws.segControl.frame.size.height + 1);
        make.bottom.mas_equalTo(ws.scrollView.mas_bottom);
    }];
    NSLog(@" ----->>>>>>>>\n%@\n%@\n%f\n%f", NSStringFromCGRect(self.segControl.frame), NSStringFromCGRect(self.table.frame), WINDOW_HEIGHT - 64 - [PlayerBaseDetailView stateHeight] - 5 - 5 - ws.segControl.frame.size.height, WINDOW_HEIGHT);
    
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
//            if (type == 1) {
//                self.pStateInfo = [PlayerStateInfo yy_modelWithJSON:result[@"data"]];
//            }
//            else {
//
//            }
            self.pStateInfo = [PlayerStateInfo yy_modelWithJSON:result[@"data"]];
            [self.table reloadData];
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

#pragma mark - table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segControl.selectedSegmentIndex == 0) {
        if (self.pStateInfo.stats) {
            if (section == 0) {
                return [self.pStateInfo.stats[@"rows"] count] + 1;
            }
            else {
                return [self.pStateInfo.lastMatches[@"rows"] count] + 1;
            }
        }
    }
    else {
        if (self.pStateInfo.playoff) {
            if (section == 0) {
                return [self.pStateInfo.playoff[@"rows"] count] + 1;
            }
            else {
                return [self.pStateInfo.reg[@"rows"] count] + 1;
            }
        }
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 36)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, WINDOW_WIDTH - 20, 22)];
    lab.textColor = [UIColor grayColor];
    lab.font = [UIFont systemFontOfSize:13];
    lab.textAlignment = NSTextAlignmentLeft;
    if (self.segControl.selectedSegmentIndex == 0) {
        lab.text = section ? @"最近5场" : @"本赛季平均";
    }
    else {
        lab.text = section ? @"常规赛" : @"季后赛";
    }
    [view addSubview:lab];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerStateCell *cell = [[PlayerStateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld", (long)indexPath.section]];
    cell.indexPath = indexPath;
    NSDictionary *dic;
    CGFloat width = 0.0;
    if (self.segControl.selectedSegmentIndex == 0) {
        if (self.pStateInfo.stats) {
            if (indexPath.section == 0) {
                dic = self.pStateInfo.stats;
                width = 80;
            }
            else {
                dic = self.pStateInfo.lastMatches;
                width = 140;
            }
        }
    }
    else {
        if (self.pStateInfo.playoff) {
            if (indexPath.section == 0) {
                dic = self.pStateInfo.playoff;
                width = 80;
            }
            else {
                dic = self.pStateInfo.reg;
                width = 80;
            }
        }
    }
    if (dic) {
        if (indexPath.row) {
            // row
            [cell setState:dic[@"rows"][indexPath.row - 1] withFirstWidth:width];
        }
        else {
            // head
            [cell setState:dic[@"head"] withFirstWidth:width];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PlayerStateCell cellHeight];
}

@end
