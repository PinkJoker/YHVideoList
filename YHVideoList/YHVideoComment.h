//
//  YHVideoComment.h
//  YHVideoList
//
//  Created by 我叫MT on 17/3/21.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHVideoUser.h"
@interface YHVideoComment : NSObject

@property(nonatomic, copy)NSString *ID;//评论标识
@property(nonatomic, copy)NSString *voiceUrl;//音频连接
@property(nonatomic, assign)NSInteger voiceTime;//音频时长
@property(nonatomic, copy)NSString *content;//评论内容
@property(nonatomic, assign)NSInteger like_count;//点赞数量
@property(nonatomic, strong)YHVideoUser *user;//用户
@end
