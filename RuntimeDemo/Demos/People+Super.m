//
//  People+Super.m
//  RuntimeDemo
//
//  Created by yehot on 16/7/3.
//  Copyright © 2016年 yehot. All rights reserved.
//

#import "People+Super.h"
#import <objc/runtime.h>

/**
 
 void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
 
 id objc_getAssociatedObject(id object, const void *key)
 
 
 一般来说，有以下三种推荐的 key 值：
 
 - 声明 static char kAssociatedObjectKey; 
    使用 &kAssociatedObjectKey 作为 key 值;
 - 声明 static void *kAssociatedObjectKey = &kAssociatedObjectKey; 
    使用 kAssociatedObjectKey 作为 key 值；
 - 用 selector ，使用 getter 方法的名称作为 key 值。
 
 */

@implementation People (Super)

#pragma mark - 写法一

static char strKey2;

- (NSString *)chineseName {
    return objc_getAssociatedObject(self, &strKey2);
}

- (void)setChineseName:(NSString *)chineseName {
    objc_setAssociatedObject(self, &strKey2, chineseName, OBJC_ASSOCIATION_COPY);
}

#pragma mark - 写法二

static void *strKey = (void *)@"someKey";

- (NSString *)nickName {
    return objc_getAssociatedObject(self, strKey);
}

- (void)setNickName:(NSString *)nickName {
    objc_setAssociatedObject(self, strKey, nickName, OBJC_ASSOCIATION_COPY);
}

#pragma mark - 写法三

- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, _cmd);
}

@end
