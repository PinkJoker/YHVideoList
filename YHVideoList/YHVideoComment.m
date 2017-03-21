//
//  YHVideoComment.m
//  YHVideoList
//
//  Created by 我叫MT on 17/3/21.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import "YHVideoComment.h"

@implementation YHVideoComment

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [self mj_encode:aCoder];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self= [super init]) {
        [self mj_decode:aDecoder];
    }
    return self;
}

@end
