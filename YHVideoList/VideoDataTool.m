//
//  VideoDataTool.m
//  YHVideoList
//
//  Created by 我叫MT on 17/3/9.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import "VideoDataTool.h"
#import "VideoDataModal.h"
//#import <FMDB/FMDB.h>
//#import <FMDB/FMDatabaseQueue.h>
@implementation VideoDataTool
static FMDatabaseQueue *_queue;
static NSString *const apikey = @"8b72ce2839d6eea0869b4c2c60d2a449";
//创建数据库
+(void)initialize {
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"data.sqlite"];
    //    NSLog(@"%@",path);
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
     
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists table_video(id integer primary key autoincrement, idstr text, time integer, video blob);"];
        
        [db executeUpdate:@"create table if not exists table_picture(id integer primary key autoincrement, idstr text, time integer, picture blob);"];
        
        [db executeUpdate:@"create table if not exists table_ttheadernews(id integer primary key autoincrement, title text, url text, desc text, picUrl text, ctime text);"];
        
        [db executeUpdate:@"create table if not exists table_normalnews(id integer primary key autoincrement, channelid text, title text, imageurls blob, desc text, link text, pubdate text, createdtime integer, source text);"];
        [db executeUpdate:@"create table if not exists table_videocomment(id integer primary key autoincrement, idstr text, page integer, hotcommentarray blob, latestcommentarray blob, total integer);"];
    }];
}

+(void)videoWithParameters:(VideoDataModal *)videoParameters success:(void (^)(NSArray *)array, NSString *maxtime))success failure:(void (^)(NSError *error))failure
{
    
}





@end
