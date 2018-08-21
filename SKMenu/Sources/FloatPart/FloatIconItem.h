//
//  FloatIconItem.h
//  LoginPart
//
//  Created by 李雨龙 on 2018/7/10.
//  Copyright © 2018年 gener-tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FloatIconItem : NSObject
-(instancetype)initNormalIconName:(NSString *) nornamName selectedIconName:(NSString *) selectedName;
@property(copy, nonatomic) NSString * selctedIconName;
@property(copy, nonatomic) NSString * normalIconName;
@end
