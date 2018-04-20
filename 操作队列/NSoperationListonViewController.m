//
//  NSoperationListonViewController.m
//  操作队列
//
//  Created by fenggao on 2018/4/20.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "NSoperationListonViewController.h"

@interface NSoperationListonViewController ()

@end

@implementation NSoperationListonViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    
    //封装操作对象
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
       
        NSLog(@"1---%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"2---%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"3---%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"4--%@",[NSThread currentThread]);
    }];
    
    NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"5--%@",[NSThread currentThread]);
    }];
   
    //监听任务执行完毕
    op4.completionBlock = ^{
      
        NSLog(@"主人,你的电影已经下载好了.快点来看我吧");
    };
    
    //设置操作依赖 4->3->2->1->5
    [op5 addDependency:op1];
    [op1 addDependency:op2];
    [op2 addDependency:op3];
    [op3 addDependency:op4];
    //设置操作的依赖代码必须在添加队列之前 否则无效
    //警告 不能设置循环依赖
    
    //添加到队列
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    [queue addOperation:op4];
    [queue2 addOperation:op5];
}

@end











