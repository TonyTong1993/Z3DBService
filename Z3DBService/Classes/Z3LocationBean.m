//
//  Z3LocationBean.m
//  Z3DBService_Example
//
//  Created by 童万华 on 2019/6/7.
//  Copyright © 2019 TonyTong1993. All rights reserved.
//

#import "Z3LocationBean.h"

@implementation Z3LocationBean

- (NSString *)toJSON {
    NSError * __autoreleasing error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:[self toDictionary] options:NSJSONWritingPrettyPrinted error:&error];
    NSAssert(!error, @"%@ to json failure",self);
    if (error) {
        return nil;
    }
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return json;
}
//TODO:将时间格式化 抽离

- (NSDictionary *)toDictionary {
    NSDictionary *jsonDic = @{@"lat":@(self.latitude),
                              @"lon":@(self.latitude),
                              @"x":@(self.y),
                              @"y":@(self.x),
                              @"acu":@(self.acu),
                              @"speed":@(self.speed),
                              @"userid":@(self.userid),
                              @"time":self.time,
                              @"status":@(self.status),
                              @"gpstime":self.gpstime,
                              };
    return jsonDic;
}

- (NSString *)description {
    NSMutableString *mstr = [[NSMutableString alloc] init];
            [mstr appendFormat:@"序号:%ld\n",self.RID];
            [mstr appendFormat:@"X坐标:%lf\n",self.x];
            [mstr appendFormat:@"Y坐标:%lf\n",self.y];
            [mstr appendFormat:@"时间:%@\n",self.gpstime];
            [mstr appendFormat:@"纬度:%lf\n",self.latitude];
            [mstr appendFormat:@"经度:%lf\n",self.longitude];
            [mstr appendFormat:@"精度:%lf\n",self.acu];
            [mstr appendFormat:@"状态:%d\n",self.status];
    return [mstr copy];
}
@end
