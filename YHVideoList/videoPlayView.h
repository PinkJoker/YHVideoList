//
//  videoPlayView.h
//  YHVideoList
//
//  Created by 我叫MT on 17/3/10.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface videoPlayView : UIView

@property(nonatomic, strong)AVPlayerItem *playeritem;
@property(nonatomic, strong)RACSubject *subjectDelegate;
-(void)suspendPlayVideo;
-(void)resetPlayView;
@end
