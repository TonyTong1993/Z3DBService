//
//  Z3LocationBeanFactory.h
//  FMDB
//
//  Created by 童万华 on 2019/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CLLocation,Z3LocationBean;
@interface Z3LocationBeanFactory : NSObject
+ (instancetype)factory;
- (Z3LocationBean *)buildLocationBeansWithLatitude:(double)latitude
                                         longitude:(double)longitude
                                                 x:(double)x
                                                 y:(double)y
                                            userid:(NSInteger)userid;
- (Z3LocationBean *)buildLocationBeansWithCLLocation:(CLLocation *)location  userid:(NSInteger)userid;
- (NSArray <Z3LocationBean *> *)buildLocationBeansWithCLLocations:(NSArray <CLLocation *>*)locations  userid:(NSInteger)userid;
- (NSArray <Z3LocationBean *> *)buildLocationBeansWithJSON:(NSString *)json;
- (NSString *)convert2JSONWithLocationBeans:(NSArray <Z3LocationBean *>*)beans;

@end

NS_ASSUME_NONNULL_END
