//
//  VideoViewController.m
//  YHVideoList
//
//  Created by 我叫MT on 17/3/9.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoModel.h"
#import "VideoDataModal.h"
#import "RequestTool.h"
#import "VideoDataTool.h"
#import "VideoTableViewCell.h"
#import "videoPlayView.h"
#import "FullViewController.h"
@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate,VideoTableViewCellDelegate,VideoPlayViewDelegate>
@property(nonatomic, strong)UITableView *videoTableView;
@property(nonatomic, strong)NSMutableArray *videoArray;
@property(nonatomic, assign)NSInteger currentPage;
@property(nonatomic, strong)NSString *maxtime;
@property(nonatomic, strong)NSDictionary *parameters;
@property(nonatomic, copy)NSString *currentSkinModel;
@property(nonatomic, assign)BOOL isFullScreenPlaying;



@property (nonatomic, weak) videoPlayView *playView;
@property (nonatomic, strong) FullViewController *fullVc;
@property (nonatomic, weak) VideoTableViewCell *currentSelectedCell;

@end
static NSString * const VideoCell = @"VideoCell";
@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setbase];
    [self setTable];
    [self loadData];
}
-(void)setbase
{
    self.currentPage = 0;
    self.isFullScreenPlaying = NO;
}


-(void)setTable
{
    self.videoTableView = [[UITableView alloc]init];
    [self.view addSubview:self.videoTableView];
    [self.videoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.videoTableView.dataSource = self;
    self.videoTableView.delegate = self;

    
    @weakify(self);
    [[self rac_signalForSelector:@selector(clickMoreButton:) fromProtocol:@protocol(VideoTableViewCellDelegate)]subscribeNext:^(id x) {
        @strongify(self);
        UIAlertController *controller =  [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil]];
        [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:nil]];
        [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:controller animated:YES completion:nil];
        
    }];
    
    [[self rac_signalForSelector:@selector(clickVideoButton:) fromProtocol:@protocol(VideoTableViewCellDelegate)]subscribeNext:^(RACTuple *indexPath) {
        [self.playView resetPlayView];
        VideoTableViewCell *cell = [self.videoTableView cellForRowAtIndexPath:indexPath.first];
        self.currentSelectedCell = cell;
        videoPlayView *playView = [[videoPlayView alloc]init];
        VideoDataModal *video = self.videoArray[[indexPath.first row]];
        playView.frame = video.videoFrame;
        [cell addSubview:playView];
        cell.playView = playView;
        self.playView = playView;
        self.playView.delegate = self;
        
//        [self.playView.subjectDelegate subscribeNext:^(id x) {

//        }];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:video.videouri]];
        self.playView.playeritem = item;
        
        
    }];
    
    
}
//#pragma mark VideoTableViewCell的代理方法
//-(void)clickVideoButton:(NSIndexPath *)indexPath {
//    [self.playView resetPlayView];
//    
//    VideoTableViewCell *cell = [self.videoTableView cellForRowAtIndexPath:indexPath];
//    self.currentSelectedCell = cell;
//    videoPlayView *playView = [[videoPlayView alloc]init];
//    VideoDataModal *video = self.videoArray[indexPath.row];
//    playView.frame = cell.VideoContianerView.frame;
//    [cell addSubview:playView];
//    cell.playView = playView;
//    self.playView = playView;
//    self.playView.delegate = self;
//    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:video.videouri]];
//    self.playView.playeritem = item;
//}
#pragma mark VideoPlayViewDelegate 视频播放时窗口模式与全屏模式切换
- (void)videoplayViewSwitchOrientation:(BOOL)isFull
{
    if (isFull) {
        self.isFullScreenPlaying = YES;
        [self presentViewController:self.fullVc animated:YES completion:^{
            self.playView.frame = self.fullVc.view.bounds;
            [self.fullVc.view addSubview:self.playView];
        }];
    } else {
        [self.fullVc dismissViewControllerAnimated:YES completion:^{
            self.playView.frame = self.currentSelectedCell.video.videoFrame;
            [self.currentSelectedCell addSubview:self.playView];
            self.isFullScreenPlaying = NO;
            
        }];
        
    }
}

#pragma mark - 懒加载代码
- (FullViewController *)fullVc
{
    if (_fullVc == nil) {
        self.fullVc = [[FullViewController alloc] init];
    }
    
    return _fullVc;
}


-(void)loadData
{
    VideoModel *modal = [[VideoModel alloc]init];
    VideoDataModal *dataModal = self.videoArray.firstObject;
    modal.recentTime = dataModal.created_at;
    modal.page = 0;
    modal.maxtime = nil;

    [VideoDataTool videoWithParameters:modal success:^(NSArray *array, NSString *maxtime) {
        self.maxtime = maxtime;
        self.videoArray = [array mutableCopy];
        [self.videoTableView reloadData];
        } failure:^(NSError *error) {
        
        
    }];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VideoCell];
    if (!cell) {
        cell = [[VideoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VideoCell];
    }
    cell.video = self.videoArray[indexPath.row];
    cell.delegate = self;
    cell.indexPath = indexPath;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoDataModal * video = self.videoArray[indexPath.row];
   CGFloat height1 = [tableView cellHeightForIndexPath:indexPath model:video keyPath:@"Video" cellClass:[VideoTableViewCell class] contentViewWidth:kWidth];
    return height1;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videoArray.count;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.playView.superview && self.isFullScreenPlaying == NO) {
        NSIndexPath *indexPath = [self.videoTableView indexPathForCell:self.currentSelectedCell];
        if (![self.videoTableView.indexPathsForVisibleRows containsObject:indexPath]) {//播放video的cell离开屏幕
            [self.playView resetPlayView];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
