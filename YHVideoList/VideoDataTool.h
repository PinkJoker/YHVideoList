//
//  VideoDataTool.h
//  YHVideoList
//
//  Created by 我叫MT on 17/3/9.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VideoModel;
@interface VideoDataTool : NSObject
+(void)videoWithParameters:(VideoModel *)videoParameters success:(void (^)(NSArray *array, NSString *maxtime))success failure:(void (^)(NSError *error))failure;
@end
