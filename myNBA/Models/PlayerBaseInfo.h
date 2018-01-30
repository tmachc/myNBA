//
//  PlayerBaseInfo.h
//  myNBA
//
//  Created by ccwonline on 2018/1/30.
//  Copyright © 2018年 tmachc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerBaseInfo : NSObject

/*
 birthDate = "1993\U5e7401\U670815\U65e5";
 cnName = "\U5361\U8fea\U59c6-\U963f\U4f26";
 draftYear = 2017;
 enName = "Kadeem Allen";
 height = 190cm;
 jerseyNum = 45;
 logo = "https://nba.sports.qq.com/media/img/players/head/260x190/1628443.png";
 position = "\U540e\U536b";
 simpleTeamLogo = "http://mat1.gtimg.com/chinanba/images/nbateamlogo/126x90light/2.png";
 stats =         {
 assists = "0.0";
 blocks = "0.0";
 points = "1.0";
 rebounds = "0.7";
 steals = "0.0";
 };
 teamLogo = "http://mat1.gtimg.com/chinanba/images/nbateamlogo/126x90/2.png";
 teamName = "\U51ef\U5c14\U7279\U4eba";
 weight = "90.7kg";
 */

@property (strong, nonatomic) NSString *cnName;
@property (strong, nonatomic) NSString *enName;
@property (strong, nonatomic) NSString *draftYear;
@property (strong, nonatomic) NSString *birthDate;
@property (strong, nonatomic) NSString *height;
@property (strong, nonatomic) NSString *jerseyNum;
@property (strong, nonatomic) NSString *logo;
@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) NSString *simpleTeamLogo;
@property (strong, nonatomic) NSString *teamLogo;
@property (strong, nonatomic) NSString *teamName;
@property (strong, nonatomic) NSString *weight;
@property (strong, nonatomic) NSDictionary *stats;

@end
