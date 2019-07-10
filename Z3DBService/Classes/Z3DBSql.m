    //
    //  Z3DBSql.m
    //  Z3DBService_Example
    //
    //  Created by 童万华 on 2019/6/7.
    //  Copyright © 2019 TonyTong1993. All rights reserved.
    //

#import "Z3DBSql.h"

NSString * const sql_create_location_table = @"CREATE TABLE if not exists location ( \
id INTEGER PRIMARY key,\
latitude DOUBLE,\
longitude DOUBLE,\
x DOUBLE,\
y DOUBLE,\
acu DOUBLE,\
speed FLOAT,\
time varchar(16),\
gpstime varchar(16),\
userid INTEGER,\
status INT\
);";
NSString * const sql_insert_location_table = @"insert into location \
(latitude,longitude,x,y,acu,speed,time,gpstime,userid,status) \
VALUES \
(?,?,?,?,?,?,?,?,?,?);";
NSString * const sql_update_location_table = @"update location SET status = 1 where gpstime == ?";
NSString * const sql_query_location_table = @"SELECT * FROM location WHERE \
STRFTIME('yyyy-MM-dd', gpstime) == STRFTIME('yyyy-MM-dd', ?) \
AND userid == ? \
AND status == ? \
LIMIT ?,?";
