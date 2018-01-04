//
//  SJCircularQueue.h
//  环形队列
//
//  Created by 畅三江 on 2018/1/1.
//  Copyright © 2018年 畅三江. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 环形队列.
@interface SJCircularQueue : NSObject

- (instancetype)initWithCapacity:(NSUInteger)capacity;

@property (nonatomic, assign) NSUInteger capacity;

- (void)addObject:(id)anObject;
- (void)addObjectsFromArray:(NSArray *)otherArray;
- (id __nullable)firstObject;
- (id __nullable)objectAtIndex:(NSUInteger)index;
- (id __nullable)lastObject;
- (NSArray *)values;

@end

NS_ASSUME_NONNULL_END
