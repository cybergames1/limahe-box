//
//  RadarView.h
//  LimaHeBox
//
//  Created by jianting on 15/8/22.
//  Copyright (c) 2015年 jianting. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    RadarStateNone,          //没有状态，异常
    RadarStateReadyToRearch, //准备开始搜索外设
    RadarStateSearching,     //正在搜索
    RadarStateSearchSuccess, //搜索成功
    RadarStateSearchFailure, //搜索失败
    RadarStateMatching,      //开始匹配
    RadarStateMatchSuccess,  //匹配成功
    RadarStateMatchFailure,  //匹配失败
    RadarStateWarning,       //警告，因为距离拉远等发出警告
    RadarStateStop,          //停止服务
};
typedef NSInteger RadarState;

@interface RadarView : UIView

@property (nonatomic, assign) RadarState state;

@end

/**
 * 下面的提示信息
 **/
@interface RadarLabel : UIView
{
    UILabel * _noticeLabel;
}

@property (nonatomic, assign) RadarState state;

@end

/**
 * 环
 **/
@interface RaceView : UIView

@end
