//
//  VideoDataTool.m
//  YHVideoList
//
//  Created by 我叫MT on 17/3/9.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import "VideoDataTool.h"
#import "VideoDataModal.h"
#import "VideoModel.h"
#import "RequestTool.h"
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

+(void)videoWithParameters:(VideoModel *)videoParameters success:(void (^)(NSArray *array, NSString *maxtime))success failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(41);
    parameters[@"page"] = @(videoParameters.page);
    if ((videoParameters.maxtime)) {
        parameters[@"maxtime"] = videoParameters.maxtime;
    }
    
//    VideoModel *
    [RequestTool RequstwithGetUrl:nil withParameters:parameters withSuccess:^(id response) {
        NSArray *array = [VideoDataModal mj_objectArrayWithKeyValuesArray:response[@"list"]];
        NSString *maxTime = response[@"info"][@"maxtime"];
        for (VideoDataModal *video in array) {
            video.maxtime = maxTime;
        }
        if (success) {
            success(array,maxTime);
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self addVideoArray:array];
        });
    } withFail:^(id response) {
        videoParameters.recentTime = nil;
        videoParameters.remoteTime = nil;
        NSMutableArray *videoArray = [self selectDataFromCacheWithVideoParameters:videoParameters];
        if (videoArray.count >0) {
            VideoModel *lastVideo = videoArray.lastObject;
            NSString *maxtime = lastVideo.maxtime;
            success(videoArray,maxtime);
        }
        success([videoArray copy],@"");
    }];

    
}

+(NSMutableArray *)selectDataFromCacheWithVideoParameters:(VideoModel *)parameters{
    __block NSMutableArray *videoArray = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        videoArray = [NSMutableArray array];
        FMResultSet *result = nil;
        if (parameters.recentTime) {//时间越大，消息发布越靠后，时间按照真实时刻储存的
            NSInteger time = [[[[parameters.recentTime stringByReplacingOccurrencesOfString:@"-" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@":" withString:@""]integerValue];
            result = [db executeQuery:@"select * from table_video where time > ? order by time desc limit 0,20;", @(time)];
        }
        if (parameters.remoteTime) {
            NSInteger time = [[[[parameters.remoteTime stringByReplacingOccurrencesOfString:@"-" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@":" withString:@""]integerValue];
             result = [db executeQuery:@"select * from table_video where time < ? order by time desc limit 0,20;",@(time)];
        }
        if (parameters.remoteTime == nil && parameters.recentTime == nil) {
              result = [db executeQuery:@"select * from table_video order by time desc limit 0,20;"];
        }
        while (result.next) {
            NSData *data = [result dataForColumn:@"video"];
            VideoModel *video = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [videoArray addObject:video];
        }
    }];
    return videoArray;
}

+(void)addVideoArray:(NSArray *)videoArray
{
    for (VideoDataModal *video in videoArray) {
        [self addVideo:video];
    }
}

+(void)addVideo:(VideoDataModal *)video
{
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *idstr = video.ID;
        FMResultSet *result = nil;
         NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM table_video WHERE idstr = '%@';",idstr];
        result = [db executeQuery:querySql];
        if (result.next == NO) {
            NSString *string = video.created_at;
            NSInteger time = [[[string stringByReplacingOccurrencesOfString:@"-" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@":" withString:@""].integerValue;
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:video];
            //更新数据库数据
            [db executeUpdate:@"insert into table_video (idstr,time,video) values(?,?,?);", idstr, @(time), data];
        }
        [result close];
    }];
}




@end
