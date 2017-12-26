//
//  TestCollectionReusableView.m
//  myNBA
//
//  Created by ccwonline on 2017/12/20.
//  Copyright © 2017年 tmachc. All rights reserved.
//

#import "TestCollectionReusableView.h"

@interface TestCollectionReusableView ()

@property (nonatomic, strong, readwrite) UILabel *textLabel;

@end

@implementation TestCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Create a label
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        textLabel.font = [UIFont systemFontOfSize:17];
        textLabel.textColor = [UIColor blackColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:textLabel];
        self.textLabel = textLabel;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Layout text label
    self.textLabel.frame = CGRectMake(0,
                                      (self.bounds.size.height - 21.0) / 2.0,
                                      self.bounds.size.width,
                                      21.0);
}

@end
