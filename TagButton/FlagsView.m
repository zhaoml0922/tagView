//
//  FlagsView.m
//  TagButton
//
//  Created by zhaoml on 2017/4/6.
//  Copyright © 2017年 赵明亮. All rights reserved.
//

#import "FlagsView.h"

@interface FlagsView()
{
    CGFloat selfWidth;
    NSArray *titleArray;
    NSMutableArray *selectArray;
    NSMutableArray *backViewArr;
}
@end
@implementation FlagsView

- (id)initWithFrame:(CGRect)frame andFlags:(NSArray *)flags {
    self = [super initWithFrame:frame];
    backViewArr = [NSMutableArray array];
    selfWidth = frame.size.width;
    titleArray = [NSArray arrayWithArray:flags];
    if(self){
        selectArray = [NSMutableArray arrayWithCapacity:titleArray.count];
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    
    CGFloat originX = 0.0f;
    CGFloat originY = 20.0f;
    CGFloat lastY = 20.0f;
    for(int i=0;i<titleArray.count;i++){
        [selectArray addObject:@"0"];
        NSString *flag = titleArray[i];
        CGFloat width = [self getWidthWithStr:flag andHeight:15 andTextFont:13]+20;
        width = (width>selfWidth)?selfWidth:width;
        originY = ((width+originX)>selfWidth)?originY+30+10:originY;
        originX = ((width+originX)>selfWidth)?0:originX;
        
        UIButton *flagBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        flagBtn.frame = CGRectMake(originX,originY, width, 30);
        [flagBtn setTitle:flag forState:UIControlStateNormal];
        flagBtn.layer.cornerRadius = 5;
        flagBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        flagBtn.layer.borderWidth = 0.5;
        [self deSelectButtonStatusWithButton:flagBtn];
        flagBtn.tag = 100000+i;
        [flagBtn addTarget:self action:@selector(flagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        originX = ((width+originX)>selfWidth)?0:(width+originX)+5;
        [self addSubview:flagBtn];
        
        if (lastY != originY) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            [self addSubview:view];
        }
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, originY+25);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, selfWidth, self.frame.size.height);
    }
}

- (void)setIfSingle:(BOOL)ifSingle {
    _ifSingle = ifSingle;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    for (int i=0; i<titleArray.count; i++) {
        UIButton *buton = [self viewWithTag:100000+i];
        if (i == selectIndex) {
            [self selectButtonStatusWithButton:buton];
        }else{
            [self deSelectButtonStatusWithButton:buton];
        }
    }
    [selectArray replaceObjectAtIndex:selectIndex withObject:@"1"];
}

- (void)selectButtonStatusWithButton:(UIButton *)button {
   
   [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.backgroundColor = [UIColor blueColor];
    
}

- (void)deSelectButtonStatusWithButton:(UIButton *)button {
    button.selected = NO;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.backgroundColor = [UIColor whiteColor];
}

- (void)flagBtnClick:(UIButton *)button {
    NSInteger index = button.tag - 100000;
    [selectArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%d",![selectArray[index] intValue]]];
    for (int i=0; i<titleArray.count; i++) {
        UIButton *buton = [self viewWithTag:100000+i];
        if (buton.tag == button.tag) {
            if (_ifSingle) {
                [self selectButtonStatusWithButton:buton];
            }else{
                
                if ([selectArray[i] intValue] == 0) {
                    [self deSelectButtonStatusWithButton:buton];
                }else{
                    [self selectButtonStatusWithButton:buton];
                }
            }
        }else{
            if (_ifSingle) {
              [self deSelectButtonStatusWithButton:buton];
            }
        }
    }
    [self.delegate selectButtonWithIndex:index andStatus:[selectArray[index] intValue]];
}

- (CGFloat)getWidthWithStr:(NSString *)str andHeight:(CGFloat)height andTextFont:(int)num {
    if(str.length>0)
    {
        CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:num]} context:nil];
        float wight = rect.size.width;
        return wight+2;
    }else{
        return 5;
    }
}



@end
