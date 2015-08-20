//
//  FTInputView.h
//  QiYIShareKit
//
//  Created by Sean on 13-11-14.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//
/*
 自定义的输入框
 1、可以设置placeholde
 2、自定义边框样式
 3、高度随输入内容多少变化
 4、自定义光标颜色
 5、可以设置最大输入字数、超过字数有回调
 */

#import "FTDefine.h"
@class FTInputView;
@protocol FTInputViewDelegate <NSObject>
@optional
/**
 当输入框高度发生改变后调用，调用者在这里可以适配自己的输入窗口位置
 */
- (void) inputViewFrameChanged:(FTInputView*) inputView;

/**
 开始输入的回调
 */
- (void) inputViewDidBeginEditing:(FTInputView*) inputView;

 /**
  结束输入的回调，两种情况下会调用该方法。
     1、点中键盘右下角的“Done”按钮
     2、输入框失去焦点（resignFirstResponder）
  */
- (void) inputViewDidEndEditing:(FTInputView*) inputView;

 /**
  当用户点击键盘右下角的 "Done" 按钮
  @note 调用者需要在这个回调里决定是否要隐藏键盘
  */
- (void) inputViewDidTouchesDoneButton:(FTInputView*) inputView;

 /**
  输入内容发生改变的回调。每次用户输入都会触发该回调
  */
- (void) inputViewDidChange:(FTInputView*) inputView;

@end

@class FTTextView;
@interface FTInputView : UIView
/**
 初始化方法
 */
- (id)initWithFrame:(CGRect)frame delegate:(id<FTInputViewDelegate>)delegate;
/**
 delegate
 */
@property(nonatomic,  assign) id<FTInputViewDelegate> delegate;

/**
 text,实际有效的文本，该值受countLimit影响，如果countLimit>0，
 返回不大于countLimit的字符。如果要获取所有输入的字符，请使用userInputText属性
 @details 该方法返回的text考虑到了中文输入法的空格问题，用户实际输入的空格则不受影响
 */
@property (nonatomic, retain) NSString* text;

/**
 textCount,实际有效的文本个数，该值受countLimit影响，
 如果countLimit>0，最大返回值为countLimit
 */
@property (nonatomic, readonly)NSInteger textCount;

/**
 用户实际输入的字符，不受countLimit限制
 @details 中文输入法下系统输入的空格没有经过处理
 */
@property (nonatomic, readonly)NSString* userInputText;
/**
 用户实际输入的字符个数，不受countLimit限制
 @details 该方法返回的textCount考虑到了中文输入法的空格问题，
          用户实际输入的空格则不受影响。如果忽略中文下系统空格的问题，计算个数请通过
          [userInputText length]
 */
@property (nonatomic, readonly)NSInteger userInputTextCount;

/**
 清空之前的输入，但是不会改变当前输入框的大小
 @node 该API虽然与self.text=nil，都能情况内容，但是后者会发送inputViewFrameChanged：通知。
       而[self clearContents]不会发送通知
 */
- (void)clearContents;

@end

@interface FTInputView(InputFont)
/**
 输入文本字体名称,默认 Arial
 */
@property (nonatomic, copy) NSString* fontName;

/**
 输入文本字号,默认=16
 */
@property (nonatomic, assign) CGFloat fontSize;
/**
 输入文本颜色,默认[UIColor blackColor]
 */
@property (nonatomic, retain) UIColor* textColor;

/**
 设置光标的颜色，如果不设置，默认使用蓝色（系统原生得光标颜色）
 @note 在设置其他颜色后，如果要恢复系统原生颜色，可以通过 
       setCursorColor:nil或者setCursorColor:[UIColor blueColor]得方法来实现。
 */
@property (nonatomic, retain) UIColor* cursorColor;

@end

@interface FTInputView(InputStyle)
/**
 文本内容自动解析类型,默认不解析，UIDataDetectorTypeNone
 */
@property (nonatomic)UIDataDetectorTypes dataDetectorTypes;
/**
 键盘右下角按键类型,默认 UIReturnKeyDefault
 */
@property (nonatomic, assign)UIReturnKeyType returnKeyType;
/**
 文本框外框类型，默认FTInputBorderStyleNone
 */
@property (nonatomic, assign) FTInputBorderStyle borderStyle;

/**
 文本框外框颜色，默认 [UIColor whiteColor]
 @note 该属性仅对FTInputBorderStyleRoundedRect有效
 */
@property (nonatomic, retain) UIColor* borderColor;

/**
 文本框外框宽度，默认 2.0
 @note 该属性仅对FTInputBorderStyleRoundedRect有效
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 文本框外框圆角大小，默认 5.0
 @note 该属性仅对FTInputBorderStyleRoundedRect有效
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 当输入内容满一行需要调整高度时的适配模式，
 向上扩充、向下扩充、高度不变，默认 FTFitStyleNone
 */
@property (nonatomic, assign) FTFitStyle fitStyle;

/**
 自定义外框图片，仅对FTInputBorderStyleCustom有效
 */
@property (nonatomic, retain) UIImage* borderImage;

@end

@interface FTInputView (InputPlaceholder)
/**
 占位符内容
 */
@property (nonatomic,assign) NSString* placeholder;

/**
 占位符颜色，默认 grayColor.
 */
@property (nonatomic,assign) UIColor* placeholderTextColor;

/**
 占位符在整个文本输入框中得布局位置,默认 FTPlaceholderStyleTop
 当inputView初始高度多于一行时，建议使用FTPlaceholderStyleTop
 */
@property (nonatomic, assign) FTPlaceholderStyle placeholderStyle;

@end

@interface FTInputView(InputLimit)
/**
 输入个数限制，如果为0，表示不限制个数，为非0数时，当达到限制个数时，会调用 inputViewDidBeyoundCountLimit: ，默认为0
 */
@property (nonatomic, assign) NSInteger countLimit;

/**
 超出限制后是否允许继续输入字符，默认 NO，不禁止输入
 */
@property (nonatomic, assign) BOOL forbiddenInputWhenCountLimitBeExceeded;

/**
 文本框高度限制，超过这个高度将不会再增高。默认6行
 */
@property (nonatomic, assign) CGFloat inputViewHeightLimit;

/**
 输入内容（包括占位符）居左右边框的间距,default = 5.0
 */
@property (nonatomic,assign) CGFloat contentLeftMargin;

@end