//
//  Bundle.h
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/13.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>

#define down_cache_path @"luadown"

@interface Bundle : NSObject

+ (NSString *)luaScript:(NSString *)luaName;

+ (NSString *)cachePath;

@end
