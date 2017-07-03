//
//  ViewController.m
//  LMLoadingHUD
//
//  Created by Mtel on 2017/7/3.
//  Copyright © 2017年 Mtel. All rights reserved.
//

#import "ViewController.h"
#import "LMLoadingHUD.h"
#import "LMSuccessHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始支付" style:UIBarButtonItemStylePlain target:self action:@selector(showLoadingAnimation)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"支付完成" style:UIBarButtonItemStylePlain target:self action:@selector(showSuccessAnimation)];
}

-(void)showLoadingAnimation{
    
    self.title = @"正在付款...";
    [LMSuccessHUD hideIn:self.view];
    [LMLoadingHUD showIn:self.view];
   
}

-(void)showSuccessAnimation{
    
    self.title = @"付款完成";
    [LMLoadingHUD hideIn:self.view];
    [LMSuccessHUD showIn:self.view];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
