//
//  Z3LocationBeanFactory.m
//  FMDB
//
//  Created by 童万华 on 2019/6/7.
//

#import "Z3LocationBeanFactory.h"
#import <CoreLocation/CLLocation.h>
#import "Z3LocationBean.h"
#import "Z3MobileConfig.h"
#import "CoorTranUtil.h"
@implementation Z3LocationBeanFactory
+ (instancetype)factory {
    return [[Z3LocationBeanFactory alloc] init];
}

 static NSString * const DATE_FORMAT = @"yyyy-MM-dd HH:mm:ss.SSS";
- (Z3LocationBean *)buildLocationBeansWithLatitude:(double)latitude
                                         longitude:(double)longitude
                                                 x:(double)x
                                                 y:(double)y
                                            userid:(NSInteger)userid{
    Z3LocationBean *bean = [[Z3LocationBean alloc] init];
    bean.latitude = latitude;
    bean.longitude = longitude;
    bean.acu = 50;
    bean.speed = 6;
    bean.x = x;
    bean.y = y;
    bean.status = 0;
   
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = DATE_FORMAT;
    bean.time = [df stringFromDate:[NSDate date]];
    bean.gpstime = [df stringFromDate:[NSDate date]];
    bean.userid = userid;
    return bean;
}

- (Z3LocationBean *)buildLocationBeansWithCLLocation:(CLLocation *)location
                                              userid:(NSInteger)userid {
    NSParameterAssert(location);
    Z3LocationBean *bean = [[Z3LocationBean alloc] init];
    CLLocationCoordinate2D coordinate2d = location.coordinate;
    bean.latitude = coordinate2d.latitude;
    bean.longitude = coordinate2d.longitude;
    bean.acu = location.horizontalAccuracy;
    bean.speed = location.speed;
    CoorTranUtil *coorTrans = [Z3MobileConfig shareConfig].coorTrans;
    CGPoint point = [coorTrans CoorTrans:coordinate2d.latitude lon:coordinate2d.longitude height:0];
    bean.x = point.x;
    bean.y = point.y;
    bean.status = 0;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = DATE_FORMAT;
    bean.time = [df stringFromDate:[NSDate date]];
    bean.gpstime = [df stringFromDate:location.timestamp];
    bean.userid = userid;
    return bean;
}

- (NSArray<Z3LocationBean *> *)buildLocationBeansWithCLLocations:(NSArray<CLLocation *> *)locations  userid:(NSInteger)userid {
    NSMutableArray *beans = [NSMutableArray arrayWithCapacity:locations.count];
    for (CLLocation *location in locations) {
            Z3LocationBean *bean = [self buildLocationBeansWithCLLocation:location userid:userid];
            [beans addObject:bean];
    }
    return beans;
}

- (NSString *)convert2JSONWithLocationBeans:(NSArray<Z3LocationBean *> *)beans {
    NSMutableArray *jsonArray = [NSMutableArray arrayWithCapacity:beans.count];
    for (Z3LocationBean *bean in beans) {
        [jsonArray addObject:[bean toDictionary]];
    }
    NSDictionary *jsonDic = @{@"pos":[jsonArray copy]};
    //FIXME: Memory leaks
    NSError * __autoreleasing error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:&error];
    NSAssert(!error, @"convert2 JSON failure");
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return json;
}

- (NSArray<Z3LocationBean *> *)buildLocationBeansWithJSON:(NSString *)json {
    
    return nil;
}

@end
