//
//  QQPopMenuView.m
//  QQpopMenuFake
//
//  Created by sseen on 2016/10/20.
//  Copyright © 2016年 sseen. All rights reserved.
//

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

#define weakify(var) __weak typeof(var) AHKWeak_##var = var;

#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = AHKWeak_##var; \
_Pragma("clang diagnostic pop")


#import "QQPopMenuView.h"
#import "UIButton+Sseen.h"
#import "UIImage+ImageWithColor.h"

#import "SNUtil.h"



@interface QQPopMenuView ()
@property (nonatomic, assign) CGPoint point;
@end

@implementation QQPopMenuView

+ (QQPopMenuView *)sharedView {
    static QQPopMenuView *sharedView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedView = [[QQPopMenuView alloc] initWithFrame:[UIScreen mainScreen].bounds];
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
    QQPopMenuView *view = [QQPopMenuView sharedView];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    view.alpha = 0;
    view.point = point;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    // 按钮的容器
    UIView *btnBg = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth-width-5, point.y+10, width, btnFloatHeight*array.count)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [view addGestureRecognizer:tap];
    [view addSubview:btnBg];
    
    for (int i = 0; i < array.count; i++) {
        NSString *title = array[i][@"title"];
        UIImage *image = [UIImage imageNamed:array[i][@"image"]];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, btnFloatHeight*i, width, btnFloatHeight)];
        [btn addTarget:self action:@selector(ckButton:) forControlEvents:UIControlEventTouchUpInside];

        
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
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, btnFloatHeight*i, width, 0.5)];
            line.backgroundColor = [UIColor orangeColor];
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
    QQPopMenuView *view = [QQPopMenuView sharedView];
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
    [self.class hide];
}

- (void)ckButton:(UIButton *)sender {
    
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
    CGPoint point = [QQPopMenuView sharedView].point;
    CGContextMoveToPoint(context, point.x, point.y);//设置起点
    CGContextAddLineToPoint(context, point.x-10, point.y+10);
    CGContextAddLineToPoint(context, point.x+10, point.y+10);
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [[UIColor whiteColor] setFill];  //设置填充色
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}

@end
