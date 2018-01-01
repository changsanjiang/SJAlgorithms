//
//  TestModel.m
//  环形队列
//
//  Created by 畅三江 on 2018/1/1.
//  Copyright © 2018年 畅三江. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (instancetype)initWithIndex:(NSInteger)index {
    self = [super init];
    if ( !self ) return nil;
    _index = index;
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[TestModel:<%p> index:<%zd>]", self, _index];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}
@end
