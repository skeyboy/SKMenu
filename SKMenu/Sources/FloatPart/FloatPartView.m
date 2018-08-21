//
//  FloatPartView.m
//  LoginPart
//
//  Created by 李雨龙 on 2018/5/31.
//  Copyright © 2018年 gener-tech. All rights reserved.
//

#import "FloatPartView.h"
#import "FloatPartItemView.h"
#import "FloatIconItem.h"
@interface FloatPartView()<FloatPartItemViewProtocol>
{
  __block  NSMutableArray * _items;
}
@end

@implementation FloatPartView

@synthesize selctedIndex = _selctedIndex;
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
-(NSInteger)selctedIndex{
    return  _selctedIndex;
}
-(void)setSelctedIndex:(NSInteger)selctedIndex{
    _selctedIndex = selctedIndex;
}

+ (FloatPartView *)defaultPositionView {
    static dispatch_once_t onceToken;
    static FloatPartView * defaultPositionView = nil;
    dispatch_once(&onceToken, ^{
        CGRect main = UIScreen.mainScreen.bounds;
        CGRect selfFrame = CGRectMake(300, 400, 600/2, 100/2);
        
       defaultPositionView = [[FloatPartView alloc] initWithFrame:selfFrame];
        defaultPositionView.defaultFont = [UIFont systemFontOfSize:13];
        defaultPositionView.frame = CGRectMake(CGRectGetWidth(main)/2-CGRectGetWidth(selfFrame)/2, CGRectGetHeight(main)-CGRectGetHeight(selfFrame)-50, CGRectGetWidth(selfFrame), CGRectGetHeight(selfFrame));
        
        NSBundle * bundle =[defaultPositionView podLibraryBundle:@"FloatPart"];
        
        NSString * bgPath = [bundle pathForResource:@"bacground@2x" ofType:@"png"];
        UIColor * bgColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:bgPath]];
        defaultPositionView.backgroundColor = bgColor ;
        
        NSArray *menus = @[
                           [[FloatIconItem alloc] initNormalIconName:@"tlb" selectedIconName:@"tlb_pre"],
                           [[FloatIconItem alloc] initNormalIconName:@"flb" selectedIconName:@"flb_pre"],
                           [[FloatIconItem alloc] initNormalIconName:@"clb" selectedIconName:@"clb_pre"],
                           [[FloatIconItem alloc] initNormalIconName:@"dd" selectedIconName:@"dd_pre"],
                           ];
        defaultPositionView.menus = menus;
    });
  
    return  defaultPositionView;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        _items = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        _items = [NSMutableArray array];
    }
    if (self.defaultFont == nil) {
        self.defaultFont = [UIFont systemFontOfSize:13];
    }
    return self;
    
}


- (void)panFloatView:(UIPanGestureRecognizer *) pan {
   CGPoint translation = [pan translationInView:pan.view.superview];
    UIView * piece = pan.view;
    self.center = CGPointMake([piece center].x + translation.x, [piece center].y + translation.y);
    [pan setTranslation:CGPointZero inView:self.superview];
}
-(void)add:(FloatPartItemView *)item{
    if (self.superview == nil) {
        [[UIApplication sharedApplication].windows.lastObject makeKeyAndVisible];

        [[UIApplication sharedApplication].windows.lastObject addSubview:self];
        
        UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panFloatView:)];
        [self addGestureRecognizer:panGesture];
    }
    if ([_items containsObject:item]) {
        return;
    }else{
        [_items addObject:item];
        item.tag = _items.count;
        item.asLib = self.asLibrary;
    }

    for (FloatPartItemView * aItem in _items) {
        [aItem removeFromSuperview];
        
    }
  __block  FloatPartItemView * tmpItem = nil;
   __block __weak FloatPartView *weakSelf =  self;
    for (FloatPartItemView* aItem in _items) {
        [self addSubview:aItem];
        aItem.font = self.defaultFont;
        aItem.delegate = self;
        [aItem mas_updateConstraints:^(MASConstraintMaker *make) {

            if (tmpItem == nil) {
                make.top.bottom.equalTo(weakSelf);
                make.left.equalTo(weakSelf).offset(25);
            }else{
                make.top.bottom.equalTo(weakSelf);
                
                make.left.equalTo(tmpItem.mas_right);
                make.width.height.equalTo(tmpItem);

            }
            
            if ([aItem isEqual: self->_items.lastObject]) {
//                make.right.equalTo(weakSelf).offset(-25);
                make.right.equalTo(weakSelf.mas_right).offset(-25);
            }
            
            
        }];
        tmpItem = aItem;
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.cornerRadius = CGRectGetHeight(self.frame)/2/2;
//    self.backgroundColor = [UIColor blackColor];
//    self.alpha = 0.75;
}
-(void)hideFloatMenu{
    self.hidden = YES;
}
- (void)showFloatMenu{
    self.hidden = NO;
}

-(void)setDefaultFont:(UIFont *)defaultFont{
    _defaultFont = defaultFont;
    for (FloatPartItemView * item in _items) {
        item.font = _defaultFont;
    }
}
#pragma FloatItem delegate
- (void)onItemSelected:(FloatPartItemView *)item{
    NSLock * lock = [[NSLock alloc] init];
    [lock lock];
    [[NSNotificationCenter defaultCenter] postNotificationName:FloatMenuChangedNotification object:@{FloatMenuSelectedIndexKey:@(item.tag)}];
    [lock unlock];
    for (FloatPartItemView * itemView in _items) {
        [itemView performSelector:@selector(resetNormal)];
    }
    if (self.menuCallBack) {
        
        self.menuCallBack(item);//暂定为把被点击条目返回
    }
    
}
@synthesize menuCallBack = _menuCallBack;
- (void)setMenuCallBack:(FloatPartMenuBlock)menuCallBack{
    _menuCallBack = menuCallBack;
    NSAssert(_selctedIndex < _items.count, @"默认选择条目必须在菜单范围内");
    if (self.menuCallBack && _items.count) {
        FloatPartItemView * item = _items[self.selctedIndex];
        item.selected = YES;
        self.menuCallBack(_menus[_selctedIndex]);//暂定为把被点击条目返回
    }
}
-(FloatPartMenuBlock)menuCallBack{
    return _menuCallBack;
}
-(void)setMenus:(NSArray<FloatIconItem *> *)menus{
    NSInteger index = 0;
    for (FloatIconItem * item in menus) {
        
        FloatPartItemView * partItemView = [[FloatPartItemView alloc] init];
        partItemView.iconItem = item;
        partItemView.delegate = self;
        partItemView.tag = index++;
        [self add:partItemView];
    }
   
}
@end
