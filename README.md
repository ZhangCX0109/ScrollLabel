# ScrollLabel

#import "ZCXScrollLabel.h"

@interface ViewController ()<ZCXScrollLabelDelegate>

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *titleArr = [NSArray arrayWithObjects:@"1111111111111",@"2222222222222222",@"33333333333333333333333333",@"4444444444444", nil];

    ZCXScrollLabel *scrollLabel = [[ZCXScrollLabel alloc]initWithFrame:CGRectMake(40, 200, 400, 65) titleArray:titleArr];
    scrollLabel.scrollLabelDelegate = self;
    scrollLabel.backgroundColor = [UIColor redColor];

    [self.view addSubview:scrollLabel];
}

- (void)titleLabelClick:(NSInteger)index info:(id)info{
    /* Now, info is an Object in titleArr,You can customize it */
    NSLog(@"%ld = %@",(long)index,info);
}

- (void)didReceiveMemoryWarning {
[super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}


@end
