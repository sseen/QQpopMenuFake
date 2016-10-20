//
//  QQPopMenuView.h
//  QQpopMenuFake
//
//  Created by sseen on 2016/10/20.
//  Copyright © 2016年 sseen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQPopMenuView : UIView

@property (nonatomic, copy) void (^hideHandle)();
@property (nonatomic, copy) void (^action)(NSInteger index);

+ (QQPopMenuView *)sharedView;

/**
 *  类方法展示
 *
 *  @param array  items，包含字典，字典里面包含标题（title）、图片名（image）
 *  @param width  宽度
 *  @param point  三角的顶角坐标（基于window）
 *  @param action 点击回调
 */
+ (void)showWithItems:(NSArray <NSDictionary *>*)array
                width:(CGFloat)width
     triangleLocation:(CGPoint)point
               action:(void(^)(NSInteger index))action;

@end
