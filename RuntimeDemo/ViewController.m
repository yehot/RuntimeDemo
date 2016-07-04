//
//  ViewController.m
//  RuntimeDemo
//
//  Created by yehot on 16/7/2.
//  Copyright © 2016年 yehot. All rights reserved.
//

#import "ViewController.h"

#import <objc/runtime.h>
#import <objc/message.h>

#import "People.h"

#import "Aspects.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    People *p1 = [[People alloc] init];
    [p1 run];       //  People run
    
    [People aspect_hookSelector:@selector(run) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> aspectInfo) {
        
        NSLog(@"People aspect run fast");
    } error:nil];

    [p1 run];       //  People aspect run fast
}

- (void)runFast {
    NSLog(@"People run fast");
}

/**
 *  替换 People 类中 run 方法的实现
 */
- (void)replacePeopleRunMethod {
    
    Class peopleClass = NSClassFromString(@"People");
    
    // SEL : 方法名
    SEL peopleRunSel = @selector(run);
    
    // class_getInstanceMethod : 通过类名 + 方法名 获取一个 Method
    // Method : 包含了一个方法的  方法名 + 实现 + 参数个数及类型 + 返回值个数及类型 等信息
    Method methodRun = class_getInstanceMethod(peopleClass, peopleRunSel);
    // 获取 run 方法的参数 （包括了 parameter and return types）
    char *typeDescription = (char *)method_getTypeEncoding(methodRun);
    
    // 获取 runFast 方法的实现
    // demo 是在当前类直接定义了一个方法，也可以用代码动态生成一个方法
    // class_getMethodImplementation: 类名 + 方法名
    IMP runFastImp = class_getMethodImplementation([self class], @selector(runFast));
    
    // 动态的给 People 新增一个 runFast 方法，并指向的当前类中 runFast 的实现
    // class_addMethod: 类名 + 方法名 + 方法实现 + 参数信息
    class_addMethod(peopleClass, @selector(runFast), runFastImp, typeDescription);
    
    // 替换 run 方法的实现为 runFast 的方法
    // class_replaceMethod : 类型 + 替换的方法名 + 替换后的实现 + 参数信息
    class_replaceMethod(peopleClass, peopleRunSel, runFastImp, typeDescription);
    
}

- (void)test1 {
//    Class peopleClass = NSClassFromString(@"People");
//    
//    // SEL : 方法名
//    SEL peopleRunSel = @selector(run);
//    
//    // Method : 包含一个方法的  方法名 + 实现 + 参数个数及类型 + 返回值个数及类型
//    Method methodRun = class_getInstanceMethod(peopleClass, peopleRunSel);
//
//    // 获取方法的实现
//    // 通过 类名 + 方法名获取
//    IMP impRun = class_getMethodImplementation(peopleClass, peopleRunSel);
//    
//    // 通过 method 获取 方法的实现
//    IMP imp = method_getImplementation(methodRun);
//    // 通过 method 获取 方法名
//    SEL selName = method_getName(methodRun);
}






@end
