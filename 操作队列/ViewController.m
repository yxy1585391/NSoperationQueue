//
//  ViewController.m
//  操作队列
//
//  Created by fenggao on 2018/4/19.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //GCD队列 并发（自己创建 | 全局并发）串行(自己创建|主队列)
    //操作队列 自定义有队列 | 主队列
    /*自定义队列 [[NSoperationQueue alloc] init]
           特点 默认情况下是并发队列 但是,可以控制让它变成一个串行队列
     主队列  [NSOperationQueue mainQueue]
           特点 串行队列 和主线程相关 (凡是放在主队列中的任务都是在主线程中执行)
     */
}

- (void)invocationOpertaionWithQueue
{
    //1 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //2.封装操作
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download1) object:nil];
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download2) object:nil];
    NSInvocationOperation *op3= [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(download3) object:nil];
    //3.把操作添加到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
    
    //注意 开启几条子线程不是由操作的数量的决定的
}

- (void)download1
{
    NSLog("download1-------%@",[NSThread currentThread]);
}
- (void)download2
{
    NSLog("download2-------%@",[NSThread currentThread]);
}
- (void)download3
{
    NSLog("download3------%@",[NSThread currentThread]);
}

- (void)blockOpertaionWithQueue
{
    //1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //2.封装操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog("1-------%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog("2------%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog("3-------%@",[NSThread currentThread]);
    }];
    [op3 addExecutionBlock:^{
        
    }];
    
    //3 把任务添加到队列
    [queue addOperation:op1];//该方法内部会自动调用start方法
    [queue addOperation:op2];
    [queue addOperation:op3];
    
    //该方法内部首先会把block中的任务封装成一个操作,然后把该操作直接添加到队列
    [queue addOperationWithBlock:^{
        
    }];
}

- (void)changeSerialQueue
{
    //1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //2.封装操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog("1-------%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog("2------%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog("3-------%@",[NSThread currentThread]);
    }];
    
    //设置最大并发数 同一时间最多有多少条线程在执行
    //设置为0 是不能执行任务
    //NSOperationQueueDefaultMaxConcurrentOperationCount =-1 指的是一个最大的值(表示不受限制)
    queue.maxConcurrentOperationCount = 1;//并不代表里面有多少条线程,只是它如何执行
    //设置最大并发数对于任务数量大于1的操作是无效的
    //就是追加任务 addExecutionBlock会使得任务数量大于1
    //当操作中的任务数量>1的时候 会开启多条子线程和当前线程一起工作
    
    //3 把任务添加到队列
    [queue addOperation:op1];//该方法内部会自动调用start方法
    [queue addOperation:op2];
    [queue addOperation:op3];
    

}
@end










