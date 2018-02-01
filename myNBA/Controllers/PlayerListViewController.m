//
//  PlayerListViewController.m
//  myNBA
//
//  Created by ccwonline on 2017/11/16.
//  Copyright © 2017年 tmachc. All rights reserved.
//

#import "PlayerListViewController.h"
#import "PlayerListCell.h"
#import "Player.h"
#import "PlayerDetailViewController.h"

@interface PlayerListViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tablePlayer;
@property (strong, nonatomic) NSArray<NSArray *> *arrPlayer;
@property (strong, nonatomic) NSArray<NSString *> *arrCapital;

@end

@implementation PlayerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tablePlayer.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tablePlayer.tableFooterView = [UIView new];
    [self.tablePlayer registerClass:[PlayerListCell class] forCellReuseIdentifier:kCellIdentifier_playerListCell];
    [self getDataFromNet];
}

#pragma mark - net

- (void)getDataFromNet
{
    WS(ws);
    [[HCNetManager defaultManager] getRequestToUrl:@"player/list" params:nil complete:^(BOOL successed, NSDictionary *result) {
        NSLog(@"%@ --> result = %@", successed?@"true":@"false", result);
        if (successed) {
            NSMutableArray *maryAll = [NSMutableArray array];
            NSMutableArray *maryCapital = [NSMutableArray array];
            NSMutableArray *mary = [NSMutableArray array];
            NSString *capital = @"A";
            [maryCapital addObject:capital];
            for (NSDictionary *dic in result[@"data"]) {
                Player *player = [Player yy_modelWithJSON:dic];
                player.playerID = dic[@"id"];
                if ([capital isEqualToString:dic[@"capital"]]) {
                    [mary addObject:player];
                }
                else {
                    [maryAll addObject:[mary copy]];
                    capital = dic[@"capital"];
                    [maryCapital addObject:capital];
                    [mary removeAllObjects];
                    [mary addObject:player];
                }
            }
            [maryAll addObject:[mary copy]];
            ws.arrPlayer = [maryAll copy];
            ws.arrCapital = [maryCapital copy];
            [ws.tablePlayer reloadData];
        }
    }];
}

- (void)processData
{
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[PlayerDetailViewController class]]) {
        ((PlayerDetailViewController *)segue.destinationViewController).playerId = ((Player *)sender).playerID;
    }
}

#pragma mark - table

// 多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrCapital.count;
}

// 全部的索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.arrCapital;
}

// 点击索引跳转哪个section
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.arrCapital indexOfObject:title];
}

// 租标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.arrCapital[section];
}

// 每组数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrPlayer[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_playerListCell forIndexPath:indexPath];
    cell.player = self.arrPlayer[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PlayerListCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    [self performSegueWithIdentifier:@"playerListToDetail" sender:self.arrPlayer[indexPath.section][indexPath.row]];
}

@end
