//
//  UIViewController+Logging.m
//  RuntimeDemo
//
//  Created by yehot on 16/7/2.
//  Copyright © 2016年 yehot. All rights reserved.
//

#import "UIViewController+Logging.h"
#import <objc/runtime.h>
#import "Aspects.h"

@implementation UIViewController (Logging)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class targetClass = [self class];
        SEL originalSelector = @selector(viewDidAppear:);
        SEL swizzledSelector = @selector(swizzled_viewDidAppear:);
        swizzleMethod(targetClass, originalSelector, swizzledSelector);
    });
    
    
    // 或者使用 aspects 实现
    [self aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        NSLog(@"%@ viewDidLoad", [self class]);
    } error:nil];
    
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {

    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    IMP swizzledImp = method_getImplementation(swizzledMethod);
    char *swizzledTypes = (char *)method_getTypeEncoding(swizzledMethod);
    
    IMP originalImp = method_getImplementation(originalMethod);
    
    char *originalTypes = (char *)method_getTypeEncoding(originalMethod);
    /*
     class_addMethod 。要先尝试添加原 selector 是为了做一层保护，因为如果这个类没有实现 originalSelector ，但其父类实现了，那 class_getInstanceMethod 会返回父类的方法。
     这样 method_exchangeImplementations 替换的是父类的那个方法，这当然不是你想要的。
     所以我们先尝试添加 orginalSelector ，如果已经存在，再用 method_exchangeImplementations 把原方法的实现跟新的方法实现给交换掉。
     */
    BOOL success = class_addMethod(class, originalSelector, swizzledImp, swizzledTypes);

    if (success) {
        class_replaceMethod(class, swizzledSelector, originalImp, originalTypes);
    }else {
        // 添加失败，表明已经有这个方法，直接交换
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)swizzled_viewDidAppear:(BOOL)animation {
    [self swizzled_viewDidAppear:animation];
    NSLog(@"%@ viewDidAppear", NSStringFromClass([self class]));
}

@end
