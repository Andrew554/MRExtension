//
//  HttpTool.h
//  HXSD
//
//  Created by JackXu on 16/2/26.
//  Copyright © 2016年 BFMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

//网络地址
#define HttpURL @"http://www.quzhihuo.com"

//======================================================

#define Login           @"/zhihuo/user/login"//登录
#define UserInfo        @"/zhihuo/user/info"//个人信息
#define AvatarURL       @"http://quzhihuo.image.alimmdn.com/zhihuo/"//头像根路由地址
#define UploadAvatar    @"/zhihuo/uploadImg"//上传头像
#define CheckSmsCode    @"/zhihuo/sendVerCode"//验证验证码
#define RegisterInfo    @"/zhihuo/user/register"//注册信息
#define UpdateUserInfo  @"/zhihuo/user/updateInfo"//更新用户信息
#define Logout          @"/zhihuo/user/logout"//退出登录
#define Feedback        @"/zhihuo/suggestion/add"//意见反馈
#define AboutOur        @"/zhihuo/appContent/view/"//关于我们
#define MyThemeList     @"/zhihuo/myTheme/list"//爱分享板块的标题
#define MySectionList   @"/zhihuo/mySection/list"//爱生活板块的标题
#define CategorylistAll @"/zhihuo/category/listAll"//查看商品一级分类
#define Categorylist    @"/zhihuo/category/listAll/"//查看商品二级分类
#define CategoryListItem @"/zhihuo/category/listItem/"//查看商品分类
#define ListByTheme     @"/zhihuo/scene/listByTheme/"//根据主题分页浏览场景
#define ViewById        @"/zhihuo/scene/viewById/"//根据主题场景id浏览
#define ViewByItemId    @"/zhihuo/item/viewById/"//根据编号查看
#define ListBySection   @"/zhihuo/item/listBySection/"//根据版块分页浏览商品
#define CommentListById @"/zhihuo/itemComment/listByItem/"//根据商品id浏览评论
#define ThemeListOther  @"/zhihuo/myTheme/listOther"//浏览尚未喜欢的主题
#define ThemeListAll    @"/zhihuo/myTheme/listAll"//浏览所有主题
#define ThemeAdd        @"/zhihuo/myTheme/add"//添加喜欢的饿主题
#define ThemeDelete     @"/zhihuo/myTheme/delete"//删除喜欢的主题
#define TMallSearchGood @"/zhihuo/item/phoneSearch"//搜索天猫商品
#define AddGood         @"/zhihuo/item/add"//添加商品
#define CollectionList  @"/zhihuo/myCollection/list"//我的收藏

//=====================动态接口=============================

#define PublishDynamic  @"/zhihuo/ppcc/add"//发表动态
#define PersonCenterDynamic @"/zhihuo/ppcc/personalCenter"//个人中心动态
#define DynamicLikeUsersInfo @"/zhihuo/ppcc/likesUIds"//动态点赞用户的所有信息
#define DynamicComment  @"/zhihuo/comment/comments"//动态所有评论
#define DynamicDZ       @"/zhihuo/ppcc/addLikeNum"//用户点赞
#define DynamicCancelDZ @"/zhihuo/ppcc/reduceLikeNum"//用户取消点赞
#define SceneDynamic    @"/zhihuo/ppcc/byScene"//对应主题的动态
#define DynamicFavAdd   @"/zhihuo/ppcc/addLikeNum"//动态点赞
#define DynamicFavDelete @"/zhihuo/ppcc/reduceLikeNum"//动态取消点赞
#define DynamicCommentAdd @"/zhihuo/comment/add"//发表评论

//======================操作商品====================================
#define GoodSearch  @"/zhihuo//item/search"//关键字搜索商品
#define CollectionAdd  @"/zhihuo/myCollection/add"//商品收藏
#define CollectionDelete  @"/zhihuo/myCollection/delete"//删除收藏的商品
#define MyFavAdd  @"/zhihuo/myItem/add"//商品喜欢
#define MyFavDelete  @"/zhihuo/myItem/delete"//删除喜欢的商品
#define GoodFavUser  @"/zhihuo/myItem/listByItem/"//根据商品编号浏览喜欢的用户
#define MyFavDelete  @"/zhihuo/myItem/delete"//删除喜欢的商品
#define GoodComment @"/zhihuo/itemComment/add"//商品评论

// ==========================================================

#define SearchFriend    @"/zhihuo/user/searchFriend/" //搜索好友
#define NotificationAll    @"/zhihuo/notification/viewAll" //分页浏览所有通知


@interface HttpTool : NSObject

+(void)createAsynchronousRequest:(NSString *)action parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary *dic))success failure:(void(^)())failure;
+(void)createAsynchronousRequest:(NSString *)action isPost:(BOOL)isPost parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary *dic))success failure:(void(^)())failure;
+(void)createUploadImageAsynchronousRequest:(NSString *)action imageData:(NSData *)imageData parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary *dic))success failure:(void(^)())failure;
+(NSURL*)getImageUrlWithName:(NSString*)name;
+ (NSString *)getDateString;
@end
