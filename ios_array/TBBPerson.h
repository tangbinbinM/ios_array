//
//  TBBPerson.h
//  ios_array
//
//  Created by yg on 2017/7/31.
//  Copyright © 2017年 TBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBBPerson : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic)NSUInteger age;

- (instancetype)initWithName:(NSString *)name andAge:(NSUInteger)age;

- (void)show;

- (NSComparisonResult)compare:(TBBPerson *)person;

@end
