//
//  TestCollectionViewCell.m
//  myNBA
//
//  Created by ccwonline on 2017/12/20.
//  Copyright © 2017年 tmachc. All rights reserved.
//

#import "TestCollectionViewCell.h"

@implementation TestCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CGSize)ccellSize {
    return CGSizeMake(100, 80);
}

@end
