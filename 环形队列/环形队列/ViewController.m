//
//  ViewController.m
//  环形队列
//
//  Created by 畅三江 on 2018/1/1.
//  Copyright © 2018年 畅三江. All rights reserved.
//

#import "ViewController.h"
#import "SJCircularQueue.h"
#import "TestModel.h"

static NSUInteger Capacity = 1000000;

@interface ViewController ()

@end

@implementation ViewController {
    SJCircularQueue *queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    queue = [[SJCircularQueue alloc] initWithCapacity:Capacity];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)add:(id)sender {
    
    NSLog(@"begin");
    
    for ( int i = 0 ; i < Capacity ; ++ i ) {
        [queue addObject:[[TestModel alloc] initWithIndex:i]];
    }
    
    NSLog(@"end");
}

- (IBAction)get:(id)sender {
    NSLog(@"%@", [queue values]);
}
- (IBAction)getLast:(id)sender {
    NSLog(@"%@", [queue lastObject]);
}
- (IBAction)nill:(id)sender {
    queue = nil;
}

@end
