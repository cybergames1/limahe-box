//
//  FTPageControl.h
//  FTDemo
//
//  Created by Sean on 13-11-12.
//  Copyright (c) 2013年 FTDemo. All rights reserved.
//

/*
 pageControl，可以自定义dot的大小、颜色、间距等
 
 todo:dot可以为图片或者文字
 */
#import <UIKit/UIKit.h>

@interface FTPageControl : UIControl

/**
 currentPage,default=0
 */
@property (nonatomic, assign) NSInteger currentPage;
/**
 numberOfPages,default=1
 */
@property (nonatomic, assign) NSInteger numberOfPages;
/**
 
 */
@property (nonatomic, assign) BOOL defersCurrentPageDisplay;
/**
 hides when SinglePage,default=YES
 */
@property (nonatomic, assign) BOOL hidesForSinglePage;

// Color
/**
 dotColor,default=blackColor,alpha=0.25
 */
@property (nonatomic, retain) UIColor *dotColor;
/**
 selectedDotColor,default=whiteColor
 */
@property (nonatomic, retain) UIColor *selectedDotColor;

// Size
/**
 dotSpacing,default=10.0
 */
@property (nonatomic, assign) CGFloat dotSpacing;
/**
 dotSize,default=6.0
 */
@property (nonatomic, assign) CGFloat dotSize;
/**
 selectedDotSize,default=6.0
 */
@property (nonatomic, assign) CGFloat selectedDotSize;

@end



