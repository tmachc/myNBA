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

@interface PlayerListViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tablePlayer;
@property (strong, nonatomic) NSArray<Player *> *arrPlayer;

@end

@implementation PlayerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDataFromNet];
}

#pragma mark - net

- (void)getDataFromNet
{
    [[HCNetManager defaultManager] getRequestToUrl:@"player/list" params:nil complete:^(BOOL successed, NSDictionary *result) {
        NSLog(@"%@ --> result = %@", successed?@"true":@"false", result);
        if (successed) {
            NSMutableArray *mary = [NSMutableArray array];
            for (NSDictionary *dic in result[@"data"]) {
                Player *player = [Player yy_modelWithJSON:dic];
                [mary addObject:player];
            }
            self.arrPlayer = [mary copy];
            [self.tablePlayer reloadData];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrPlayer.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_playerListCell forIndexPath:indexPath];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    [self performSegueWithIdentifier:@"playerListToDetail" sender:nil];
}

@end
