//
//  videoPlayView.m
//  YHVideoList
//
//  Created by 我叫MT on 17/3/10.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import "videoPlayView.h"
//#import <Masonry/Masonry.h>

@interface videoPlayView ()
//播放器
@property(nonatomic, strong)AVPlayer *player;
//播放器图层
@property(nonatomic, assign)AVPlayerLayer *playerLayer;
@property(nonatomic, strong)UIImageView *imageView;//截图
@property(nonatomic, strong)UIView *toolView;//工具栏
@property(nonatomic, strong)UIButton *playOrPauseBtn;//播放暂停
@property(nonatomic, strong)UISlider *progressSlider;//视频进度
@property(nonatomic, strong)UILabel *timeLabel;//时间
@property(nonatomic, strong)UIButton *quanPingBtn;//全屏按钮
//菊花
@property(nonatomic, strong)UIActivityIndicatorView *progressView;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, assign)NSIndexPath *indexPath;


//记录是否显示了工具栏
@property(nonatomic, assign)BOOL isShowToolView;
//定时器
@property(nonatomic, strong)NSTimer *progressTimer;



@end
@implementation videoPlayView



- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}
-(void)creatView
{
    self.player = [[AVPlayer alloc]init];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];

    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    self.toolView = [[UIView alloc]init];
    [self.imageView.layer addSublayer:self.playerLayer];
    [self addSubview:self.toolView];
    self.playOrPauseBtn = [[UIButton alloc]init];
    [self.toolView addSubview:self.playOrPauseBtn];
    self.progressSlider = [[UISlider alloc]init];
    [self.toolView addSubview:self.progressSlider];
    self.timeLabel = [[UILabel alloc]init];
    [self.toolView addSubview:self.timeLabel];
    self.progressView = [[UIActivityIndicatorView alloc]init];
    [self.toolView addSubview:self.progressView];
    self.tableView = [[UITableView alloc]init];
    [self addSubview:self.tableView];
    self.quanPingBtn = [[UIButton alloc]init];
    [self.toolView addSubview:self.quanPingBtn];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    [self.playOrPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
        make.width.height.mas_equalTo(40);
    }];
   
    [self.quanPingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.quanPingBtn.mas_height);
    }];
 
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playOrPauseBtn.mas_right).offset(10);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.progressView.mas_height);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.quanPingBtn.mas_left).offset(10);
        make.centerY.mas_equalTo(self.quanPingBtn.mas_centerY);
    }];
    self.timeLabel.numberOfLines = 1;
    self.timeLabel.lineBreakMode = 0;
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playOrPauseBtn.mas_right);
        make.centerY.mas_equalTo(self.toolView.mas_centerY);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(self.timeLabel.mas_left);
    }];
    self.playOrPauseBtn.backgroundColor = [UIColor yellowColor];
    self.progressSlider.backgroundColor = [UIColor greenColor];
    self.progressView.backgroundColor = [UIColor blueColor];
    self.quanPingBtn.backgroundColor = [UIColor yellowColor];
    
    //暂停播放
    [[self.playOrPauseBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        self.playOrPauseBtn.selected = !self.playOrPauseBtn.selected;
        if (self.playOrPauseBtn.selected) {
            [self.player play];
            [self addProgressTimer];
        }else{
            [self.progressView stopAnimating];
            [self.player pause];
            [self removeProgressTimer];
        }
        
    }];
    
    //是否全屏
    [[self.quanPingBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        self.quanPingBtn.selected = !self.quanPingBtn.selected;
        //切换全屏代理
        if ([self.delegate respondsToSelector:@selector(videoplayViewSwitchOrientation:)]) {
            [self.delegate videoplayViewSwitchOrientation:self.quanPingBtn.selected];
        }
    }];
    //播放进度
    [[self.progressSlider rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        [self addProgressTimer];
        NSTimeInterval currenTime = CMTimeGetSeconds(self.player.currentItem.duration) *self.progressSlider.value;
        //设置当前播放时间
        [self.player seekToTime:CMTimeMakeWithSeconds(currenTime, NSEC_PER_SEC)toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
        [self.player play];
    }];
    
    [[self.progressSlider rac_signalForControlEvents:UIControlEventTouchDown]subscribeNext:^(id x) {
        [ self removeProgressTimer];
    }];
    [[self.progressSlider rac_signalForControlEvents:UIControlEventValueChanged]subscribeNext:^(id x) {
        NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) *self.progressSlider.value;
        NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
        self.timeLabel.text = [self stringWithCurrentTime:currentTime duration:duration];
    }];
//    [self.progressSlider rac_signalForControlEvents:]
    //点击手势是否显示工具的view
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [[tap rac_gestureSignal]subscribeNext:^(id x) {
        
        [UIView animateWithDuration:0.5 animations:^{
            if (self.isShowToolView) {
                self.toolView.alpha = 0;
                self.isShowToolView = NO;
            }else
            {
                self.toolView.alpha = 1;
                self.isShowToolView = YES;
            }
        }];
        
    }];
    [self addGestureRecognizer:tap];
    
    
    self.toolView.alpha = 0;
    self.isShowToolView = NO;
    
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
    [self.progressSlider setMaximumTrackImage:[UIImage imageNamed:@"MaximumTrackImage"] forState:UIControlStateNormal];
    [self.progressSlider setMinimumTrackImage:[UIImage imageNamed:@"MinimumTrackImage"] forState:UIControlStateNormal];
    self.playOrPauseBtn.selected = YES;
    
    [self removeProgressTimer];
    [self addProgressTimer];
    
}

//暂停播放？？？？
-(void)suspendPlayVideo
{
    [self.progressView stopAnimating];
    self.playOrPauseBtn.selected = NO;
    self.toolView.alpha = 1;
    self.isShowToolView = YES;
    [self.player pause];
    [self removeProgressTimer];
}

-(void)dealloc
{
     [self.playeritem removeObserver:self forKeyPath:@"status"];
    [self.player replaceCurrentItemWithPlayerItem:nil];
}
- (void)removeProgressTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}
//定时器操作
-(void)addProgressTimer
{
    self.progressTimer = [NSTimer bk_scheduledTimerWithTimeInterval:1.0 block:^(NSTimer *timer) {
        // 1.更新时间
        self.timeLabel.text = [self timeString];
        
        // 2.设置进度条的value
        self.progressSlider.value = CMTimeGetSeconds(self.player.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
    } repeats:YES];
}
//返回当前时间
-(NSString *)timeString
{
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);
    
    return [self stringWithCurrentTime:currentTime duration:duration];
}
- (NSString *)stringWithCurrentTime:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration
{
    
    NSInteger dMin = duration / 60;
    NSInteger dSec = (NSInteger)duration % 60;
    
    NSInteger cMin = currentTime / 60;
    NSInteger cSec = (NSInteger)currentTime % 60;
    
    dMin = dMin<0?0:dMin;
    dSec = dSec<0?0:dSec;
    cMin = cMin<0?0:cMin;
    cSec = cSec<0?0:cSec;
    
    NSString *durationString = [NSString stringWithFormat:@"%02ld:%02ld", (long)dMin, (long)dSec];
    NSString *currentString = [NSString stringWithFormat:@"%02ld:%02ld", (long)cMin, (long)cSec];
    
    return [NSString stringWithFormat:@"%@/%@", currentString, durationString];
}

//初始化播放器
-(void)setPlayeritem:(AVPlayerItem *)playeritem
{
    _playeritem = playeritem;
    [self.player replaceCurrentItemWithPlayerItem:playeritem];
    [self.playeritem bk_addObserverForKeyPath:@"status" options:NSKeyValueObservingOptionNew task:^(id obj, NSDictionary *change) {
        AVPlayerItem *item = (AVPlayerItem *)obj;
        if (item.status == AVPlayerItemStatusReadyToPlay) {
            [self.progressView stopAnimating];
        }
    }];

    [self.player play];
}

-(void)resetPlayView
{
    [self suspendPlayVideo];
//    [self.playerLayer removeFromSuperlayer];
    [self.player replaceCurrentItemWithPlayerItem:nil];
    self.player = nil;
    [self removeFromSuperview];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
