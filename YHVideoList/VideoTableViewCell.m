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
@interface VideoTableViewCell ()<SDWebImageManagerDelegate>
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
@property (strong, nonatomic)  UIView *VideoContianerView;

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
    self.videoImageView = [[UIImageView alloc]init];
    self.timelabel = [[UILabel alloc]init];
    self.playCountLabel = [[UILabel alloc]init];
    UIButton *playBtn = [[UIButton alloc]init];
    UIView *bottomView = [[UIView alloc]init];
    NSArray *views = @[self.headerImageView,self.nameLabel,self.createdTimeLabel,self,_VideoContianerView,bottomView];
    [self.contentView sd_addSubviews:views];
    
    bottomView.backgroundColor = [UIColor yellowColor];
    self.loveButton = [[UIButton alloc]init];
    [bottomView addSubview:self.loveButton];
    self.hatebutton = [[UIButton alloc]init];
    [bottomView addSubview:self.hatebutton];
    self.repostButton = [[UIButton alloc]init];
    [bottomView addSubview:self.repostButton];
    self.commentButton = [[UIButton alloc]init];
    [bottomView addSubview:self.commentButton];
    
    
    self.headerImageView.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.contentView,20)
    .heightIs(60)
    .widthIs(60);
    self.headerImageView.layer.cornerRadius = 30;
    self.headerImageView.clipsToBounds = YES;
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.headerImageView,10)
    .topSpaceToView(self.headerImageView,5)
    .heightIs(25);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    self.createdTimeLabel.sd_layout
    .leftEqualToView(self.nameLabel)
    .topSpaceToView(self.nameLabel,20)
    .heightIs(20);
    [self.createdTimeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.contentLabel.sd_layout
    .leftSpaceToView(self.contentView,30)
    .topSpaceToView(self.headerImageView,15)
    .rightSpaceToView(self.contentView,30)
    .autoHeightRatio(0);
    self.VideoContianerView.sd_layout
    .topSpaceToView(_contentLabel,10)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .autoHeightRatio(0);
    
    self.videoImageView.sd_layout
    .topEqualToView(self.VideoContianerView)
    .leftEqualToView(self.VideoContianerView)
    .rightEqualToView(self.VideoContianerView)
    .autoHeightRatio(0);
    
    self.playCountLabel.sd_layout
    .leftEqualToView(self.videoImageView)
    .bottomEqualToView(self.videoImageView)
    .heightIs(20);
    
    playBtn.sd_layout
    .centerXEqualToView(self.videoImageView)
    .centerYEqualToView(self.videoImageView)
    .heightIs(50)
    .widthIs(50);
    self.timelabel.sd_layout
    .rightEqualToView(self.videoImageView)
    .bottomEqualToView(self.videoImageView)
    .heightIs(0);
    [self.timelabel setSingleLineAutoResizeWithMaxWidth:200];
    
    bottomView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(44);

    playBtn.backgroundColor = [UIColor cyanColor];
    
    
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:10];
    
    
    //播放.
    [[playBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
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

//-(void)setFrame:(CGRect)frame
//{
//    static CGFloat margin = 10;
//    frame.size.width = [UIScreen mainScreen].bounds.size.width;
//    frame.size.height = self.video.cellHeight - margin;
//    [super setFrame:frame];
//}





-(void)setProperty
{
    
    self.nameLabel.textColor = [UIColor blueColor];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageView;
    [SDWebImageManager sharedManager].delegate = self;
    
    
    
}


-(void)setVideo:(VideoDataModal *)video
{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:video.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]  options:SDWebImageTransformAnimatedImage];
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
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:video.image1]];
    [self setupButton:self.loveButton WithTittle:video.love];
    [self setupButton:self.hatebutton WithTittle:video.cai];
    [self setupButton:self.repostButton WithTittle:video.repost];
    [self setupButton:self.commentButton WithTittle:video.comment];
    YHVideoComment *comment = video.top_cmt;
    if (comment) {
        self.topCommentLabel.text = [NSString stringWithFormat:@"%@:%@",comment.user.username,comment.content];
        self.topCommentTopLabel.text = @"最热评论";
    }else{
        self.topCommentLabel.text = @"";
        self.topCommentTopLabel.text = @"";
    }
    
}
-(UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL
{
    //
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    //获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //添加一个
    CGRect rect = CGRectMake(0, 0, image.size.height, image.size.height);
    CGContextAddEllipseInRect(context, rect);
    //裁剪
    CGContextClip(context);
    //将图片画上去
    [image drawInRect:rect];
    UIImage *resultsImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultsImage;
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
