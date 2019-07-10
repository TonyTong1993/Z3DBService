//
//  Z3LocationBean.h
//  Z3DBService_Example
//
//  Created by 童万华 on 2019/6/7.
//  Copyright © 2019 TonyTong1993. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Z3LocationBean : NSObject
@property (nonatomic,assign) NSUInteger RID;
@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) double longitude;
@property (nonatomic,assign) double x;
@property (nonatomic,assign) double y;
@property (nonatomic,assign) double acu;
@property (nonatomic,assign) float speed;
@property (nonatomic,copy)  NSString *time;
@property (nonatomic,copy) NSString *gpstime;
@property (nonatomic,assign) int status;
@property (nonatomic,assign) NSInteger userid;

- (NSDictionary *)toDictionary;
- (NSString *)toJSON;
@end

NS_ASSUME_NONNULL_END
