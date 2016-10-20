//
//  SNUtil.m
//  QQpopMenuFake
//
//  Created by sseen on 2016/10/20.
//  Copyright © 2016年 sseen. All rights reserved.
//

#import "SNUtil.h"
#import "UIControl+YYAdd.h"

@implementation SNUtil

+ (UIView *)createUIViewWithFrame:(CGRect)frame
                          bgColor:(UIColor *)bgColor
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = bgColor;
    return view;
}

+ (UIView *)createUIViewWithFrame:(CGRect)frame
                          bgColor:(UIColor *)bgColor
                     cornerRadius:(CGFloat)cornerRadius
{
    UIView *view = [self createUIViewWithFrame:frame bgColor:bgColor];
    if (cornerRadius > 0) {
        view.clipsToBounds = YES;
        view.layer.cornerRadius = cornerRadius;
    }
    return view;
}


+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                           fontSize:(CGFloat)fontSize
                             action:(void(^)())action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    if (fontSize > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        if (action) {
            action();
        }
    }];
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                           fontSize:(CGFloat)fontSize
                         titleColor:(UIColor *)titleColor
                            bgColor:(UIColor *)bgColor
                             action:(void(^)())action
{
    UIButton *button = [self createButtonWithFrame:frame title:title fontSize:fontSize action:action];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor = bgColor;
    return button;
}


@end
