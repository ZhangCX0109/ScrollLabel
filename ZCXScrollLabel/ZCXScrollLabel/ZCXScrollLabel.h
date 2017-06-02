//
//  ZCXScrollLabel.h
//  ZCXScrollLabel
//
//  Created by ZhangCX on 2017/6/2.
//  Copyright © 2017年 ZhangCX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZCXScrollLabelDelegate

- (void)titleLabelClick:(NSInteger)index info:(id)info;

@end

@interface ZCXScrollLabel : UIView
@property (nonatomic, strong)id<ZCXScrollLabelDelegate> scrollLabelDelegate;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;
- (void)nextLabel;

- (void)removeTimer;

- (void)addTimer;

- (void)setTitleLabel;

@end
