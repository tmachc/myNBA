//
//  Player.h
//  myNBA
//
//  Created by ccwonline on 2017/11/16.
//  Copyright © 2017年 tmachc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

/*
 "id": "1962937741",
 "cnName": "巴姆-阿德巴约",
 "enName": "Adebayo, Bam",
 "capital": "A",
 "teamId": "14",
 "teamName": "热火",
 "teamLogo": "http://mat1.gtimg.com/sports/nba/logo/1602/14.png",
 "teamUrl": "http://sports.qq.com/kbsweb/kbsshare/team.htm?ref=nbaapp&cid=100000&tid=14",
 "jerseyNum": "13",
 "position": "中锋-前锋",
 "birthStateCountry": "",
 "birth": "1997-07-18",
 "height": "208cm",
 "weight": "111kg",
 "icon": "https://nba.sports.qq.com/media/img/players/head/260x190/1628389.png",
 "detailUrl": "http://sports.qq.com/kbsweb/kbsshare/player.htm?ref=nbaapp&pid=1962937741"
 */
@property (strong, nonatomic) NSString *playerID;
@property (strong, nonatomic) NSString *cnName;
@property (strong, nonatomic) NSString *enName;
//@property (strong, nonatomic) NSString *capital;
@property (strong, nonatomic) NSString *teamId;
@property (strong, nonatomic) NSString *teamName;
@property (strong, nonatomic) NSString *teamLogo;
//@property (strong, nonatomic) NSString *teamUrl;
@property (strong, nonatomic) NSString *jerseyNum;
@property (strong, nonatomic) NSString *position;
//@property (strong, nonatomic) NSString *birthStateCountry;
//@property (strong, nonatomic) NSString *birth;
//@property (strong, nonatomic) NSString *height;
//@property (strong, nonatomic) NSString *weight;
@property (strong, nonatomic) NSString *icon;
//@property (strong, nonatomic) NSString *detailUrl;

@end
