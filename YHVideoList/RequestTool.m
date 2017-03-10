//
//  RequestTool.m
//  YHVideoList
//
//  Created by 我叫MT on 17/3/9.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import "RequestTool.h"

@implementation RequestTool
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)RequstwithUrl:(NSString *)url withParameters:(NSDictionary *)dic
{
    self.requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
            [manager POST:@"http://api.budejie.com/api/api_open.php" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [subscriber sendNext:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [subscriber sendNext:error];
            }];
            return nil;
        }];
        return signal;
    }];
}

@end
