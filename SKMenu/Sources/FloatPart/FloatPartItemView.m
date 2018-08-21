//
//  FloatPartItemView.m
//  LoginPart
//
//  Created by 李雨龙 on 2018/5/31.
//  Copyright © 2018年 gener-tech. All rights reserved.
//

#import "FloatPartItemView.h"
#import "Masonry.h"
#import "FloatIconItem.h"
@interface FloatPartItemView()
{
   __block UIImageView * _iconView;
   __block UILabel * _titleView;
}

@end


@implementation FloatPartItemView
@synthesize iconItem = _iconItem;
- (void)onItemTaped:(UITapGestureRecognizer *) tap {
    if (self.delegate) {
        [self.delegate onItemSelected:self];
        [self restToSelected];
    }
}
- (NSBundle *)podLibraryBundle:(NSString *) podName {
   
    if (!self.asLib) {
        return  [NSBundle mainBundle];

    } else {
        NSBundle * bundle =[NSBundle bundleForClass:self.class];
        NSURL * url = [bundle URLForResource:podName
                               withExtension:@"bundle"];
        NSBundle *libBundle = [NSBundle bundleWithURL:url];
        
        return libBundle;
    }
}
-(void)setFont:(UIFont *)font {
    _font = font;
    if (_titleView) {
        _titleView.font = _font;
    }
}
-(void)update{
    __weak FloatPartItemView * weakSelf = self;
    [_iconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.mas_top).offset(17/2);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-17/2);
//
 
        make.leading.trailing.greaterThanOrEqualTo(@5);
        make.width.equalTo(@(41/2));
        make.height.equalTo(@(76/2));
    }];
    
//    [_titleView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakSelf);
//        make.bottom.equalTo(weakSelf.mas_bottom).offset(-5);
//        make.leading.trailing.greaterThanOrEqualTo(@5);
//    }];
}

- (void)setImageName:(NSString *)imageName{
    if (_iconView == nil) {
        _iconView = [UIImageView new];
       
        [self addSubview:_iconView];
        

        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(onItemTaped:)];
        [_iconView addGestureRecognizer:tap];
        _iconView.userInteractionEnabled = YES;
    }
    NSString * extension =  imageName.pathExtension;
    NSString * name = [imageName componentsSeparatedByString:@"."].firstObject;
    if (extension.length <= 0) {
        extension = @"png";
    }
    
    NSString *imgPath = [[self podLibraryBundle:@"FloatPart"] pathForResource:name ofType:extension];
    _iconView.image = [UIImage imageWithContentsOfFile:imgPath];
    [self update];

}
-(void)setIconItem:(FloatIconItem *)iconItem{
    _iconItem = iconItem;
    self.normalIcon = _iconItem.normalIconName;
    self.selectedIcon = _iconItem.selctedIconName;
    self.imageName = self.normalIcon;
}
-(FloatIconItem *)iconItem{
    return _iconItem;
}
-(void)setTitle:(NSString *)title{
    if (_titleView == nil) {
        _titleView = [UILabel new];
        [self addSubview:_titleView];
    }
    _titleView.textAlignment = NSTextAlignmentCenter;
    _titleView.text = [title copy];
    if (self.titleColor == nil) {
        _titleView.textColor = [UIColor whiteColor];
    }else{
        _titleView.textColor = self.titleColor;
    }
    [self update];

}
- (void)restToSelected{
    [self setImageName:self.selectedIcon];
}
-(void)resetNormal{
    [self setImageName:self.normalIcon];
}
@synthesize selected = _selected;
-(void)setSelected:(BOOL)selected{
    _selected = selected;
   
    [self restToSelected];
}
-(BOOL)selected{
    return _selected;
}
@end

NSString * const FloatMenuChangedNotification = @"LoginPart/FloatMenuChangedNotification";
NSString * const FloatMenuSelectedIndexKey =@"LoginPart/FloatMenuSelectedIndexKey";
