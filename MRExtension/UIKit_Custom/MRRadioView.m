//
//  MRRadioView.m
//  QZH
//
//  Created by CodeLL on 2016/11/8.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "UIView+MRExtension.h"
#import "MRRadioView.h"

@interface MRRadioView ()

@property (nonatomic, assign) NSInteger numForColumn;
@property (nonatomic, strong) NSArray *array;

@end

@implementation MRRadioView

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array numsForColumn:(NSInteger)nums {
    MRRadioView *radioView = [self initWithFrame:frame];
    radioView.selectIndex = NSIntegerMin;
    radioView.numForColumn = nums;
    radioView.array = array;
    return radioView;
}

- (void)setArray:(NSArray *)array {
    NSInteger count = array.count;
    CGFloat width = 70;
    CGFloat padding = (self.mr_width - (self.numForColumn * width)) / (self.numForColumn + 1);
    CGFloat margin = 7;
    CGFloat height = self.mr_height - 2*margin;
    for (NSInteger index = 0; index < count; index++) {
        CGFloat x = padding + (padding + width) * (index % self.numForColumn);
        CGFloat y = margin + (margin + height) * (index / 4);
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        btn.frame = CGRectMake(x, y, width, height);
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[array objectAtIndex:index] forState:UIControlStateNormal];
        [self changeNormalState:btn];
        [self addSubview:btn];
    }
}

- (void)clickBtn:(UIButton *)btn {
    NSInteger count = self.subviews.count;
    for (NSInteger index = 0; index < count; index++) {
        UIButton *button = self.subviews[index];
        [self changeNormalState:button];
        if([button isEqual:btn]) {
            self.selectIndex = index;
        }
    }
    btn.backgroundColor = [UIColor redColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)changeNormalState:(UIButton *)btn {
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
