//
//  ViewController.m
//  QQpopMenuFake
//
//  Created by sseen on 2016/10/20.
//  Copyright © 2016年 sseen. All rights reserved.
//

#import "ViewController.h"
#import "QQPopMenuView.h"
#import "SNPopViewController.h"
#import "SecondViewController.h"

@interface ViewController () <UIPopoverPresentationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

- (IBAction)ckTop:(UIButton *)sender {
    SecondViewController *pop = [[SecondViewController alloc] init];
    
    pop.modalPresentationStyle = UIModalPresentationPopover;
    pop.popoverPresentationController.delegate = self;
    pop.popoverPresentationController.sourceView = sender;
    pop.popoverPresentationController.sourceRect = sender.bounds;
    
    [self presentViewController:pop animated:true completion:nil];
    
}


- (IBAction)ckPop:(id)sender {
    [SNPopViewController showWithItems:@[@{@"title":@"发起讨论",@"image":@"session_popMenu_createChat_icon"},
                                   @{@"title":@"扫描名片",@"image":@"session_popMenu_scanCard_icon"},
                                   @{@"title":@"写日报",@"image":@"session_popMenu_writeReport_icon"},
                                   @{@"title":@"外勤签到",@"image":@"session_popMenu_signIn_icon"}]
                           width:130
                triangleLocation:CGPointMake(300-30, 64+5)
                          action:^(NSInteger index) {
                          }];
}

@end
