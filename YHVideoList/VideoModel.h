//
//  VideoModel.h
//  YHVideoList
//
//  Created by 我叫MT on 17/3/9.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
@property(nonatomic, copy)NSString *recentTime;//开始时间
@property(nonatomic, copy)NSString *remoteTime;//结束时间;
@property(nonatomic, copy)NSString *maxtime;
@property(nonatomic, assign)NSInteger page;
@end
