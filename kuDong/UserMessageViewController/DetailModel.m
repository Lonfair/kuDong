//
//  DetailModel.m
//  kuDong
//
//  Created by qianfeng on 15/7/7.
//  Copyright (c) 2015年 DongXiang_Technology. All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.avatar_small forKey:@"avatar_small"];
    [aCoder encodeObject:self.feed_count forKey:@"feed_count"];
    [aCoder encodeObject:self.verify forKey:@"verify"];
    [aCoder encodeObject:self.follow_count forKey:@"follow_count"];
    [aCoder encodeObject:self.fans_count forKey:@"fans_count"];
    [aCoder encodeObject:self.album_count forKey:@"album_count"];
    [aCoder encodeObject:self.created_at forKey:@"created_at"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.medal forKey:@"medal"];
    [aCoder encodeObject:self.relationship forKey:@"relationship"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.score forKey:@"score"];
    [aCoder encodeObject:self.sign forKey:@"sign"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.area forKey:@"area"];
    [aCoder encodeObject:self.config forKey:@"config"];
    [aCoder encodeObject:self.data forKey:@"data"];
    [aCoder encodeObject:self.fav forKey:@"fav"];
    [aCoder encodeObject:self.easemob_password forKey:@"easemob_password"];
    [aCoder encodeObject:self.is_register forKey:@"is_register"];
    [aCoder encodeObject:self.weibo_guide forKey:@"weibo_guide"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.avatar_small = [aDecoder decodeObjectForKey:@"avatar_small"];
        self.feed_count = [aDecoder decodeObjectForKey:@"feed_count"];
        self.verify = [aDecoder decodeObjectForKey:@"verify"];
        self.follow_count = [aDecoder decodeObjectForKey:@"follow_count"];
        self.fans_count = [aDecoder decodeObjectForKey:@"fans_count"];
        self.album_count = [aDecoder decodeObjectForKey:@"album_count"];
        self.created_at = [aDecoder decodeObjectForKey:@"created_at"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.medal = [aDecoder decodeObjectForKey:@"medal"];
        self.relationship = [aDecoder decodeObjectForKey:@"relationship"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.score = [aDecoder decodeObjectForKey:@"score"];
        self.sign = [aDecoder decodeObjectForKey:@"sign"];
        self.desc = [aDecoder decodeObjectForKey:@"desc"];
        self.area = [aDecoder decodeObjectForKey:@"area"];
        self.config = [aDecoder decodeObjectForKey:@"config"];
        self.data = [aDecoder decodeObjectForKey:@"data"];
        self.fav = [aDecoder decodeObjectForKey:@"fav"];
        self.easemob_password = [aDecoder decodeObjectForKey:@"easemob_password"];
        self.is_register = [aDecoder decodeObjectForKey:@"is_register"];
        self.weibo_guide = [aDecoder decodeObjectForKey:@"weibo_guide"];
    }
    
    return self;
}

@end
