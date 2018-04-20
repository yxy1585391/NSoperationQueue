//
//  NSOperationViewController.m
//  操作队列
//
//  Created by fenggao on 2018/4/20.
//  Copyright © 2018年 com.zhonglu. All rights reserved.
//

#import "NSOperationViewController.h"

@interface NSOperationViewController ()
@property (nonatomic,strong)NSOperationQueue *queue;
@end

@implementation NSOperationViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
}

//开始
- (void)startBtnClick(id)sender
{
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
//暂停
- (void)suspendBtnClick(id)sender
{
    //只能暂停当前操作后面的操作.当前操作不可分割 必须执行完毕
    [self.queue setSuspended:YES];
}
//恢复
- (void)resumeBtnClick(id)sender
{
    [self.queue setSuspended:NO];
}
//取消
- (void)cancelBtnClick(id)sender
{
    //只能取消队列中处于等待状态的操作
    [self.queue cancelAllOperations];
}
@end














