//
//  Z3DBManager.m
//  Z3DBService_Example
//
//  Created by 童万华 on 2019/6/7.
//  Copyright © 2019 TonyTong1993. All rights reserved.
//

#import "Z3DBManager.h"
#import <fmdb/FMDB.h>
#import "Z3DBSql.h"
#import "Z3LocationBean.h"
@implementation Z3DBManager
+ (instancetype)manager {
    static Z3DBManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
       NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbPath = [documentPath stringByAppendingPathComponent:@"com.zzht.db"];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            [db executeUpdate:sql_create_location_table];
        }];
    }
    return self;
}

- (void)saveLocationBeans:(NSArray<Z3LocationBean *> *)beans {
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        for (Z3LocationBean *bean in beans) {
           BOOL result = [db executeUpdate:sql_insert_location_table withArgumentsInArray:@[@(bean.latitude),@(bean.longitude),@(bean.x),@(bean.y),@(bean.acu),@(bean.speed),bean.time,bean.gpstime,@(bean.userid),@(bean.status)]];
                NSAssert(result, @"data insert failure");
        }
    }];
}

- (void)updateSyncLocationBeans:(NSArray<Z3LocationBean *> *)beans {
    [_dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        for (Z3LocationBean *bean in beans) {
            BOOL res = [db executeUpdate:sql_update_location_table,bean.gpstime];
            if (!res) {
                NSLog(@"update failure");
                *rollback = YES;
            }else {
                
            }
        }
    }];
}

static NSString * const DATE_FORMAT = @"yyyy-MM-dd HH:mm:ss";
- (void)queryLocationBeansSomeDay:(NSDate *)date
                  limitStartIndex:(NSUInteger)index
                       limitCount:(NSUInteger)count
                           userid:(NSInteger)userid
                           status:(int)status
                     complication:(void (^)(NSArray *locations))complication {
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = DATE_FORMAT;
        NSString *targetDate = [df stringFromDate:date];
       FMResultSet *rs = [db executeQuery:sql_query_location_table,targetDate,@(userid),@(status),@(index),@(count)];
        NSMutableArray *beans = [NSMutableArray array];
        while (rs.next) {
            Z3LocationBean *bean =[[Z3LocationBean alloc] init];
            bean.RID = [rs intForColumn:@"id"];
            bean.latitude = [rs doubleForColumn:@"latitude"];
            bean.longitude = [rs doubleForColumn:@"longitude"];
            bean.x =[rs doubleForColumn:@"x"];
            bean.y = [rs doubleForColumn:@"y"];
            bean.acu =[rs doubleForColumn:@"acu"];
            bean.speed =[rs doubleForColumn:@"speed"];
            bean.time =[rs stringForColumn:@"time"];
            bean.gpstime =[rs stringForColumn:@"gpstime"];
            bean.userid =[rs intForColumn:@"userid"];
            bean.status = [rs intForColumn:@"status"];
            [beans addObject: bean];
        }
        complication(beans);
    }];
    
}

@end
