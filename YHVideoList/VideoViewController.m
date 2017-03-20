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
@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong)UITableView *videoTableView;
@property(nonatomic, strong)NSMutableArray *videoArray;
@property(nonatomic, assign)NSInteger currentPage;
@property(nonatomic, strong)NSString *maxtime;
@property(nonatomic, strong)NSDictionary *parameters;
@property(nonatomic, copy)NSString *currentSkinModel;
@property(nonatomic, assign)BOOL isFullScreenPlaying;
@end
static NSString * const VideoCell = @"VideoCell";
@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
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
    self.videoTableView.sd_layout
    .topEqualToView(self.view).leftEqualToView(self.view).rightEqualToView(self.view).heightRatioToView(self.view,1);
    self.videoTableView.dataSource = self;
    self.videoTableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.videoTableView.contentInset = UIEdgeInsetsMake(C, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    
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
        [self.videoTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
        
    }];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videoArray.count;
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
