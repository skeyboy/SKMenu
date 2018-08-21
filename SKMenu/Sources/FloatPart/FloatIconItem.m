//
//  FloatIconItem.m
//  LoginPart
//
//  Created by 李雨龙 on 2018/7/10.
//  Copyright © 2018年 gener-tech. All rights reserved.
//

#import "FloatIconItem.h"

@implementation FloatIconItem
-(instancetype)initNormalIconName:(NSString *)nornamName selectedIconName:(NSString *)selectedName{
    if (self = [super init]) {
        self.normalIconName =nornamName;
        self.selctedIconName = selectedName;
    }
    return self;
}
@end
