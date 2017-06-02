//
//  ViewController.m
//  ZCXScrollLabel
//
//  Created by ZhangCX on 2017/6/2.
//  Copyright © 2017年 ZhangCX. All rights reserved.
//

#import "ViewController.h"
#import "ZCXScrollLabel.h"
#import "UIView+ZCXExtention.h"

@interface ViewController ()<ZCXScrollLabelDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"iPhone6s上线32G内存手机你怎么看？",@"亲爱的朋友们2016年还有100天就要过去了,2017年您准备好了吗?",@"今年双11您预算了几个月的工资？",@"高德与百度互掐，你更看好哪方？", nil];
    
    ZCXScrollLabel *scrollLabel = [[ZCXScrollLabel alloc]initWithFrame:CGRectMake(40, 200, 400, 65) titleArray:titleArr];
    scrollLabel.scrollLabelDelegate = self;
    scrollLabel.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:scrollLabel];
}

- (void)titleLabelClick:(NSInteger)index info:(id)info{
    NSLog(@"%ld = %@",(long)index,info);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
