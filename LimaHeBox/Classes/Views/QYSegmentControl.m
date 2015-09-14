//
//  QYSegmentControl.m
//  QiYIShareKit
//
//  Created by jianting on 13-8-23.
//  Copyright (c) 2013年 iQiYi. All rights reserved.
//

#import "QYSegmentControl.h"
#import <Category/Category.h>
#import "CommonTools.h"

typedef enum {
    SegmentContentTypeText,
    SegmentContentTypeImage
} SegmentContentType;

@interface UIButton (obj)

- (void)setObject:(id)object;

@end

@implementation UIButton (obj)

+ (SegmentContentType)typeForContent:(id)contentObject
{
    SegmentContentType type = SegmentContentTypeText;
    
    if ([contentObject isKindOfClass:[NSString class]])
    {
        type = SegmentContentTypeText;
    }
    else if ([contentObject isKindOfClass:[UIImage class]])
    {
        type = SegmentContentTypeImage;
    }
    
    return type;
}

- (void)setObject:(id)object
{
    SegmentContentType type = [UIButton typeForContent:object];
    if (type == SegmentContentTypeText)
    {
        [self setTitle:(NSString *)object forState:UIControlStateNormal];
    }
    else if (type == SegmentContentTypeImage)
    {
        [self setImage:(UIImage *)object forState:UIControlStateNormal];
    }
    else
    {
        //格式不支持
    }
}

@end

@interface NSArray (Empty)

- (BOOL)isEmpty;

@end

@implementation NSArray (Empty)

- (BOOL)isEmpty
{
    if (!self || [self count] <= 0)
        return YES;
    else
        return NO;
}

@end


#define BasicTag 92321
#define Font_Size 30

@interface QYSegmentControl ()
{
    NSInteger   _numberOfItems;
}

@property (nonatomic, retain) NSMutableArray * buttonArray;

@end

@implementation QYSegmentControl

@synthesize buttonArray = _buttonArray;
@synthesize itemStyle = _itemStyle;

- (void)dealloc
{
    [_buttonArray release];
    _buttonArray   =   nil;
    
    [super dealloc];
}

- (id)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self)
    {
        if (items == nil) return nil;
        
        _numberOfItems = items.count;
        
        if (_numberOfItems <= 0) return nil;
        
        _buttonArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        if (_numberOfItems == 1)
        {
            //
        }
        else if (_numberOfItems == 2)
        {
            UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button1 setTag:BasicTag + 0];
            [button1 setBackgroundImage:[CommonTools imageWithName:@"register_step1_left_normal" type:@"png"] forState:UIControlStateNormal];
            [button1 setBackgroundImage:[CommonTools imageWithName:@"register_step1_left_pressed" type:@"png"] forState:UIControlStateSelected];
            [button1 setAdjustsImageWhenHighlighted:NO];
            [button1 setObject:[items objectAtIndex:0]];
            [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button1 setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            [button1.titleLabel setFont:[UIFont systemFontOfSize:Font_Size]];
            [button1.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [button1 addTarget:self action:@selector(segmentSelect:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button2 setTag:BasicTag + 1];
            [button2 setBackgroundImage:[CommonTools imageWithName:@"register_step1_right_normal" type:@"png"] forState:UIControlStateNormal];
            [button2 setBackgroundImage:[CommonTools imageWithName:@"register_step1_right_pressed" type:@"png"] forState:UIControlStateSelected];
            [button2 setObject:[items objectAtIndex:1]];
            [button2 setAdjustsImageWhenHighlighted:NO];
            [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button2 setTitleColor:[UIColor greenColor]forState:UIControlStateSelected];
            [button2.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [button2.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [button2 addTarget:self action:@selector(segmentSelect:) forControlEvents:UIControlEventTouchUpInside];
            
            [_buttonArray addObject:button1];
            [_buttonArray addObject:button2];
            
            [self addSubview:button1];
            [self addSubview:button2];
        }
        else
        {
            // 三个及以上
            UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button1 setTag:BasicTag + 0];
            [button1 setBackgroundImage:[CommonTools imageWithName:@"register_step1_left_normal" type:@"png"] forState:UIControlStateNormal];
            [button1 setBackgroundImage:[CommonTools imageWithName:@"register_step1_left_pressed" type:@"png"] forState:UIControlStateSelected];
            [button1 setObject:[items objectAtIndex:0]];
            [button1 setAdjustsImageWhenHighlighted:NO];
            [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button1 setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            [button1.titleLabel setFont:[UIFont systemFontOfSize:Font_Size]];
            [button1.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [button1 addTarget:self action:@selector(segmentSelect:) forControlEvents:UIControlEventTouchUpInside];
            
            [_buttonArray addObject:button1];
            [self addSubview:button1];
            
            for (int i = 1; i < _numberOfItems - 1; i++) {
                @autoreleasepool {
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    [button setTag:BasicTag + i];
                    [button setBackgroundImage:[CommonTools imageWithName:@"register_step1_left_normal" type:@"png"] forState:UIControlStateNormal];
                    [button setBackgroundImage:[CommonTools imageWithName:@"register_step1_left_pressed" type:@"png"] forState:UIControlStateSelected];
                    [button setObject:[items objectAtIndex:i]];
                    [button setAdjustsImageWhenHighlighted:NO];
                    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
                    [button.titleLabel setFont:[UIFont systemFontOfSize:Font_Size]];
                    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
                    [button addTarget:self action:@selector(segmentSelect:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [_buttonArray addObject:button];
                    [self addSubview:button];
                }
            }
            
            UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [button2 setTag:BasicTag + _numberOfItems - 1];
            [button2 setBackgroundImage:[CommonTools imageWithName:@"register_step1_right_normal" type:@"png"] forState:UIControlStateNormal];
            [button2 setBackgroundImage:[CommonTools imageWithName:@"register_step1_right_pressed" type:@"png"] forState:UIControlStateSelected];
            [button2 setObject:[items objectAtIndex:_numberOfItems - 1]];
            [button2 setAdjustsImageWhenHighlighted:NO];
            [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button2 setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            [button2.titleLabel setFont:[UIFont systemFontOfSize:Font_Size]];
            [button2.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [button2 addTarget:self action:@selector(segmentSelect:) forControlEvents:UIControlEventTouchUpInside];
            
            [_buttonArray addObject:button2];
            [self addSubview:button2];
        }
        
        self.selectedIndex = 0;
        
    }
    return self;
}

- (void)segmentSelect:(UIButton *)sender
{
    self.selectedIndex = sender.tag - BasicTag;
}

- (void)setObjects:(NSArray *)objects
{
    if (![objects isEmpty])
    {
        NSInteger count = (objects.count < _buttonArray.count) ? objects.count : _buttonArray.count;
        
        for (NSInteger i = 0; i < count; i++)
        {
            UIButton *button = [_buttonArray objectAtIndex:i];
            [button setObject:[objects objectAtIndex:i]];
        }
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil)
        return;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark -
#pragma mark Public Methods

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex < 0 || selectedIndex >= _buttonArray.count) return;
    
    _selectedIndex = selectedIndex;
    
    for (UIButton *button in _buttonArray)
    {
        button.selected = NO;
    }
    
    ((UIButton *)[_buttonArray objectAtIndex:selectedIndex]).selected = YES;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setImages:(NSArray *)images
{
    [self setObjects:images];
}

- (void)setTitles:(NSArray *)titles
{
    [self setObjects:titles];
}

- (void)setImage:(UIImage *)image atIndex:(NSInteger)index forState:(UIControlState)state
{
    if (index < 0 || index >= _buttonArray.count) return;
    [(UIButton *)[_buttonArray objectAtIndex:index] setImage:image forState:state];
}

- (void)setTitle:(NSString *)title atIndex:(NSInteger)index forState:(UIControlState)state
{
    if (index < 0 || index >= _buttonArray.count) return;
    [(UIButton *)[_buttonArray objectAtIndex:index] setTitle:title forState:state];
}

- (void)setTitleColor:(UIColor *)titleColor forState:(UIControlState)state
{
    for (UIButton *btn in _buttonArray)
    {
        [btn setTitleColor:titleColor forState:state];
    }
}

- (void)setTitleLine:(NSInteger)line
{
    for (UIButton *btn in _buttonArray)
    {
        [btn.titleLabel setNumberOfLines:line];
    }
}

- (void)setTitleFont:(UIFont *)font
{
    for (UIButton *btn in _buttonArray)
    {
        [btn.titleLabel setFont:font];
    }
}

- (void)setTitle:(NSString *)title atIndex:(NSInteger)index
{
    [self setTitle:title atIndex:index forState:UIControlStateNormal];
}

- (void)setBackgroundImages:(NSArray *)backgroundImages forState:(UIControlState)state
{
    if ([backgroundImages isEmpty])
    {
        for (UIButton *button in _buttonArray)
        {
            [button setBackgroundImage:nil forState:state];
        }
    }
    else if (backgroundImages.count == 1)
    {
        //
    }
    else if (backgroundImages.count == 2)
    {
        [(UIButton *)[_buttonArray objectAtIndex:0] setBackgroundImage:[backgroundImages objectAtIndex:0] forState:state];
        [(UIButton *)[_buttonArray objectAtIndex:1] setBackgroundImage:[backgroundImages objectAtIndex:1] forState:state];
    }
    else // >= 3
    {
        for (UIButton * button in _buttonArray)
        {
            [button setBackgroundImage:[backgroundImages objectAtIndex:1] forState:state];
        }
        [(UIButton *)[_buttonArray objectAtIndex:0] setBackgroundImage:[backgroundImages objectAtIndex:0] forState:state];
        [(UIButton *)[_buttonArray objectAtIndex:_buttonArray.count - 1] setBackgroundImage:[backgroundImages objectAtIndex:2] forState:state];
    }
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (![_buttonArray isEmpty])
    {
        CGFloat width = self.width / _buttonArray.count;
        
        for (int i = 0; i < _buttonArray.count; i++)
        {
            UIButton *button = [_buttonArray objectAtIndex:i];
            [button setFrame:CGRectMake(width * i, 0, width, self.height)];
            
            switch (_itemStyle) {
                case QYSegmentControlItemStyleDefault:
                    break;
                case QYSegmentControlItemStyleHorizontal:
                    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 11, 0, 0)];
                    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 12)];
                    break;
                case QYSegmentControlItemStyleVertical:
                    
                    break;
                default:
                    break;
            }
        }
    }
}

@end
