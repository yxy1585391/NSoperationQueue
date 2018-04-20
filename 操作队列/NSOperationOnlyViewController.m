//
//  NSOperationOnlyViewController.m
//  操作队列
//
//  Created by fenggao on 2018/4/20.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "NSOperationOnlyViewController.h"
#import "XMGOperation.h"
#import "XMGThread.h"
@interface NSOperationOnlyViewController ()

@end

@implementation NSOperationOnlyViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //封装操作
    XMGOperation *op = [[XMGOperation alloc] init];
    
    //把操作添加到队列
    [queuea addOperation:op];//内部会调用start方法 start内部会调用main方法
    
    //自定义操作的好处 代码的服用 封装性更好
}

- (void)thread
{
    //自定义线程
    XMGThread *thread = [[XMGThread alloc] init];
    [thread start];
}

- (void)test{
    
    //创建队列
    self.queue = [[NSOperationQueue alloc] init];
    //封装操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"1-----%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"2-----%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"3----%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
        
        NSLog(@"4-----%@",[NSThread currentThread]);
    }];
    
    //设置最大并发数
    queue.maxConcurrentOperationCount =1;
    
    //添加到队列
    [queue addOperations:[op1,op2,op3,op4] waitUntilFinished:YES];
}
@end
