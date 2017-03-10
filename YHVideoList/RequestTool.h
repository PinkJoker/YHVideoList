//
//  RequestTool.h
//  YHVideoList
//
//  Created by 我叫MT on 17/3/9.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id response);
typedef void(^failBlock)(id response);

@interface RequestTool : NSObject
@property(nonatomic, strong)RACCommand *requestCommand;

@property(nonatomic, strong)RACSignal *signalDelegate;

//@property(nonatomic, copy)successBlock successblock;
//@property(nonatomic, copy)failBlock failblock;
+(void)RequstwithGetUrl:(NSString *)url withParameters:(NSDictionary *)dic withSuccess:(successBlock)success withFail:(failBlock)fail;
@end
