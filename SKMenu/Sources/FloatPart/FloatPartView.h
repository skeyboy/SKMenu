//
//  FloatPartView.h
//  LoginPart
//
//  Created by 李雨龙 on 2018/5/31.
//  Copyright © 2018年 gener-tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@class FloatPartItemView;
@class FloatPartView;
@class FloatIconItem;

typedef void(^FloatPartMenuBlock)(FloatPartItemView * callbackResult);


/**
 FloatPartView * floatView = [FloatPartView defaultPositionView];
 floatView.menuCallBack = ^(FloatPartItemView* callbackResult) {
 
 };
 */
@interface FloatPartView : UIView

/**
 @note 此为单例

 */
+(FloatPartView *)defaultPositionView;
/**
 导入作为pod的时候需要手动设置为YES， 否则会出现加载本地库引入的资源文件无法加载
 */
@property(assign, nonatomic) BOOL asLibrary;
@property(assign, nonatomic) CGFloat margin;
@property(copy, nonatomic) UIFont * defaultFont;
@property(assign, nonatomic) BOOL asLib;

@property(copy, nonatomic) FloatPartMenuBlock menuCallBack;
- (NSBundle *)podLibraryBundle:(NSString *) podName ;
 -(void)add:(FloatPartItemView *) item;
- (void)showFloatMenu;
- (void)hideFloatMenu;

@property(assign, nonatomic) NSInteger selctedIndex;

/**
 这个属性暂时不用，只用于获取菜单项
 */
@property(copy, nonatomic) NSArray  * menus;
@end
