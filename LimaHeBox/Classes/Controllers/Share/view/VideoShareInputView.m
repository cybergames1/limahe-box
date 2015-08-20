//
//  VideoShareInputView.m
//  PaPaQi
//
//  Created by Sean on 14/12/17.
//  Copyright (c) 2014年 iQiYi. All rights reserved.
//

#import "VideoShareInputView.h"
#import <FTUIKit/FTInputView.h>
#import <Category/Category.h>
#import "CommonTools.h"

enum {
    KeyboardWillShow,
    KeyboardWillHide,
};
typedef NSInteger KeyboardWillType;

@interface VideoShareInputView  ()
<FTInputViewDelegate>
{
    FTInputView*  _inputView;
    UILabel*      _wordLimitLabel;
    CGFloat _selfTop;
}
@end

@implementation VideoShareInputView
- (void)dealloc
{
    _inputView.delegate = nil;
    [_inputView release];
    [_wordLimitLabel release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // input view
        _inputView = [[FTInputView alloc] initWithFrame:CGRectMake(0, 0.0f, KDefaultScreenWidth-20, 62.0f) delegate:self];
        _inputView.fontSize = 14.0f;
        _inputView.placeholderStyle = FTPlaceholderStyleTop;
        _inputView.placeholder = @"点击添加描述(必填)";
        _inputView.borderStyle = FTInputBorderStyleNone;
        _inputView.borderColor = UIColorRGB(199, 197, 197);
        _inputView.fitStyle = FTFitStyleNone;
        _inputView.backgroundColor = self.backgroundColor;
        _inputView.textColor = UIColorRGB(56.0f, 56.0f, 56.0f);
        _inputView.returnKeyType = UIReturnKeyDone;
        [self addSubview:_inputView];
        
        // word limie
        _wordLimitLabel = [[UILabel alloc] initWithFrame:CGRectMake(KDefaultScreenWidth-104 , 64, 80, 12)];
        _wordLimitLabel.text = @"0/140";
        _wordLimitLabel.textAlignment = NSTextAlignmentRight;
        _wordLimitLabel.font = [UIFont systemFontOfSize:10.0f];
        _wordLimitLabel.textColor = UIColorRGB(176.0f, 176.0f, 176.0f);;
        _wordLimitLabel.backgroundColor = self.backgroundColor;
        _wordLimitLabel.numberOfLines = 1;
        [self addSubview:_wordLimitLabel];
    }
    return self;
}

- (void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)becomeFirstResponder
{
    return [_inputView becomeFirstResponder];
}
- (BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    return [_inputView resignFirstResponder];
}
- (BOOL)isFirstResponder
{
    return [_inputView isFirstResponder];
    
}
- (NSString*) content
{
    return [NSString trimString:_inputView.text];
}

- (NSInteger)inputTextCount {
    return _inputView.userInputTextCount;
}

#pragma mark insert
- (void) insertContent:(NSString *)content atIndex:(NSInteger)index
{
    if ([CommonTools isEmptyString:content]) {
        return;
    }
    if ([CommonTools isEmptyString:_inputView.text]) {
        _inputView.text = [NSString stringWithFormat:@"%@ ",content];
    }
    else if (index <= 0) {
        _inputView.text = [NSString stringWithFormat:@"%@ %@",content,_inputView.text];
    }
    else if (index >= [_inputView.text length]){
        _inputView.text = [NSString stringWithFormat:@"%@ %@",_inputView.text,content];
    }
    else{
        _inputView.text = [NSString stringWithFormat:@"%@ %@ %@",[_inputView.text substringToIndex:index],content,[_inputView.text substringFromIndex:index+1]];
    }
}

#pragma mark FTInputViewDelegate
- (void) inputViewDidBeginEditing:(FTInputView*) inputView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputViewWillBeginEdit)]) {
        [self.delegate inputViewWillBeginEdit];
    }
}

- (void) inputViewDidTouchesDoneButton:(FTInputView*) inputView
{
    [_inputView resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputViewDidFinish:)]) {
        [self.delegate inputViewDidFinish:_inputView.text];
    }
}
- (void) inputViewDidChange:(FTInputView*) inputView
{
    NSInteger wordCount = inputView.userInputTextCount;
    _wordLimitLabel.text = [NSString stringWithFormat:@"%ld/140",(long)wordCount];
    if (wordCount > 140){
        _wordLimitLabel.textColor = [UIColor redColor];
    }
    else{
        _wordLimitLabel.textColor = [UIColor grayColor];
    }
}

#pragma mark -
#pragma mark KeyboardNotification 

- (void)keyboardWillShown:(NSNotification *)notification {
    [self showWithKeyboardWill:KeyboardWillShow keyboadUserInfo:[notification userInfo]];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self showWithKeyboardWill:KeyboardWillHide keyboadUserInfo:[notification userInfo]];
}

- (void)showWithKeyboardWill:(KeyboardWillType)willType keyboadUserInfo:(NSDictionary *)userInfo {
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = [value CGRectValue].size.height;
    
    /**
     * 先获取控件在window上的位置
     * 然后算出，键盘弹起或回落时,控件应该在的位置，两者做个比较
     * canShow=YES表示，在键盘弹起时，键盘会挡住控件;回落时控件需要回归原始位置
     * _seltTop是控件的原始位置
     */
    BOOL canShow = NO;
    CGFloat beginTop,endTop;
    
    if (willType == KeyboardWillShow) {
        if (_selfTop <= 0.0) {
            _selfTop = [self convertRect:self.bounds toView:[CommonTools keyWindow]].origin.y;
        }
        
        beginTop = [self convertRect:self.bounds toView:[CommonTools keyWindow]].origin.y;
        endTop = kDefaultScreenHeight-keyboardHeight-self.height-5;
        canShow = (endTop<beginTop) ? YES : NO;
    }else {
        beginTop = [self convertRect:self.bounds toView:[CommonTools keyWindow]].origin.y;
        endTop = _selfTop;
        canShow = (endTop>beginTop) ? YES : NO;
    }
    
    if (canShow) {
        [UIView animateWithDuration:0.25
                              delay:0.25
                            options:UIViewAnimationOptionCurveLinear
                         animations:^
         {
             for (UIView *view in [VideoShareInputView viewControllerForView:self].view.subviews) {
                 view.top += endTop-beginTop;
             }
         }
                         completion:nil];
    }
}

/**
 * 包括控件在内的UIViewController内的所有子view都一起动
 **/
+ (UIViewController *)viewControllerForView:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
