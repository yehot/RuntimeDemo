# RuntimeDemo
runtime 入门系列 demo

---

作为一个有2年以上 iOS 开发经验的程序猿，如果说自己不知道 runtime 简直不好意思跟别人打招呼了。

但是大部分初级 iOS 程序猿在实际项目开发中，很少有机会需要主动用到 runtime 相关的东西。最近面试的不少同学，当我问"请说说你对 iOS 中 runtime 的理解"就懵逼了。

其实作为小面试官，我也是很尴尬的。你简历上期望薪资都写 15k+ 了，那总不能指望面试一个小时，我都只跟你聊如何写界面吧？

---

我觉得当我问面试者：
> "什么是 runtime ?"

这个问题时，如果能在以下三个方面做个简单的阐述，我觉得就基本合格了。

### runtime 是什么？

- 首先 OC 是 C 语言的超集，因为 runtime 这个库使得C语言有了面向对象的能力：
OC 对象可以用C语言中的结构体表示，而方法可以用C函数来实现，这些结构体和函数被 runtime 函数封装后，我们就可以在程序运行时创建，检查，修改类、对象和它们的方法了。

- OC 是一门动态语言，它将很多静态语言在编译和链接时期做的事放到了运行时来处理。
这种特性意味着Objective-C不仅需要一个编译器，还需要一个运行时系统来执行编译的代码。这个运行时系统即Objc Runtime。Objc Runtime基本上是用C和汇编写的。
[参考 南峰子： Objective-C Runtime 运行时之一：类与对象](http://southpeak.github.io/blog/2014/10/25/objective-c-runtime-yun-xing-shi-zhi-lei-yu-dui-xiang/)

### runtime 有什么用？
- 我们写的代码在程序运行过程中都会被转化成 runtime 的C代码执行
  - OC的类、对象、方法在运行时，最终都转换成 C语言的 结构体、函数来执行。
  - 可以在程序运行时创建，检查，修改类、对象和它们的方法。

- 常用于：
  - 获取类的方法列表/参数列表；
  - 方法调用；
  - 方法拦截、动态添加方法；
  - 方法替换： method swizzling
  - 关联对象，动态添加属性；

### runtime 怎么用？

> 或者，说说你具体在项目中哪些地方用到过 runtime ？

- runtime 的 API 提供了大量的函数来操作类和对象，如：
  - 动态替换方法的实现、方法拦截：`class_replaceMethod`
  - 获取对象的属性列表：`class_copyIvarList`
  - 获取对象的方法列表： `class_copyMethodList`
  - 动态添加属性: `class_addProperty`
  - 动态添加方法： `class_addMethod`
  - 获取方法名： `method_getName`
  - 获取方法的实现： `class_getMethodImplementation`

- 具体应用：
  - 给 category 添加属性： 
    `给 UIAlertView 加 block 回调`
  - 给系统的方法做替换，插入代码： 
    `替换 viewDidLoad 方法的实现，NSLog 出每一个出现页面的类名`


[系列博文地址](http://www.jianshu.com/p/d7818dcb21de)


