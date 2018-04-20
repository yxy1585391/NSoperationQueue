//
//  XMGOperation.m
//  操作队列
//
//  Created by fenggao on 2018/4/20.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "XMGOperation.h"

@implementation XMGOperation

//重写内部main方法 告诉自定义操作的的任务是什么
- (void)main
{
    NSLog(@"main------%@",[NSThread currentThread]);
    
    for (int i =0; i < 10000; ++i) {
        NSLog(@"1------%zd--------%@",i,[NSThread currentThread]);
    }
    //官方建议 在自定义操作的时候每执行完一个耗时操作就判断一下当前操作是否被取消.如果被取消就直接返回
    if (self.isCancelled) {
        return;
    }
    NSLog(@"++++++++++++++++++++++++");
    
    for (int i =0; i < 10000; ++i) {
        NSLog(@"2------%zd--------%@",i,[NSThread currentThread]);
    }
    
    if (self.isCancelled) {
        return;
    }

    for (int i =0; i < 10000; ++i) {
        NSLog(@"3------%zd--------%@",i,[NSThread currentThread]);
    }
}
@end
