//
//  VideoDataModal.h
//  YHVideoList
//
//  Created by 我叫MT on 17/3/9.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHVideoComment;
@interface VideoDataModal : NSObject<NSCoding>
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *love;
@property (nonatomic, copy) NSString *cai;
@property (nonatomic, copy) NSString *repost;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSString *image0;
@property (nonatomic, copy) NSString *image1;
@property (nonatomic, copy) NSString *image2;
@property (nonatomic, copy) NSString *playcount;
@property (nonatomic, copy) NSString *videotime;
@property (nonatomic, copy) NSString *videouri;

@property (nonatomic, strong) YHVideoComment *top_cmt;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect videoFrame;


@end
