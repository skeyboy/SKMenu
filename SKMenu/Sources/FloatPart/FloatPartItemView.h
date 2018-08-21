//
//  FloatPartItemView.h
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

@protocol FloatPartItemViewProtocol <NSObject>

- (void)onItemSelected:(FloatPartItemView *) item;

@end


@interface FloatPartItemView : UIView
@property(assign, nonatomic) id<FloatPartItemViewProtocol> delegate;
@property(assign, nonatomic) BOOL asLib;
/**
 对应的title
 */
@property(copy, nonatomic) NSString * title;

/**
 本地资源图片名称
 */
@property(copy, nonatomic) NSString * imageName;

/**
 被选中时展示的icon
 */
@property(copy, nonatomic) NSString * selectedIcon;

/**
 未被选中时的icon
 */
@property(copy, nonatomic) NSString * normalIcon;

@property(retain, nonatomic) FloatIconItem * iconItem;
/**
 文本的颜色
 */
@property(copy, nonatomic) UIColor * titleColor;

/**
 文本的字体
 */
@property(copy, nonatomic) UIFont * font;

/**
 是否被选中
 */
@property(assign, nonatomic) BOOL selected;
@end


UIKIT_EXTERN NSString * const FloatMenuChangedNotification;
UIKIT_EXTERN NSString * const FloatMenuSelectedIndexKey;
