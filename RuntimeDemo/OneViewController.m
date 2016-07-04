//
//  OneViewController.m
//  RuntimeDemo
//
//  Created by yehot on 16/7/3.
//  Copyright © 2016年 yehot. All rights reserved.
//

#import "OneViewController.h"
#import "People+Super.h"

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    People *p1 = [People new];
    
    p1.name = @"lisi";
    p1.chineseName = @"李四";
    p1.nickName = @"麻子";
    
    NSLog(@"%@   %@   %@", p1.name, p1.nickName, p1.chineseName);
    
}

@end
