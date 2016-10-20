//
//  SNUtil.h
//  QQpopMenuFake
//
//  Created by sseen on 2016/10/20.
//  Copyright © 2016年 sseen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define  btnFloatHeight  44

@interface SNUtil : NSObject

+ (UIView *)createUIViewWithFrame:(CGRect)frame
                          bgColor:(UIColor *)bgColor;

+ (UIView *)createUIViewWithFrame:(CGRect)frame
                          bgColor:(UIColor *)bgColor
                     cornerRadius:(CGFloat)cornerRadius;

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                           fontSize:(CGFloat)fontSize
                         titleColor:(UIColor *)titleColor
                            bgColor:(UIColor *)bgColor
                             action:(void(^)())action;
@end
