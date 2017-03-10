//
//  RequestTool.h
//  YHVideoList
//
//  Created by 我叫MT on 17/3/9.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestTool : NSObject
@property(nonatomic, strong)RACCommand *requestCommand;
-(void)RequstwithUrl:(NSString *)url withParameters:(NSDictionary *)dic;
@end
