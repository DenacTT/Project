//
//  UIControl+BtnClickDelay.m
//  HBMobileProject
//
//  Created by HarbingWang on 16/9/18.
//  Copyright © 2016年 HarbingWang. All rights reserved.
//
//  分类处理场景: btn按钮延时处理
//  处理方式: 采用 runtime 运行时机制动态添加方法和属性

#import "UIControl+BtnClickDelay.h"
#import <objc/runtime.h>

@implementation UIControl (BtnClickDelay)

-(void)jp_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    if (self.jp_ignoreEvent) return;
    
    if (self.jp_acceptEventInterval > 0) {
        self.jp_ignoreEvent = YES;
        [self performSelector:@selector(setJp_ignoreEvent:) withObject:@(NO) afterDelay:self.jp_acceptEventInterval];
    }
    [self jp_sendAction:action to:target forEvent:event];
}

-(void)setJp_ignoreEvent:(BOOL)jp_ignoreEvent{
    objc_setAssociatedObject(self, @"jp_ignoreEvent", @(jp_ignoreEvent), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)jp_ignoreEvent{
    return [objc_getAssociatedObject(self, @"jp_ignoreEvent") integerValue];
}

-(void)setJp_acceptEventInterval:(NSTimeInterval)jp_acceptEventInterval{
    objc_setAssociatedObject(self, @"jp_acceptEventInterval", @(jp_acceptEventInterval), OBJC_ASSOCIATION_ASSIGN);
}

-(NSTimeInterval)jp_acceptEventInterval{
    return [objc_getAssociatedObject(self, @"jp_acceptEventInterval") doubleValue];
}

+(void)load{
    Method sys_Method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    
    Method add_Method = class_getInstanceMethod(self, @selector(jp_sendAction:to:forEvent:));
    
    method_exchangeImplementations(sys_Method, add_Method);
}

@end

/**********************************************
 
 runtime 运行时机制 它在类信息中被加载,完成所有的方法分发,方法转发等.
 
 1. runtime 动态添加方法和属性
    分类是专门用于添加方法的,在分类里使用关键字 @property 来添加属性的话,系统并不会帮我们生成对应的 setter 和 getter 方法.
    那么,我们想要自己实现这个属性的 setter 和 getter 方法的话,就可以使用 runtime 运行时机制.
    具体来说,就是 在 setter 方法里使用 runtime 的以下方法动态地添加属性
    ```
    void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
    ```
 
    在 getter 方法中使用 runtime 的以下方法动态地获取属性值
    ```
    id objc_getAssociatedObject(id object, const void *key)
    ```
 
 2. 方法交换
    每一个 OC 对象都有一个 isa 指针,这个指针指向创建实例对象的类;
    对象方法保存到类里面,每个类里面都有一个方法列表.当调用对象方法的时候,系统都会来到这个方法列表里面查找对应的方法和实现.所谓的方法交换,就是把两个方法的实现进行交换
    我们知道 UIButton 继承自 UIControl ,UIButton 的所有处理事件的能力都是其父类 UIControl 传递的, UIControl 中有这样一个方法:
    ```
    // send the action. the first method is called for the event and is a point at which you can observe or override behavior. it is called repeately by the second.
    - (void)sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event;
    ```
    这个方法用于传递事件消息,是监听到事件后最先调用的方法,并且它是随着时间的重复产生而频繁调用的.所以我们要拦截事件的传递,重写这个方法是最优解.
    
 3. 分类的使用
    normalBtn不需要有延时，就什么也不用管，就和使用系统原生的一样。
    [self.normalBtn addTarget:self action:@selector(normalBtnClick) forControlEvents:UIControlEventTouchUpInside];
 
    delayBtn需要延时，给它的jp_acceptEventInterval设定一个延时值，它自动就会生效。
    [self.delayBtn addTarget:self action:@selector(delayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.delayBtn.jp_acceptEventInterval = 1.0f;
 
**********************************************/
