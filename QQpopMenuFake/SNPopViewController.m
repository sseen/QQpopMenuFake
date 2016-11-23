//
//  SNPopViewController.m
//  QQpopMenuFake
//
//  Created by sseen on 2016/10/20.
//  Copyright © 2016年 sseen. All rights reserved.
//
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

/**
 * 强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 * 调用方式: `@weakify_self`实现弱引用转换，`@strongify_self`实现强引用转换
 *
 * 示例：
 * @weakify_self
 * [obj block:^{
 * @strongify_self
 * self.property = something;
 * }];
 */
#ifndef    weakify_self
#if __has_feature(objc_arc)
#define weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;
#else
#define weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;
#endif
#endif
#ifndef    strongify_self
#if __has_feature(objc_arc)
#define strongify_self try{} @finally{} __typeof__(weakSelf) self = weakSelf;
#else
#define strongify_self try{} @finally{} __typeof__(blockSelf) self = blockSelf;
#endif
#endif
/**
 * 强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 * 调用方式: `@weakify(object)`实现弱引用转换，`@strongify(object)`实现强引用转换
 *
 * 示例：
 * @weakify(object)
 * [obj block:^{
 * @strongify(object)
 * strong_object = something;
 * }];
 */
#ifndef    weakify
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#endif
#ifndef    strongify
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = block##_##object;
#endif
#endif



#import "SNPopViewController.h"
#import "SNUtil.h"
#import "UIImage+ImageWithColor.h"
#import "UIButton+Sseen.h"
#import "UIGestureRecognizer+Block.h"



@interface SNPopViewController ()

@end

@implementation SNPopViewController


+ (SNPopViewController *)sharedView {
    static SNPopViewController *sharedView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedView = [[SNPopViewController alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return sharedView;
}

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
               action:(void(^)(NSInteger index))action
{
    if (array.count <= 0) {
        return;
    }
    SNPopViewController *view = [SNPopViewController sharedView];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    view.alpha = 0;
    view.point = point;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    // 按钮的容器
    UIView *btnBg = [SNUtil createUIViewWithFrame:CGRectMake(ScreenWidth-width-5, point.y+10, width, btnFloatHeight*array.count) bgColor:nil cornerRadius:5];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        [self hide];
    }];
    [view addGestureRecognizer:tap];
    [view addSubview:btnBg];
    
    for (int i = 0; i < array.count; i++) {
        NSString *title = array[i][@"title"];
        UIImage *image = [UIImage imageNamed:array[i][@"image"]];
        UIButton *btn = [SNUtil createButtonWithFrame:CGRectMake(0, btnFloatHeight*i, width, btnFloatHeight) title:title fontSize:15 titleColor:[UIColor redColor] bgColor:[UIColor whiteColor] action:^{
            if (action) {
                action(i);
            }
            [self hide];
        }];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0 alpha:0.1] size:btn.frame.size] forState:UIControlStateHighlighted];
        [btn setImage:image forState:UIControlStateNormal];
        if (title.length<=3) {// 标题3个字
            [btn setImagePosition:ZXImagePositionLeft spacing:30];
            // 标题与4个字的标题左对齐
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -1, 0, 0)];
        }else if (title.length==4) {
            [btn setImagePosition:ZXImagePositionLeft spacing:15];
        }
        [btnBg addSubview:btn];
        if (i > 0) {
            // 分隔线
            UIView *line = [SNUtil createUIViewWithFrame:CGRectMake(0, btnFloatHeight*i, width, 0.5) bgColor:[UIColor blackColor]];
            [btnBg addSubview:line];
        }
    }
    // show
    // 设置右上角为transform的起点（默认是中心点）
    btnBg.layer.position = CGPointMake(ScreenWidth-5, point.y+10);
    // 向右下transform
    btnBg.layer.anchorPoint = CGPointMake(1, 0);
    btnBg.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 1;
        btnBg.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

+ (void)hide {
    SNPopViewController *view = [SNPopViewController sharedView];
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0;
        view.subviews.firstObject.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        [view removeGestureRecognizer:view.gestureRecognizers.firstObject];
        [view.subviews.firstObject removeFromSuperview];
        [view removeFromSuperview];
        if (view.hideHandle) {
            view.hideHandle();
        }
    }];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    [SNPopViewController hide];
}

#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect
{
    // 设置背景色
    [[UIColor whiteColor] set];
    //拿到当前视图准备好的画板
    CGContextRef  context = UIGraphicsGetCurrentContext();
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    CGPoint point = [SNPopViewController sharedView].point;
    CGContextMoveToPoint(context, point.x, point.y);//设置起点
    CGContextAddLineToPoint(context, point.x-10, point.y+10);
    CGContextAddLineToPoint(context, point.x+10, point.y+10);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [[UIColor whiteColor] setFill];  //设置填充色
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}

@end
