//
//  VideoTableViewCell.h
//  YHVideoList
//
//  Created by 我叫MT on 17/3/10.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "videoPlayView.h"

@class VideoDataModal;
@class videoPlayView;

@protocol VideoTableViewCellDelegate <NSObject>

@optional
-(void)clickMoreButton:(VideoDataModal *)video;
-(void)clickVideoButton:(NSIndexPath *)indexPath;
-(void)clickCommentButton:(NSIndexPath *)indexPath;


@end

@interface VideoTableViewCell : UITableViewCell
@property(nonatomic, strong)VideoDataModal *video;
@property(nonatomic, assign)id<VideoTableViewCellDelegate>delegate;
@property(nonatomic, strong)NSIndexPath *indexPath;
@property(nonatomic, strong)videoPlayView *playView;
@property (strong, nonatomic)  UIView *VideoContianerView;
@end
