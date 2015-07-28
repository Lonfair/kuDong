//
//  ModelTool.m
//  爱限免
//
//  Created by qf on 15-5-15.
//  Copyright (c) 2015年 ZCJ. All rights reserved.
//

#import "ModelTool.h"

@implementation ModelTool
#pragma mark 创建model类
//代码创建model类
+(void)creatModelWothDictionary:(NSDictionary *)dict modelName:(NSString *)modelName
{
    printf("\n@interface %s :NSObject\n",modelName.UTF8String);
    for (NSString * key in dict) {
        printf("@property (nonatomic,copy) NSString *%s;\n",key.UTF8String);
    }
    printf("@end\n");
}
@end
