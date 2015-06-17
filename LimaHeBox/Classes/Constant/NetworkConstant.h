//
//  NetworkConstant.h
//  PaPaQi
//
//  Created by fangyuxi on 13-11-12.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//


//网络相关的常量
//由于网络相关的常量比较多，请先查看是否有适合自己的 pragma mark

#ifndef PaPaQi_NetworkConstant_h
#define PaPaQi_NetworkConstant_h

#pragma mark ---------------------------
#pragma mark 服务端返回错误字段定义
#pragma mark ---------------------------

/** 错误Domain **/
#define KErrorDomain @"PPQERRORDOMAIN"
/** 错误信息相关 **/
#define KErrorCode @"code"
#define KErrorCodeKey @"errorCode"
#define KErrorMSG @"msg"
#define KErrorNormal @"A00000"
#define KErrorUploadMore @"A00018"
#define KErrorCodeServerError 500
#define KErrorCodeOKMin 200
#define KErrorCodeOKMax 206

#pragma mark ---------------------------
#pragma mark 底层错误code
#pragma mark ---------------------------

// 网络请求失败（没有网络）
#define kErrorCodeConnectionFailure 101
// 网络请求时间超时
#define kErrorCodeTimedOut 102
// 认证失败
#define kErrorCodeAuthenticationError 103
// 网络请求取消
#define kErrorCodeRequestCancelled 104
// 无法创建网络请求
#define kErrorCodeUnableToCreateRequest 105
// 无法创建网络请求
#define kErrorCodeBuildingRequestFailure 106
// 应用凭证失败
#define kErrorCodeApplyingCredentialsFailure 107
// 文件管理失败
#define kErrorCodeFileManagementError 108
// 存在太多的重定向
#define kErrorCodeTooMuchRedirection 109
// 未知错误
#define kErrorCodeUnhandledException 110
// 压缩出现错误
#define kErrorCodeCompressionError 111
// 网络连接出现错误
#define kErrorCodeDefaultError 190


#pragma mark ---------------------------
#pragma mark 枚举类型
#pragma mark ---------------------------

/** 网络tag标识 **/
typedef NS_ENUM(NSInteger, PPQNetworkTag)
{
    EPPQNetworkNoneTag = 0,
    
    EPPQNetworkNormalTag,     //正常情况
    EPPQNetworkMoreTag,       //加载更多
    
    EPPQNetGetFileID,         //获取fileid
    EPPQNetUploadNotifyEnd,   //通知传完数据块
    EPPQNetUploadMetadata,    //上传metadata
    EPPQNetSecondShare,        //二次分享
    EPPQNetUploadEnd,         //
    EPPQNetUploadPart,        //上传部分
    EPPQNetUploadVideoThumb,  //上传封面
    
    EPPQNetDiscover,          //获取发现首页数据
    EPPQNetActivityDetail,    //获取活动详情
    
    EPPQNetLogin,             //登录
    EPPQNetSavePushToken,     //保存pushtoken
    EPPQNetLogout,            //登出账号
    EPPQNetSnsLogin,          //第三方登录
    EPPQNetRegister,          //注册
    EPPQNetGetPinCode,        //获取验证码
    EPPQNetVerifyPinCode,     //验证验证码
    EPPQNetBindPhone,         //绑定手机号
    EPPQNetUnBind,            //解除绑定
    
    EPPQNetSnsBind,           //第三方绑定
    
    EPPQNetProfile,           //个人主页
    EPPQNetModifySignature,   //修改个性签名
    EPPQNetModifyNoteName,    //修改备注
    EPPQNetUploadUserHeader,  //上传头像
    
    EPPQNetUpdateVideoAuth,   //修改视频权限
    EPPQNetGetVideoDetail,     //获取视频详情
    EPPQNetGetVideoFavour,      //获取视频赞信息
    EPPQNetGetActivityDetail,  //获取活动详细信息
    
    EPPQNetGetVideoM3U8URL,    //获取视频播放地址

    
    EPPQNetAddFriend, /** 添加好友 **/
    EPPQNetDeleteFriend,/** 删除好友 **/
    EPPQNetDealFriendApply,/** 处理申请 **/
    EPPQNetInviteFriend,/** 通讯录邀请好友 **/
    EPPQNetFriendRelation,/** 判断好友关系 **/
    EPPQNetFriendAccept,/** 通过好友请求 **/
    EPPQNetUploadContacts,/** 上传用户通讯录 **/
    EPPQNetContactsFriends,/** 通讯录好友 **/
    
    EPPQNetMessageCount, //查未读消息数
    EPPQNetMessageList,  //获取未读消息列表
    
    EPPQNetCheckForNewVertion, //检测新版本
    EPPQNetInitApp,      //初始化Init
    EPPQNetImplicitApp   //隐式登录
};

#pragma mark ---------------------------
#pragma mark  常量
#pragma mark ---------------------------

#define KTimelineVDATA KPPQData
#define KListCursor @"cursor"
#define KAccessToken @"Authorization"


#pragma mark ---------------------
#pragma mark push token
#pragma mark ---------------------



#define KPushToken @"push_token"



#pragma mark ---------------------------
#pragma mark 第三方分享
#pragma mark ---------------------------

/** 第三方分享 **/
#define KShareSNSSNSList @"sns_ids"
#define KShareSNSText @"text"
#define KShareAndBindSinaType @"1"    //新浪
#define KShareAndBindQZoneType @"2"   //qqzone
#define KShareAndBindLaiWangType @"5" //来往
#define KShareAndBindWeiXin @"9"      //微信好友、微信好友圈
#define kShareAction @"action"
#define KShareSNSTitle @"title"
#define KShareSNSDesc  @"desc"
#define KShareSNSTag   @"tag"
#define KShareSNSFrom  @"from"
#define KShareSNSGeox  @"geox"
#define KShareSNSGeoy  @"geoy"
#define KShareActivityId @"topic_id"
#define KShareCategoryId @"category_id"
#define KShareAgentType @"agenttype"
#define KShareOpenStatus @"open_status"
#define KSharePostType   @"post_type"
#define KShareResolution @"resolution"
#define kShareShootMode  @"shoot_mode"
#define kShareUserCutting @"user_cutting"
#define kShareStylePKG  @"style_pkg"
#define kShareFileType @"file_type"

//直接跳到撰写评论界面
#define kCommentItunesURL @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=595077781"

#define kCommentItunesIOS7URL @"itms-apps://itunes.apple.com/app/id595077781"

/** 新浪微博 **/
#define KSinaWeiboCallBackURL @"http://passport.iqiyi.com/sns/oauthcallback.php"
/** 微信 **/
#define KWeixinURLDefault @"http://m.iqiyi.com/qplay.html?fileId=[fileId]&cnid=23&type=weixin"

#pragma mark ---------------------------
#pragma mark  common
#pragma mark ---------------------------

#define KPPQData @"data"

#pragma mark ---------------------------
#pragma mark  刷新列表cursor
#pragma mark ---------------------------

#define KTableSourceDefaultCursor  @"0"
#define kTableSourceNextCursor     @"next_cursor"

#pragma mark ---------------------------
#pragma mark init
#pragma mark ---------------------------

/** 初始化 **/
#define KInitPlatform @"platform"
#define KInitOSVersion @"os_version"
#define KInitChannelId @"channel_id"
#define KInitPushToken @"push_token"
#define KInitDeviceMode @"device_model"


#pragma mark ---------------------------
#pragma mark 版本控制、升级
#pragma mark ---------------------------
/** 版本控制 **/
#define KVersionAuditStatus @"audit_status"
#define KVersionToken @"token"
#define KVersionUpdataInfo  @"upgrade_info"
#define KVersionStatus  @"upgrade_status"
#define KVersionURL @"upgrade_url"
#define KVersionVersionCode @"upgrade_version"
#define KVersionAlert @"alert"
#define KVersionShowAlert @"1"
#define KVersionNoShowAlert @"2"

#pragma mark- 审核状态
/** 审核状态 **/
#define KAppCheckingStateInCheck @"C00001"
#define KAppCheckingStateCheckPass @"C00002"

#pragma mark ---------------------------
#pragma mark  发现
#pragma mark ---------------------------

/*
 发现页视频
 */
#define kDiscoverID @"id"
#define kDiscoverUID @"uid"
#define kDiscoverFileID @"file_id"
#define kDiscoverCategoryID @"category_id"
#define kDiscoverImageUrl @"image_url"
#define kDiscoverDuration @"duration"
#define kDiscoverCreateTime @"create_time"
#define kDiscoverPlayCount @"final_vv"
#define kDiscoverVideoTitle @"content"

#pragma mark ---------------------------
#pragma mark  视频分类
#pragma mark ---------------------------

/*
 发现页分类
 */
#define kVideoCategoryID @"category_id"
#define kVideoCategoryName @"category_name"
#define kVideoCategoryImageUrl @"image_url"
#define kVideoCategoryVideos @"videos"
#define KVideoCategoryTime @"create_time"
#define KVideoCategoryDuration @"duration"
#define KVideoCategoryPlayCount @"final_vv"
#define KVdieoCategoryUserId @"uid"
#define KVdieoCategoryIcon @"icon"
#define KVdieoCategoryTitle @"content"
#define KVideoCategoryId @"id"
#define KVideoCategoryFileId @"file_id"
#define KVideoCategoryUserName @"user_nick"
#define KVideoCategoryUserdata @"user"
#define KVideoCategoryResolution @"resolution"

/** 视频精选页顶部贴图 **/
#define KVideoDiscoverTopImageUrl  @"top_url"

#pragma mark ---------------------------
#pragma mark  视频详情页面
#pragma mark ---------------------------

#define KVideoDetailFileId @"file_id"
#define KVideoDetailUser @"user"
#define KVideoDetailIcon @"icon"
#define KVideoDetailUserName @"user_nick"
#define KVideoDetailTitle @"content"
#define KVideoDetailTime @"create_time"
#define KVideoDetailPlayCount @"final_vv"
#define KVideoDetailCategoryName @"category_name"
#define KVideoDatailTopicName @"topic_name"
#define KVideoDetailId @"id"
#define KVideoDetailUserId @"uid"

/** 详情页中推荐视频相关 **/
#define KVideoDetailRecommendVideos @"r_videos"
#define KVideoDetailRecommendImage @"image_url"
#define KVideoDetailRecommendTime @"create_time"
#define KVideoDetailRecommendTitle @"content"
#define KVideoDetailRecommendDuration @"duration"
#define KVideoDetailRecommendPlayCount @"final_vv"
#define KVideoDetailRecommendLikeCount @"like_num"
#define KVideoDetailRecommendCommentCount @"comment_num"

/** 评论列表 **/
#define KVideoCommentList @"comment_list"
#define KVideoCommentListNum @"comment_num"
#define KVideoCommentUser @"user"
#define KVideoCommentUserId @"uid"
#define KVideoCommentUserName @"user_nick"
#define KVideoCommentTime @"create_time"
#define KVideoCommentId @"id"
#define KVideoCommentUserIcon @"icon"
#define KVideoCommentContent @"content"
#define KVideoCommentIsFriend @"is_friend"
#define KVideoCommentReplyUser @"reply_user"

/** 赞列表 **/
#define KVideoLikeList @""
#define KVideoLikeUser @"user"
#define KVideoLikeUserNick @"user_nick"
#define KVideoLikeUserId @"uid"
#define KVideoLikeUserIcon @"icon"
#define KVideoLikeUserSignature @"signature"

#pragma mark ---------------------------
#pragma mark  关注 Timeline
#pragma mark ---------------------------

#define kTimelineID @"id" //
#define kTimelineCategoryID @"category_id" //分类ID
#define kTimelineCategoryName @"category_name" //分类名
#define kTimelinePlayCount @"final_vv" //播放数
#define kTimelineCommentCount @"comment_num" //评论数
#define kTimelineCommentList @"comment_list" //评论列表
#define kTimelineLikeCount @"like_num" //赞数
#define kTimelineLikeList @"like_user_list" //赞列表
#define kTimelineContent @"content" //内容
#define kTimelineCreateTime @"create_time" //创建时间
#define kTimelineDuration @"duration" //时长
#define kTimelineFileID @"file_id" //fileID
#define kTimelineImageURL @"image_url" //
#define KTimelineFileStatus @"file_status" // 1 发布中 2 发不成功 3 发布失败 4 已删除
#define kTimelineM3U @"m3u" //m3u8
#define kTimelineM4U @"mp4" //m4u
#define kTimelineOpenStatus @"open_status" //隐私状态
#define kTimelineResolution @"resolution" //尺寸
#define kTimelineUser @"user" //用户信息
#define KTimelineUserNick @"user_nick"
#define KTimelineUserIcon @"icon"
#define kTimelineIsLike @"is_like" //是否赞过
#define kTimelinePlayUrl @"play_url" //play url，H5播放地址
#define KTimelineShareURL @"share_url"

#pragma mark ---------------------------
#pragma mark  登录返回
#pragma mark ---------------------------

//登录用户
#define KLoginUserData @"data"
#define KLoginUser @"user"
#define KLoginUserAccessToken @"access_token"
#define KLoginUserAuthtoken @"auth_token"
#define KLoginUserOpToken @"op_token"
#define KLoginUserType @"sns_type"
#define KLoginUserOpId @"op_token"
#define KLoginUserCover @"cover"
#define KLoginUserIcon @"icon"
#define KLoginUserUid @"uid"
#define KLoginUserName @"user_nick"
#define KLoginUserIntoduction @"signature"
#define KLoginUserSNSList @"sns_list"
#define kLoginUserNoteName @"note_name" //用户备注名
#define KLoginUserPhoneNumber @"phone"
#define KLoginUserEmail @"email"
#define KLoginGender @"gender"
#define KLoginBirthday @"birthday"

#define kLoginUserSetting @"user_settings"
#define kLoginUserSettingPush @"push_mode"
#define kLoginUserSettingVerify @"verify_mode"
#define KLoginUserSettingFile @"file_mode"

//隐私设置
#define KLoginPushMode @"push_mode"

#define Sell_Color [UIColor colorWithRed:(255.0/255.0) green:(102.0/255.0) blue:0.0 alpha:1.0]
#define Buy_Color [UIColor colorWithRed:(32.0/255.0) green:(169.0/255.0) blue:(146.0/255.0) alpha:1.0]

#define Push_Color [UIColor colorWithRed:(0.0/255.0) green:(129.0/255.0) blue:(0.0/255.0) alpha:1.0]
#define Pull_Color [UIColor colorWithRed:(255.0/255.0) green:(0.0/255.0) blue:(81.0/255.0) alpha:1.0]

#define API_Key @"916F321C-D3AB-45D8-BE58-C536EC7A65F2"
#define API_Secret @"1197d9030ea0a99c21f9bb7e099997f53cb4dfc4f786b959d6b1e1d0af290e36"

#define MAX_CNY 10000.00f
#define Rate(a) MIN(a/MAX_CNY,1.0f)

#endif
