//
//  VideoTableViewCell.m
//  YHVideoList
//
//  Created by 我叫MT on 17/3/10.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import "VideoTableViewCell.h"


@interface VideoTableViewCell ()
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
        [self creatView];
    }
    return self;
}

-(void)creatView
{
    
    UIView *bottomView = [[UIView alloc]init];
    [self.contentView addSubview:bottomView];
    
    
    self.headerImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.headerImageView];
    self.nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.nameLabel];
    self.createdTimeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.createdTimeLabel];
    self.AddFriendsButton = [[UIButton alloc]init];
    [self.contentView addSubview:self.AddFriendsButton];
    self.loveButton = [[UIButton alloc]init];
    [bottomView addSubview:self.loveButton];
    self.hatebutton = [[UIButton alloc]init];
    [bottomView addSubview:self.hatebutton];
    self.repostButton = [[UIButton alloc]init];
    [bottomView addSubview:self.repostButton];
    self.commentButton = [[UIButton alloc]init];
    [bottomView addSubview:self.commentButton];
    self.contentLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.contentLabel];
    self.vipImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.vipImageView];
    self.topCommentTopLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.topCommentTopLabel];


    self.topCommentLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.topCommentLabel];
    self.VideoContianerView = [[UIView alloc]init];
    [self.contentView addSubview:self.VideoContianerView];
    
    self.videoImageView = [[UIImageView alloc]init];
    [self.VideoContianerView addSubview:self.videoImageView];
    self.timelabel = [[UILabel alloc]init];
    [self.VideoContianerView addSubview:self.timelabel];
    self.playCountLabel = [[UILabel alloc]init];
    [self.VideoContianerView addSubview:self.playCountLabel];
    UIButton *playBtn = [[UIButton alloc]init];
    [self.VideoContianerView addSubview:playBtn];
    
  [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(20);
      make.left.mas_equalTo(15);
      make.width.height.mas_equalTo(kWidth *0.15);
  }];
  [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(self.headerImageView.mas_top);
      make.left.mas_equalTo(self.headerImageView.mas_right).offset(10);
  }];
   [self.createdTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.nameLabel.mas_left);
       make.top.mas_equalTo(self.nameLabel.mas_bottom);
   }];
    [self.AddFriendsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(60);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    [self.loveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(kWidth *0.25);
        make.bottom.mas_equalTo(0);
    }];
    [self.hatebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidth *0.25);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(kWidth *0.25);
        make.bottom.mas_equalTo(0);
    }];
    [self.repostButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidth *0.5);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(kWidth *0.25);
        make.bottom.mas_equalTo(0);
    }];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidth *0.75);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(kWidth *0.25);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_left);
        make.top.mas_equalTo(self.headerImageView.mas_bottom).offset(10);
    }];
    
    [self.VideoContianerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(kWidth *0.35);
    }];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
