//
//  NetworkInterface.h
//  KuDong
//
//  Created by mac on 15/6/18.
//  Copyright (c) 2015年 LinLongFei. All rights reserved.
//

#ifndef KuDong_NetworkInterface_h
#define KuDong_NetworkInterface_h

//============================ 登陆前及第三方登陆接口 GET & POST 请求 =================================//

// 打开界面时
#define LandURL @"http://api.share.mob.com:80/conf4"  //POST
#define landURL2 @"http://api.share.mob.com:80/snsconf" //POST
#define landURL3 @"http://api.share.mob.com:80/log4" //POST

// 微信接口登录前界面请求
#define landByWeChat @"http://szshort.weixin.qq.com/cgi-bin/micromsg-bin/geta8key" //POST

// 点击登陆按钮请求登陆
#define landing @""

//运行时请求环
#define runLoopRequest @"http://ledong.im/api/default/loop" //GET

//config请求???
#define configRequest @"http://ledong.im/api/default/config"
//例如: {
//"error": 10000,
//"msg": "",
//"data": {
//    "share_content": "我在@酷动社区 发现了一张图片~",
//    "event_share_content": "活动分享自@酷动社区",
//    "album_share_content": "",
//    "invite_content": {
//        "qq": {
//            "title": "酷动-户外极限运动社区",
//            "description": "",
//            "url": "http://ledong.im/app/invite?uid=135150&platform=qq"
//        },
//        "weixin": {
//            "title": "酷动-户外极限运动社区",
//            "description": "",
//            "url": "https://itunes.apple.com/cn/app/id897489848"
//        },
//        "mobile": {
//            "title": "酷动-户外极限运动社区 http://kudong.im/ ",
//            "description": "",
//            "url": ""
//        }
//    },
//    "weibo_guide": false
//}
//}

//用户自己基本信息请求
#define MyuserMessage @"http://ledong.im/api/user/get?id=135150" //GET


//------------------------- 主页 -------------------------------//

// 首页:酷动精选页面接口数据JSON
#define kuDongJingXuan @"http://ledong.im/api/feed/elite?limit=30&offset=%d" //GET

// 首页:我的关注界面接口数据JSON
#define GuanZhu @"http://ledong.im/api/feed/all?limit=30&offset=%d"
//GET

// 在原有发布界面下进入评论数据接口
#define comment @"http://ledong.im/api/comment/get?limit=15&offset=0&id=%li&type=feed"



//------------------------- 广场 ------------------------------//
#define Plaza @"http://ledong.im/api/discovery/plaza" //GET

// 点击各个主题（包括头部三张图片）数据接口（JSON数据包括评论全部下载）ID 为主题ID
#define topicOfGround @"http://ledong.im/api/feed/tag?limit=30&offset=0&id=%li&model="

#define New @"http://ledong.im/api/feed/new?limit=30&offset=0"

// 活动接口
#define EVENT @"http://ledong.im/api/event/all?limit=30&offset=0"

// 品牌接口
#define Brand @"http://ledong.im/api/discovery/recommend_brands?limit=30&offset=0"

//------------------------ 用户个人主页面 -----------------------//

// 发布信息接口  ID为发布者帐号ID
#define mainPage @"http://ledong.im/api/user/feeds?limit=30&id=%@&cat=0&offset=0&type_id=0"

#define UserFeed  @"http://ledong.im/api/feed/get?id=%li"

// 用户基本信息接口
#define basicMessage @"http://ledong.im/api/user/get?id=%@"

// 粉丝信息接口
#define fans @"http://ledong.im/api/user/fans?limit=30&offset=0&id=%@"

// 关注信息接口  ID为发布内容相关ID
#define following @"http://ledong.im/api/user/following?limit=30&id=%@&cat=0&offset=0&type_id=0"

// 个人相册接口
// 暂时没有

// 图片列表视图接口 就是从发布信息接口数据中提取每个发布的大图URL然后SDImage异步加载图片
//               点击进入每个发布的详细界面,请求数据为评论内容
#define comment1 @"http://ledong.im/api/comment/get?limit=15&offset=0&id=54557&type=feed"

// 关注接口
#define guanZhu @"http://ledong.im/api/user/add_friend"  // POST
// 取消关注接口
#define quXiaoGuanZhu @"http://ledong.im/api/user/del_friend" // POST

// 举报接口
#define juBao @"http://ledong.im/api/default/report" // POST

//---------------------- 我的好友视图界面 -------------------------//

#define MyFriend @"http://ledong.im/api/notification/get?limit=30&offset=0" // GET 需登陆

//----------------------添加好友视图界面-----------------------//

// GET
#define AddFriendHot @"http://ledong.im/api/setting/new_friend/hot?limit=30&offset=0"

// GET 需要登陆
#define AddFriendNew @"http://ledong.im/api/setting/new_friend/new?limit=30&offset=0"
// GET 需要登陆
#define AddFriendSocial @"http://ledong.im/api/setting/new_friend/social?limit=30&offset=0"

//---------------------------设置----------------------------//

// GET 地理位置编码
#define areaCode @"http://ledong.im/api/default/areas"

#define Favorite @"http://ledong.im/api/default/types?page=profile"

#endif
