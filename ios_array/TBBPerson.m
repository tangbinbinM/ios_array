//
//  TBBPerson.m
//  ios_array
//
//  Created by yg on 2017/7/31.
//  Copyright © 2017年 TBB. All rights reserved.
//

#import "TBBPerson.h"

@implementation TBBPerson
- (instancetype)initWithName:(NSString *)name andAge:(NSUInteger)age
{
    if (self = [super init]) {
        _name = name;
        _age = age;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[TBBPerson alloc]initWithName:self.name andAge:self.age];
}

- (BOOL)isEqual:(id)object
{
    if (self == object) return YES;
    if (object == nil) return NO;
    if (![object isKindOfClass:[self class]]) return NO;
    TBBPerson *person = (TBBPerson *)object;
    return [self.name isEqualToString:person.name] && self.age == person.age;
}

- (void)show
{
    NSLog(@"%@,%ld", self.name, self.age);
}

- (NSComparisonResult)compare:(TBBPerson *)person
{
    if (self.age < person.age) {
        return NSOrderedAscending;
    }else if(self.age > person.age){
        return NSOrderedDescending;
    }
    return NSOrderedSame;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%lu", self.name, self.age];
}

@end
