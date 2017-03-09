//
//  SecondViewController.m
//  QQpopMenuFake
//
//  Created by sseen on 2016/11/23.
//  Copyright © 2016年 sseen. All rights reserved.
//

#import "SecondViewController.h"
#import "SNTableViewCell.h"

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    
    [self.view addSubview:_mainTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - talbe

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
    cell.lblTitle.text = @"ok";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _blockCKItem(indexPath.row);
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
