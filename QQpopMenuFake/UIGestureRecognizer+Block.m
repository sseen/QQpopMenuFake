//
//  UIGestureRecognizer+Block.m
//  QQpopMenuFake
//
//  Created by sseen on 2016/10/20.
//  Copyright © 2016年 sseen. All rights reserved.
//

#import <objc/message.h>    
#import "UIGestureRecognizer+Block.h"


static const int target_key;
@implementation UIGestureRecognizer (Block)
+(instancetype)nvm_gestureRecongnizerWithActionBlock:(NVMGertureBlock)Block
{
    return [[self alloc]initWithActionBlock:Block];
}
-(instancetype)initWithActionBlock:(NVMGertureBlock)Block
{
    self = [self init];
    [self addActionBlock:Block];
    [self addTarget:self action:@selector(invoke:)];
    return self;
    
}
-(void)addActionBlock:(NVMGertureBlock)block
{
    if (block) {
        objc_setAssociatedObject(self, &target_key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}
-(void)invoke:(id)sender
{
    NVMGertureBlock block = objc_getAssociatedObject(self, &target_key);
    if (block) {
        block(sender);
    }
}
@end
