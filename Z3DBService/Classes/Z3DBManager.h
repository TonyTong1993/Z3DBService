//
//  Z3DBManager.h
//  Z3DBService_Example
//
//  Created by 童万华 on 2019/6/7.
//  Copyright © 2019 TonyTong1993. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class FMDatabaseQueue,Z3LocationBean;
@interface Z3DBManager : NSObject {
    FMDatabaseQueue *_dbQueue;
}
+ (instancetype)manager;
+ (instancetype)new NS_UNAVAILABLE;
-(instancetype)init NS_UNAVAILABLE;


/**
 保存一组位置数据

 @param beans 位置数据
 */
- (void)saveLocationBeans:(NSArray<Z3LocationBean *> *)beans;

/**
 更新上传成功的位置数据

 @param beans   一组位置数据
 */
- (void)updateSyncLocationBeans:(NSArray<Z3LocationBean *> *)beans;

/**

 */


/**
 查询某一天的Location数据

 @param date 查询条件 那一天
 @param index 分页查询 的起始位置
 @param count 分页查询 单次查询数量
 @param userid 当前用户ID
 @param status 是否上传
 @param complication 回调返回查询的位置
 */
- (void)queryLocationBeansSomeDay:(NSDate *)date
                  limitStartIndex:(NSUInteger)index
                       limitCount:(NSUInteger)count
                           userid:(NSInteger)userid
                           status:(int)status
                     complication:(void (^)(NSArray *locations))complication;
@end

NS_ASSUME_NONNULL_END
