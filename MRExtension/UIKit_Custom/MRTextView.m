//
//  MRTextView.m
//  QZH
//
//  Created by CodeLL on 2016/11/7.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import "MRTextView.h"

@interface MRTextView ()

@property (nonatomic,weak) UILabel *placeholderLabel;

@end

@implementation MRTextView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

// 初始化布局
- (void)setupUI {
    self.backgroundColor= [UIColor clearColor];
    UILabel *placeholderLabel = [[UILabel alloc] init];//添加一个占位label
    placeholderLabel.backgroundColor = [UIColor clearColor];
    placeholderLabel.numberOfLines = 0; //设置可以输入多行文字时可以自动换行
    [self addSubview:placeholderLabel];
    self.placeholderLabel= placeholderLabel; //赋值保存
    self.myPlaceholderColor= [UIColor lightGrayColor]; //设置占位文字默认颜色
    self.font= [UIFont systemFontOfSize:15]; //设置默认的字体
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self]; //通知:监听文字的改变
}

- (void)setMyPlaceholder:(NSString*)myPlaceholder{
    _myPlaceholder= [myPlaceholder copy];
    //设置文字
    self.placeholderLabel.text = myPlaceholder;
    //重新计算子控件frame
    [self setNeedsLayout];
}

- (void)setMyPlaceholderColor:(UIColor*)myPlaceholderColor{
    _myPlaceholderColor = myPlaceholderColor;
    //设置颜色
    self.placeholderLabel.textColor = myPlaceholderColor;
}

//重写这个set方法保持font一致
- (void)setFont:(UIFont*)font {
    [super setFont:font];   // 必须调用父类的
    self.placeholderLabel.font= font;
    //重新计算子控件frame
    [self setNeedsLayout];
}

- (void)setText:(NSString*)text{
    [super setText:text];
    [self textDidChange]; //这里调用的就文本改变通知的回调
}

- (void)setAttributedText:(NSAttributedString*)attributedText {
    [super setAttributedText:attributedText];
    [self textDidChange]; //这里调用的就文本改变通知的回调
}

#pragma mark -监听文字改变
- (void)textDidChange {
    self.placeholderLabel.hidden = self.hasText;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 计算坐标
    CGFloat x = 8;
    CGFloat y = 8;
    CGFloat width = self.frame.size.width - 2*x;
    // 计算文字高度
    CGFloat height = [self.myPlaceholder boundingRectWithSize:CGSizeMake(self.placeholderLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    
    self.placeholderLabel.frame = CGRectMake(x, y, width, height);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:UITextViewTextDidChangeNotification];
}

@end
