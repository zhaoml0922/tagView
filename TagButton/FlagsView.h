//
//  FlagsView.h
//  TagButton
//
//  Created by zhaoml on 2017/4/6.
//  Copyright © 2017年 赵明亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FlagDelegate <NSObject>


/**
 选择哪个按钮

 @param index 选的那个按钮
 @param select yes是选择   no是取消选择
 */
- (void)selectButtonWithIndex:(NSInteger)index andStatus:(BOOL)select;

@end

@interface FlagsView : UIView

- (id)initWithFrame:(CGRect)frame andFlags:(NSArray *)flags;

////选择第几个 
@property (nonatomic,assign)NSInteger selectIndex;

///是否为单选
@property (nonatomic,assign)BOOL ifSingle;

@property (nonatomic,strong)id<FlagDelegate>delegate;


@end
