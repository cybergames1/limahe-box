//
//  VideoShareInputView.h
//  PaPaQi
//
//  Created by Sean on 14/12/17.
//  Copyright (c) 2014年 iQiYi. All rights reserved.
//
/**
 视频分享标题输入控件
 1、显示 placeholder
 2、显示字数统计
 3、内容多于3行可滚动
 */
#import <UIKit/UIKit.h>
#define kVideoShareInputViewHeight 78.0
@protocol VideoShareInputDelegate <NSObject>
// 输入完成
- (void) inputViewDidFinish:(NSString*) content;
// begin edit
- (void) inputViewWillBeginEdit;
@end

@interface VideoShareInputView : UIView

// delegate
@property (nonatomic, assign) id<VideoShareInputDelegate> delegate;

// content, readonly
@property (nonatomic, readonly) NSString* content;

// insert content
- (void) insertContent:(NSString*) content atIndex:(NSInteger) index;

// 外面计算字数时不要使用[content length],因为空格或特殊字符会导致计算有误差
- (NSInteger)inputTextCount;

/**
 关于键盘的通知
 1,addKeyboardNotification,则控件会随键盘的弹起自适应调整不被键盘挡住
 2,当不需要控件响应键盘的通知是要removeKeyboardNotification
 **/
- (void)addKeyboardNotification;
- (void)removeKeyboardNotification;

@end
