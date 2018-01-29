//
//  ViewController.m
//  TagButton
//
//  Created by zhaoml on 2017/4/6.
//  Copyright © 2017年 赵明亮. All rights reserved.
//

#import "ViewController.h"
#import "FlagsView.h"

@interface ViewController ()<FlagDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    FlagsView *flag = [[FlagsView alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 100) andFlags:@[@"asdfklalkaskdlj",@"aaskdlj",@"asd",@"asdfklalkdlj",@"as",@"asdfklalkaskdlj",@"asdflalkaskdlj",@"asdfklalkaskdlj",@"asdfklalkaskdlj",@"aslj",@"askdlj",@"asdfklaldlj",@"asdfklkaskdlj",@"asdfklalkaskdlj",@"asdfklalkaskdlj",@"asdfklalkaskdlj",@"asdfkdlj",@"asdfklaskdlj"]];
    flag.ifSingle = NO;
    flag.delegate = self;
    flag.selectIndex = 0;
    [self.view addSubview:flag];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)selectButtonWithIndex:(NSInteger)index andStatus:(BOOL)select {
    NSString *str = @"";
    if (select) {
        str = @"选择了";
    }else{
        str = @"取消了";
    }
    NSLog(@"%@第%ld个",str,index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
