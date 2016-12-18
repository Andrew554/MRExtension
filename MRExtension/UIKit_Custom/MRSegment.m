//
//  MRSegment.m
//  MRChannelSegment
//
//  Created by coderLL on 16/9/16.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "MRSegment.h"
#import "MRButton.h"

@interface MRSegment(){
    NSArray *widthArray;
    NSInteger _allButtonW;
    UIView *_divideView;
    UIView *_divideLineView;
}

@end

@implementation MRSegment

#pragma mark - 自定义构造函数
-(instancetype)initWithFrame:(CGRect)frame isShow:(BOOL)show {
    _showAddButton = show;
    return [self initWithFrame:frame];
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _showAddButton?self.bounds.size.width-40.0:self.bounds.size.width, self.bounds.size.height-0.5)];
        _scrollView.clipsToBounds = YES;
        _scrollView.bounces = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        if (_showAddButton) {
            UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 40.0, 0, 40, _scrollView.frame.size.height)];
            addButton.backgroundColor = [UIColor whiteColor];
            [addButton setImage:[UIImage imageNamed:@"add_blank"] forState:UIControlStateNormal];
            [addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:addButton];
        }
        
        _divideLineView = [[UIView alloc] init];
        _divideLineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_scrollView addSubview:_divideLineView];
        
        _divideView  = [[UIView alloc] init];
        _divideView.backgroundColor = [UIColor redColor];
        [_scrollView addSubview:_divideView];
        
        UIImageView *divideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 0.5)];
        divideImageView.image = [UIImage imageNamed:@"home_schedule_divider"];
        [self addSubview:divideImageView];
        
    }
    
    return self;
}

-(UIFont*)textFont{
    return _textFont?:[UIFont systemFontOfSize:12];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)updateChannels:(NSArray*)array image:(NSArray*)images{
    
    NSMutableArray *widthMutableArray = [NSMutableArray array];
    NSInteger totalW = 0;
    CGFloat buttonW = 1.f;
    NSInteger tempCount = 4;   // 宽度等分的最大个数界限
    
    if(images != nil) { // 有图片
        NSInteger defaultMaxCount = 5;
        buttonW = self.bounds.size.width/(array.count >= defaultMaxCount ? defaultMaxCount : array.count);
    }else { // 仅文字
        if(array.count <= tempCount) {
            buttonW = self.bounds.size.width/array.count;
        }
    }
    
    for (int i = 0; i < array.count; i++) {
        
        NSString *string = [array objectAtIndex:i];
        if(images == nil) { // 仅文字
            if(array.count > tempCount) {   // 如果个数超过4个则按照文字内容动态设置
                // 根据文字长度动态设置
                buttonW = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textFont} context:nil].size.width + 20;
            }
        }
        // =================================
        
        [widthMutableArray addObject:@(buttonW)];
        
        UIButton *button;
        if (images != nil) {
            button = [[MRButton alloc] initWithFrame:CGRectMake(totalW, 0, buttonW, self.bounds.size.height)];
            [button setImage:[UIImage imageNamed:@"ground_ping"] forState:0];
            [button setTitleColor:ColorForBggray forState:UIControlStateNormal];
            [button sd_setImageWithURL:[HttpTool getImageUrlWithName:[images objectAtIndexMR:i]] forState:0];
        }else{
            button.titleLabel.textColor = [UIColor lightTextColor];
            button = [[UIButton alloc] initWithFrame:CGRectMake(totalW, 0, buttonW, self.bounds.size.height)];
        }
        
        button.tag = 1000 + i;
        [button.titleLabel setFont:self.textFont];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitle:string forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickSegmentButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        totalW += buttonW;
        
        if (i == 0) {
            [button setSelected:YES];
            _divideView.frame = CGRectMake(0, _scrollView.bounds.size.height-2, buttonW, 2);
            _selectedIndex = 0;
        }
    }
    
    _allButtonW = totalW;
    _scrollView.contentSize = CGSizeMake(totalW,0);
    widthArray = [widthMutableArray copy];
//    _divideLineView.frame = CGRectMake(0, _scrollView.frame.size.height-0.8, self.width, 0.8);
}

- (void)updateChannels:(NSArray*)array{
    
    [self updateChannels:array image:nil];
    
}

- (void)clickSegmentButton:(UIButton*)selectedButton{
    
    UIButton *oldSelectButton = (UIButton*)[_scrollView viewWithTag:(1000 + _selectedIndex)];
    [oldSelectButton setSelected:NO];
    
    [selectedButton setSelected:YES];
    _selectedIndex = selectedButton.tag - 1000;
    
    NSInteger totalW = 0;
    for (int i=0; i<_selectedIndex; i++) {
        totalW += [[widthArray objectAtIndex:i] integerValue];
    }
    
    //处理边界
    CGFloat selectW = [[widthArray objectAtIndex:_selectedIndex] integerValue];
    CGFloat offset = totalW + (selectW - self.scrollView.bounds.size.width) *0.5 ;
    offset = MIN(_allButtonW - self.scrollView.bounds.size.width, MAX(0, offset));

    [_scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    if ([_delegate respondsToSelector:@selector(MRSegment:didSelectIndex:)]) {
        [_delegate MRSegment:self didSelectIndex:_selectedIndex];
    }
    
    //滑块
    [UIView animateWithDuration:0.1 animations:^{
        _divideView.frame = CGRectMake(totalW, _divideView.frame.origin.y, selectW, _divideView.frame.size.height);
    }];
    
}

- (void)didChengeToIndex:(NSInteger)index{
    UIButton *selectedButton = [_scrollView viewWithTag:(1000 + index)];
    [self clickSegmentButton:selectedButton];
}

- (void)clickAddButton:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(MRSegment:didClickAddButton:)]) {
        [_delegate MRSegment:self didClickAddButton:button];
    }
}

@end
