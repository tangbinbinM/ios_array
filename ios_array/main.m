//
//  main.m
//  ios_array
//
//  Created by yg on 2017/7/31.
//  Copyright © 2017年 TBB. All rights reserved.
//

#import <Foundation/Foundation.h>
//创建数组NSArray对象
void test1()
{
    //1. 字面值方式
    NSArray *arr1 = @[@"aaa", @"bbb", @"ccc"];
    //2. 工厂方法创建,最后一人元素必须是nil
    NSArray *arr2 = [NSArray arrayWithObjects:@"aaa", @"bbb", @"ccc", @"ddd", nil];
    NSString *strs[4] = {@"aaa", @"bbb", @"ccc", @"ddd"};
    NSArray *arr3 = [NSArray arrayWithObjects:strs count:4];
    NSLog(@"%@,%@,%@", arr1, arr2, arr3);
}

//遍历数组
void test2()
{
    //数组中只能放对象(对象的引用),不能放非对象类型(C语言中的基本类型,结构体等),数组中的每个元素是id类型的引用
    NSArray *arr = @[@"aaa", @"bbb", @"ccc", @"ddd"];
    NSLog(@"%@", arr);
    //1. 使用数组下标的方式进行遍历
    for(int i=0; i<arr.count; i++){
        NSString *str = arr[i];
        NSLog(@"%@", str);
        if(i == 2)break;
    }
    //2. 使用forin loop循环的方式进行遍历
    for(NSString *str in arr){
        NSLog(@"%@", str);
        //if (不需要遍历了)break;
    }
    //3. 使用Block进行遍历
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"下标为%lu的元素是%@", idx, obj);
        if(idx == 2)*stop = YES;
    }];
    //4. 使用迭代器来遍历
    NSEnumerator *enumerator = [arr objectEnumerator];//获取迭代器
    NSString *obj = nil;
    while(obj = [enumerator nextObject]){ //通过迭代器拿数组中的一个对象
        NSLog(@"%@", obj);//对获得的对象进行处理
    }
}

//数组的拷贝
void test3()
{
    NSArray *arr1 = @[@"aaa", @"bbb", @"ccc"];
    NSArray *arr2 = arr1;
    //arr1[0] = @"AAA";//不可变,改不了
    //浅拷贝
    NSArray *arr3 = [[NSArray alloc]initWithArray:arr1 copyItems:NO];
    //深拷贝
    NSArray *arr4 = [[NSArray alloc]initWithArray:arr1 copyItems:YES];
    
}
//测试浅拷贝和深拷贝的区别
#import "TBBPerson.h"
void test4()
{
    TBBPerson *p1 = [[TBBPerson alloc]initWithName:@"张三" andAge:30];
    TBBPerson *p2 = [[TBBPerson alloc]initWithName:@"李四" andAge:23];
    TBBPerson *p3 = [[TBBPerson alloc]initWithName:@"王小二" andAge:19];
    NSArray *persons = @[p1, p2, p3];
    //浅拷贝
    NSArray *persons2 = [[NSArray alloc]initWithArray:persons copyItems:NO];
    if(persons[0] == persons2[0]){
        NSLog(@"这是同一个对象");
    }
    [persons[0] setAge:35];//persons[0].age = 35;
    NSLog(@"%ld", [persons2[0] age]);
    
    //深拷贝
    NSArray *persons3 = [[NSArray alloc]initWithArray:persons copyItems:YES];
    for (TBBPerson *p in persons) {
        NSLog(@"%p", p);
    }
    NSLog(@"===============");
    for (TBBPerson *p in persons2) {
        NSLog(@"%p", p);
    }
    NSLog(@"===============");
    for (TBBPerson *p in persons3) {
        NSLog(@"%p", p);
    }
}

//常用方法
void test5()
{
    NSArray *arr = @[@"aaa", @"bbb", @"ccc", @"ddd"];
    NSString *str = [[NSString alloc]initWithFormat:@"%@",@"bbb"];
    NSLog(@"arr[1]:%p,str:%p", arr[1], str);
    //判断数组中是否包含指定的对象,通过isEqual方法来判断的,而不是地址
    if([arr containsObject:str]){
        NSLog(@"数组中有这个对象");
    }
    
    TBBPerson *p1 = [[TBBPerson alloc]initWithName:@"张三" andAge:30];
    TBBPerson *p2 = [[TBBPerson alloc]initWithName:@"李四" andAge:23];
    TBBPerson *p3 = [[TBBPerson alloc]initWithName:@"王小二" andAge:19];
    NSArray *persons = @[p1, p2, p3];
    TBBPerson *p4 = [[TBBPerson alloc]initWithName:@"王小二" andAge:19];
    //当调用[p3 isEqual:p4]时结果为YES,说明数组中有王小二这个人
    if ([persons containsObject:p4]) {
        NSLog(@"数组中有王小二");
    }
    NSLog(@"==============");
    //从数组中查找对象,返回其下标,比较的是内容(isEqual:)
    NSInteger index = [persons indexOfObject:p4];
    if (index == NSNotFound) {
        NSLog(@"没有王小二");
    }else{
        NSLog(@"王小二在下标%ld的位置", index);
    }
    NSLog(@"==============");
    //下面方法比较的是地址(没有使用isEqual:方法)
    index = [persons indexOfObjectIdenticalTo:p3];
    if (index == NSNotFound) {
        NSLog(@"数组中没有这个对象");
    }else{
        NSLog(@"对象的下标是:%ld", index);
    }
    
    //向数组中的每一个对象发消息
    [persons makeObjectsPerformSelector:@selector(show)];
    //相当于以下代码
    /*
     for (TRPerson *p in persons) {
     [p show];
     }
     */
}

//其他方法
void test6()
{
    NSArray *arr = @[@"aaa", @"bbb", @"ccc", @"ddd"];
    arr = [arr arrayByAddingObject:@"eee"];
    NSLog(@"%@", arr);
}



//数组排序
NSInteger sortRule(id obj1, id obj2, void *p)
{
    //NSLog(@"sortRule");
    NSString *str1 = obj1;
    NSString *str2 = obj2;
    return [str1 compare:str2];
}
void test7()
{
    NSArray *arr = @[@"aaa",  @"ccc", @"bbb", @"ccc"];
    NSArray *sortedArr = [arr sortedArrayUsingFunction:sortRule context:nil];
    NSLog(@"%@", sortedArr);
    
    arr = @[@"aaa",  @"ccc", @"bbb", @"ccc"];
    //调用字符串类中的compare:方法进行比较大小运算
    sortedArr = [arr sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"%@", sortedArr);
}

//对自己定义的对象进行排序
NSInteger personSortRule(id obj1, id obj2, void*p)
{
    TBBPerson *person1 = obj1;
    TBBPerson *person2 = obj2;
    if(person1.age < person2.age) return -1;
    else if(person1.age > person2.age) return 1;
    return 0;
}
void test8()
{
    TBBPerson *p1 = [[TBBPerson alloc]initWithName:@"张三" andAge:30];
    TBBPerson *p2 = [[TBBPerson alloc]initWithName:@"李四" andAge:23];
    TBBPerson *p3 = [[TBBPerson alloc]initWithName:@"王小二" andAge:26];
    NSArray *persons = @[p1, p2, p3];
    //要求按年龄进行排序
    NSArray *sortedPersons = [persons sortedArrayUsingFunction:personSortRule context:nil];
    //NSLog(@"%@", sortedPersons);
    for (TBBPerson *person in sortedPersons) {
        NSLog(@"%@", person);
    }
    
    persons = @[p1, p2, p3];
    sortedPersons = [persons sortedArrayUsingSelector:@selector(compare:)];
    for (TBBPerson *person in sortedPersons) {
        NSLog(@"%@", person);
    }
    
    //使用Block进行排序
    sortedPersons = [persons sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        TBBPerson *p1 = obj1;
        TBBPerson *p2 = obj2;
        if(p1.age < p2.age) return NSOrderedAscending;
        else if(p1.age > p2.age) return NSOrderedDescending;
        return NSOrderedSame;
    }];
}
/*
 可变数组
 */
void test9(){
    NSMutableArray *muarr = [[NSMutableArray alloc] init];
    [muarr addObject:@"23"];
    [muarr addObject:@"45"];
    [muarr addObject:@"67"];
    //指定初始容量，开发不常用
    NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:1024];
    
    muarr[0] = @"AAA";
    [muarr sortUsingSelector:@selector(compare:)];//倒序
    NSLog(@"%@", muarr);
}

//不可变和可变的转换
void test10()
{
    NSArray *arr = @[@"aaa", @"bbb", @"ccc"];
    //arr[0] = @"AAA";
    //[arr addObject:@"ddd"];
    //不可变==>可变
    NSMutableArray *mArr = [arr mutableCopy];
    mArr[0] = @"AAA";
    //可变 ==> 不可变
    NSArray *arr2 = [mArr copy];
    NSLog(@"%@", arr2);
    
    NSString *str1 = @"Hello";
    NSMutableString *mStr1 = [str1 mutableCopy];
    [mStr1 appendString:@" World!"];
    NSString *str2 = [mStr1 copy];
    NSLog(@"%@", str2);
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test10();
    }
    return 0;
}
