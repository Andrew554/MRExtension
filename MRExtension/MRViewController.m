//
//  MRViewController.m
//  MRExtension
//
//  Created by SinObjectC on 16/5/23.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "MRViewController.h"
#import "UIView+MRExtension.h"

@interface MRViewController ()

@end

@implementation MRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[@"1ff", @"fdsf", @"fdsfsd"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"a"] = @"aa";
    
    dic[@"bb"] = @"bbb";
    
    dic[@"ccc"] = array;
    
    dic[@"dd"] = @(1);
    
    NSLog(@"%@", dic);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
