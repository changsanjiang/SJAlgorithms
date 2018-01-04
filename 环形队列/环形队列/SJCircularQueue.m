//
//  SJCircularQueue.m
//  环形队列
//
//  Created by 畅三江 on 2018/1/1.
//  Copyright © 2018年 畅三江. All rights reserved.
//

#import "SJCircularQueue.h"

struct data_recorder {
    unsigned long index;
    void *data;
};

@interface SJCircularQueue ()

@property (nonatomic, assign) struct data_recorder *origin;
@property (nonatomic, assign) struct data_recorder *next;       // tail
@property (nonatomic, assign) struct data_recorder *last;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation SJCircularQueue

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super init];
    if ( !self ) return nil;
    _semaphore = dispatch_semaphore_create(1);
    self.capacity = capacity;
    return self;
}

- (void)dealloc {
    for ( int i = 0 ; i < _capacity ; i ++ ) {
        void *data = _origin[i].data;
        if ( data ) CFRelease(data);
        else break;
    }
    NSLog(@"%s", __func__);
}

#pragma mark -

- (void)setCapacity:(NSUInteger)capacity {
    if ( capacity == _capacity ) return;
    _capacity = capacity;
    
    _origin = calloc(capacity, sizeof(struct data_recorder));
    self.next = _origin;
    self.last = _origin;
    for ( int i = 1 ; i < _capacity ; i ++ ) _origin[i].index = i;
    NSArray *values = [self values];
    [self addObjectsFromArray:values];
}

- (void)addObject:(id)anObject {
    if ( !anObject ) return;
    
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    if ( _next -> data ) {
        CFRelease(_next -> data);
        _next -> data = nil;
    }
    _next -> data = (__bridge_retained void *)anObject;
    self.next = &_origin[ ( _next -> index + 1 ) % _capacity ];
    dispatch_semaphore_signal(_semaphore);
}

- (void)addObjectsFromArray:(NSArray *)otherArray {
    if ( !otherArray ) return;
    if ( _capacity < otherArray.count ) {
        otherArray = [otherArray subarrayWithRange:NSMakeRange(otherArray.count - _capacity, _capacity)];
    }
    [otherArray enumerateObjectsUsingBlock:^(id  _Nonnull anObject, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addObject:anObject];
    }];
}

- (id __nullable)firstObject {
    if ( _next -> data ) return (__bridge id)_next -> data;
    else if ( _origin[0].data ) return (__bridge id)_origin[0].data;
    return nil;
}

- (id)objectAtIndex:(NSUInteger)index {
    if ( index >= _capacity ) return nil;
    if ( _next -> data ) return (__bridge id)_origin[( _next -> index + index ) % _capacity].data;
    else if ( _origin[index].data ) return (__bridge id)_origin[index].data;
    return nil;
}

- (id)lastObject {
    if ( _last -> data ) return (__bridge id)_last -> data;
    return nil;
}


- (NSArray *)values {
    NSMutableArray *valuesM = [NSMutableArray array];
    [valuesM addObjectsFromArray:[self _cursorAfterValues]];
    [valuesM addObjectsFromArray:[self _cursorBeforeValues]];
    return valuesM.copy;
}

#pragma mark -

- (void)setNext:(struct data_recorder *)next {
    _last = _next;
    _next = next;
}

- (NSArray *)_cursorBeforeValues {
    NSMutableArray *valuesM = [NSMutableArray array];
    for ( NSUInteger i = 0 ; i < _next -> index ; i ++ ) {
        struct data_recorder data_r = _origin[i];
        id value = (__bridge id _Nonnull)(data_r.data);
        [valuesM addObject:value];
    }
    return valuesM;
}

- (NSArray *)_cursorAfterValues {
    NSMutableArray *valuesM = [NSMutableArray array];
    for ( NSUInteger i = _next -> index ; i < _capacity ; i ++ ) {
        struct data_recorder data_r = _origin[i];
        id value = (__bridge id _Nonnull)(data_r.data);
        if ( value ) [valuesM addObject:value];
        else break;
    }
    return valuesM;
}

@end
