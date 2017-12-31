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

static NSUInteger Capacity = 5;

@interface ViewController ()

@end

@implementation ViewController {
    SJCircularQueue *queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    queue = [[SJCircularQueue alloc] initWithCapacity:Capacity];
    
    NSLog(@"%@", queue);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)add:(id)sender {
    [queue addObject:[TestModel new]];
}

- (IBAction)get:(id)sender {
    NSLog(@"%@", [queue values]);
}
- (IBAction)getLast:(id)sender {
    NSLog(@"%@", [queue lastObject]);
}

@end
