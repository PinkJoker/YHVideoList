//
//  VideoTableViewCell.m
//  YHVideoList
//
//  Created by 我叫MT on 17/3/10.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "VideoDataModal.h"
#import "YHVideoComment.h"
#import "videoPlayView.h"
@interface VideoTableViewCell ()
{
    UIView *bottomView;
    CGFloat contentHeight;
}
@property (strong, nonatomic)  UIImageView *headerImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *createdTimeLabel;
@property (strong, nonatomic)  UIButton *AddFriendsButton;
@property (strong, nonatomic)  UIButton *loveButton;
@property (strong, nonatomic)  UIButton *hatebutton;
@property (strong, nonatomic)  UIButton *repostButton;
@property (strong, nonatomic)  UIButton *commentButton;
@property (strong, nonatomic)  UILabel *contentLabel;
@property (strong, nonatomic)  UIImageView *vipImageView;
@property (strong, nonatomic)  UILabel *topCommentTopLabel;
@property (strong, nonatomic)  UIImageView *videoImageView;
@property (strong, nonatomic)  UILabel *playCountLabel;
@property (strong, nonatomic)  UILabel *timelabel;
@property (strong, nonatomic)  UILabel *topCommentLabel;


@property (strong, nonatomic)  UIView *separatorLine1;
@property (strong, nonatomic)  UIView *separatorLine2;
@property (strong, nonatomic)  UIView *separatorLine3;
@property (strong, nonatomic)  UIView *separatorLine4;
@end
@implementation VideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         [self creatView];
    }
    return self;
}

-(void)creatView
{
    self.headerImageView = [[UIImageView alloc]init];
    self.nameLabel = [[UILabel alloc]init];
    self.createdTimeLabel = [[UILabel alloc]init];
    self.AddFriendsButton = [[UIButton alloc]init];
    self.contentLabel = [[UILabel alloc]init];
    self.vipImageView = [[UIImageView alloc]init];
    self.topCommentTopLabel = [[UILabel alloc]init];
    self.topCommentLabel = [[UILabel alloc]init];
    self.VideoContianerView = [[UIView alloc]init];
      UIButton *playBtn = [[UIButton alloc]init];
    self.videoImageView = [[UIImageView alloc]init];
    self.timelabel = [[UILabel alloc]init];
    self.playCountLabel = [[UILabel alloc]init];
  
   bottomView = [[UIView alloc]init];
    NSArray *views = @[self.headerImageView,self.nameLabel,self.createdTimeLabel,self.contentLabel,self.VideoContianerView,bottomView,self.AddFriendsButton];
    [self.contentView sd_addSubviews:views];
    [self.VideoContianerView addSubview:self.videoImageView];
    [self.VideoContianerView addSubview:playBtn];
    [self.VideoContianerView addSubview:self.timelabel];
    [self.VideoContianerView addSubview:self.playCountLabel];
    self.loveButton = [[UIButton alloc]init];
    [bottomView addSubview:self.loveButton];
    self.hatebutton = [[UIButton alloc]init];
    [bottomView addSubview:self.hatebutton];
    self.repostButton = [[UIButton alloc]init];
    [bottomView addSubview:self.repostButton];
    self.commentButton = [[UIButton alloc]init];
    [bottomView addSubview:self.commentButton];
    

    
    self.headerImageView.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .heightIs(kWidth *0.125)
    .widthIs(kWidth *0.125);
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.headerImageView,5)
    .topSpaceToView(self.contentView,10)
    .heightIs(20);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    self.createdTimeLabel.sd_layout
    .leftSpaceToView(self.headerImageView,10).topSpaceToView(self.nameLabel,10)
    .heightIs(20);
    [self.createdTimeLabel setSingleLineAutoResizeWithMaxWidth:200];
    self.AddFriendsButton.sd_layout
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .heightIs(kWidth *0.12).widthIs(kWidth *0.12);
    
    self.contentLabel.sd_layout
    .leftSpaceToView(self.contentView,20).topSpaceToView(self.headerImageView,10).rightSpaceToView(self.contentView,10);
    
    
    self.VideoContianerView.sd_layout.topSpaceToView(_contentLabel,10).leftSpaceToView(self.contentView,0);
    self.videoImageView.sd_layout.topSpaceToView(self.VideoContianerView,0).centerXEqualToView(self.VideoContianerView);
    self.playCountLabel.sd_layout.leftEqualToView(self.videoImageView).bottomEqualToView(self.videoImageView).heightIs(20);
    playBtn.sd_layout.centerXEqualToView(self.VideoContianerView).centerYEqualToView(self.VideoContianerView).heightIs(50).widthIs(50);
    self.timelabel.sd_layout.rightEqualToView(self.videoImageView).bottomEqualToView(self.videoImageView).heightIs(0);
    [self.timelabel setSingleLineAutoResizeWithMaxWidth:200];
    

    //最新评论
    self.topCommentTopLabel.sd_layout
    .topSpaceToView(self.VideoContianerView,20)
    .leftSpaceToView(self.contentView,20)
    .autoHeightRatio(0);
    self.topCommentLabel.sd_layout
    .topSpaceToView(self.topCommentTopLabel,5)
    .leftSpaceToView(self.topCommentTopLabel,5)
    .rightSpaceToView(self.contentView,10)
    .autoHeightRatio(0);
    

    
    
    _loveButton.sd_layout
    .leftSpaceToView(bottomView,0)
    .topEqualToView(bottomView)
    .bottomEqualToView(bottomView)
    .widthRatioToView(self.contentView,0.25);
    _hatebutton.sd_layout
    .leftSpaceToView(self.loveButton,0)
    .topEqualToView(bottomView)
    .bottomEqualToView(bottomView)
    .widthRatioToView(self.contentView,0.25);
    _repostButton.sd_layout
    .leftSpaceToView(self.hatebutton,0)
    .topEqualToView(bottomView)
    .bottomEqualToView(bottomView)
    .widthRatioToView(self.contentView,0.25);
    _commentButton.sd_layout
    .leftSpaceToView(self.repostButton,0)
    .topEqualToView(bottomView)
    .bottomEqualToView(bottomView)
    .widthRatioToView(self.contentView,0.25);

    [playBtn setBackgroundImage:[UIImage imageNamed:@"video-play"] forState:UIControlStateNormal];
    
    //播放.
    [[playBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(NSIndexPath  *x) {
        if ([self.delegate respondsToSelector:@selector(clickVideoButton:)]) {
            [self.delegate clickVideoButton:self.indexPath];
        }
    }];
    //更多按钮
    [[self.AddFriendsButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if ([self.delegate respondsToSelector:@selector(clickMoreButton:)]) {
            [self.delegate clickMoreButton:self.video];
        }
    }];
    //喜欢
    [[self.loveButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *button) {
        button.selected = !button.selected;
    }];
    //不喜欢
    [[self.hatebutton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(UIButton *button) {
        button.selected = !button.selected;
    }];
    [[self.commentButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        if ([self.delegate respondsToSelector:@selector(clickCommentButton:)]) {
            [self.delegate clickCommentButton:self.indexPath];
        }
    }];
    
    [self setProperty];
    
}
-(void)setProperty
{
    self.nameLabel.textColor = [UIColor blueColor];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.font = [UIFont systemFontOfSize:16];
    self.createdTimeLabel.font = [UIFont systemFontOfSize:12];
    bottomView.backgroundColor = [UIColor darkGrayColor];
//    self.contentLabel.lineBreakMode  = NSLineBreakByWordWrapping;
//    self.contentLabel.numberOfLines = 0;
//    bottomView.backgroundColor = [UIColor greenColor];
//    self.headerImageView.backgroundColor = [UIColor yellowColor];
//    self.nameLabel.backgroundColor = [UIColor cyanColor];
//    self.createdTimeLabel.backgroundColor = [UIColor blueColor];
//    self.AddFriendsButton.backgroundColor = [UIColor magentaColor];
//    self.contentLabel.backgroundColor = [UIColor purpleColor];
//    self.VideoContianerView.backgroundColor = [UIColor yellowColor];
  //  [SDWebImageManager sharedManager].delegate = self;
}


-(void)setVideo:(VideoDataModal *)video
{
    _video = video;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:video.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]  ];
    NSLog(@"%@",video.profile_image);
    self.nameLabel.text = video.screen_name;
    self.createdTimeLabel.text = video.created_at;
    self.contentLabel.text = video.text;
    self.vipImageView.hidden = !video.isSina_v;
    NSInteger count = video.playcount.integerValue;
    if (count>10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%ld万播放",count/10000];
    } else {
        self.playCountLabel.text = [NSString stringWithFormat:@"%ld播放",(long)count];
    }
    NSInteger time = video.videotime.integerValue;
    self.timelabel.text = [NSString stringWithFormat:@"%02ld%02ld",time/60,time%60];

    [self setupButton:self.loveButton WithTittle:video.love];
    [self setupButton:self.hatebutton WithTittle:video.cai];
    [self setupButton:self.repostButton WithTittle:video.repost];
    [self setupButton:self.commentButton WithTittle:video.comment];
    
    self.contentLabel.sd_layout.autoHeightRatio(0);
    
    CGFloat height = video.height /video.width *kWidth;
    
    self.videoImageView.sd_layout
    .heightIs(height)
    .widthIs(kWidth);
    self.VideoContianerView.sd_layout
    .heightIs(height)
    .widthIs(kWidth);
      [self setupAutoHeightWithBottomView:bottomView bottomMargin:0];
    YHVideoComment *comment = video.top_cmt;
    NSLog(@"%@",video.top_cmt);
    if (comment) {
        self.topCommentLabel.text = [NSString stringWithFormat:@"%@:%@",comment.user.username,comment.content];
        self.topCommentTopLabel.text = @"最热评论";
        //底部菜单评论栏
        bottomView.sd_layout
        .topSpaceToView(self.topCommentLabel,10)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(44);
    }else{
        self.topCommentLabel.text = @"";
        self.topCommentTopLabel.text = @"";
           //底部菜单评论栏
        bottomView.sd_layout
        .topSpaceToView(self.VideoContianerView,10)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(44);
    }

    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:video.image1] placeholderImage:nil];
}

- (void)setupButton:(UIButton *)button WithTittle:(NSString *)tittle {
    double number = tittle.doubleValue;
    if (number > 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number/10000] forState:UIControlStateNormal];
        return;
    }
    [button setTitle:tittle forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
