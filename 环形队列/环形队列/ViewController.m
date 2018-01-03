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

static NSUInteger Capacity = 10;

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
    NSMutableArray *arrayM = [NSMutableArray array];
    for ( int i = 0 ; i < Capacity + 5 ; ++ i ) {
        [arrayM addObject:[[TestModel alloc] initWithIndex:i]];
    }
    
    [queue addObjectsFromArray:arrayM];
    
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
- (IBAction)obj:(id)sender {
    NSLog(@"%@", [queue objectAtIndex:8]);
}

@end
