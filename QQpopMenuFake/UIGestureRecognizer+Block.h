//
//  UIGestureRecognizer+Block.h
//  QQpopMenuFake
//
//  Created by sseen on 2016/10/20.
//  Copyright © 2016年 sseen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NVMGertureBlock)(id gesture);

@interface UIGestureRecognizer (Block)

+(instancetype)nvm_gestureRecongnizerWithActionBlock:(NVMGertureBlock)Block;
-(instancetype)initWithActionBlock:(NVMGertureBlock)Block;

@end
