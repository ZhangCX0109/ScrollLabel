//
//  ZCXScrollLabel.m
//  ZCXScrollLabel
//
//  Created by ZhangCX on 2017/6/2.
//  Copyright © 2017年 ZhangCX. All rights reserved.
//

#import "ZCXScrollLabel.h"
#import "UIView+ZCXExtention.h"

#define SCROLL_DELAY 3.0

@interface ZCXScrollLabel ()<UIScrollViewDelegate>
/**
 *  滚动视图
 */
@property (nonatomic,strong) UIScrollView *ZCXScrollView;
/**
 *  label的宽度
 */
@property (nonatomic,assign) CGFloat labelW;
/**
 *  label的高度
 */
@property (nonatomic,assign) CGFloat labelH;
/**
 *  定时器
 */
@property (nonatomic,strong) NSTimer *timer;
/**
 *  记录滚动的页码
 */
@property (nonatomic,assign) int page;
/* 数据数组 */
@property (nonatomic, copy)NSArray *titleArray;

@end

@implementation ZCXScrollLabel
#pragma mark - 初始化相关
//单例模式创建scrollView
-(UIScrollView *)ZCXScrollView{
    if (_ZCXScrollView == nil) {
        _ZCXScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _ZCXScrollView.showsVerticalScrollIndicator = NO;
        _ZCXScrollView.showsHorizontalScrollIndicator = NO;
        _ZCXScrollView.scrollEnabled = NO;
        _ZCXScrollView.pagingEnabled = YES;
        [self addSubview:_ZCXScrollView];
        
        [_ZCXScrollView setContentOffset:CGPointMake(0, self.labelH) animated:YES];
        
    }
    
    return _ZCXScrollView;
}
//单利创建数组
- (NSArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = [[NSArray alloc]init];
    }
    return _titleArray;
}
/* 初始化 */
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.labelW = frame.size.width;
        self.labelH = frame.size.height;
        self.titleArray = [titleArray copy];
        
        self.ZCXScrollView.delegate = self;
        
        [self setTitleLabel];
        
        [self addTimer];
    }
    return self;
}
#pragma mark - 创建label
- (void)setTitleLabel{
    if (_titleArray.count == 1) {
        [self removeTimer];
    }
    
    id lastObj = [_titleArray lastObject];
    /* 创建一个新数组，把原数组最后一个放在新数组的第一位，最后一位仍然是原数组的最后一位 */
    NSMutableArray *newTitleArr = [[NSMutableArray alloc]init];
    [newTitleArr addObject:lastObj];
    [newTitleArr addObjectsFromArray:_titleArray];
    _titleArray = [newTitleArr copy];
    
    CGFloat contentH = self.labelH * newTitleArr.count;
    self.ZCXScrollView.contentSize = CGSizeMake(0, contentH);
    /* 设置label的size */
    CGFloat labelW = self.ZCXScrollView.frame.size.width;
    CGFloat labelH = self.ZCXScrollView.frame.size.height;
    self.labelW = labelW;
    self.labelH = labelH;
    CGFloat labelX = 0;
    /* 遍历 */
    [self.ZCXScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    /* 创建label */
    for (int i = 0; i < newTitleArr.count; i++) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.userInteractionEnabled = YES;
        titleLabel.tag = 100 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTheLabel:)];
        
        [titleLabel addGestureRecognizer:tap];
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        CGFloat labelY = i * labelH;
        
        titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
        titleLabel.text = newTitleArr[i];
        
        [self.ZCXScrollView addSubview:titleLabel];
    }
    
}
#pragma mark - label点击事件和代理
-(void)clickTheLabel:(UITapGestureRecognizer *)tap{
    NSInteger tag = tap.view.tag - 100;
    NSLog(@"%ld",(long)tag);
    if (tag < 0) {
        tag = 100 + (self.titleArray.count - 1);
    }
    [self.scrollLabelDelegate titleLabelClick:tag info:_titleArray[tag]];
}

#pragma mark - 定时器
- (void)addTimer{
    self.timer = [NSTimer timerWithTimeInterval:SCROLL_DELAY target:self selector:@selector(nextLabel) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer{
    if (self.timer == nil) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
}
- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextLabel{
    CGPoint oldPoint = self.ZCXScrollView.contentOffset;
    oldPoint.y += self.ZCXScrollView.frame.size.height;
    [self.ZCXScrollView setContentOffset:oldPoint animated:YES];
}
#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /* 当滚动到顶部，回到原位 */
    if(self.ZCXScrollView.contentOffset.y == self.ZCXScrollView.frame.size.height * (self.titleArray.count - 1)){
        [self.ZCXScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
@end
