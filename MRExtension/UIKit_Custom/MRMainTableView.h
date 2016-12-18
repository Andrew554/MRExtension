//
//  MRMainTableView.h
//  QZH
//
//  Created by coderLL on 16/9/17.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MRMainTableView : UITableView

@property(nonatomic,strong)NSMutableArray *dataArray;//数据
@property(nonatomic,weak)UIViewController *vc;//父控制器

@end
