//
//  SecondViewController.h
//  QQpopMenuFake
//
//  Created by sseen on 2016/11/23.
//  Copyright © 2016年 sseen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ckItem)(NSInteger index);

@interface SecondViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (strong, nonatomic) ckItem blockCKItem;

@end
