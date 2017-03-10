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

+(void)RequstwithGetUrl:(NSString *)url withParameters:(NSDictionary *)dic withSuccess:(successBlock)success withFail:(failBlock)fail
{
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [subscriber sendNext:responseObject];
//        [subscriber sendCompleted];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       // [subscriber sendNext:error];
        if (fail) {
            fail(error);
        }
    }];

//    self.requestCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
//        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//                      return nil;
//        }];
//        return signal;
//    }];
}

@end
