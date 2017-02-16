//
//  HorizontalLayout.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/9.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "HorizontalLayout.h"
#import "LuaView.h"


@implementation HorizontalLayout

- (void)layout:(LuaViewGroup *)luaViewGroup {
    CGFloat height = 0;
    //CGFloat width = 0;
    CGFloat l = 0, t = 0,r = 0,b = 0,w = 0, h = 0;
    CGFloat cl = 0, ct = 0,cr = 0, cb = 0;
    for (int i = 0 ;i < luaViewGroup.subLuaViews.count;i++ ) {
        LuaView *view = luaViewGroup.subLuaViews[i];
        if (!view.hidden) {
            Margin margin = view._margin;
            CGRect frame = [view _resize];
            l = margin.l+r;
            t = margin.t+b;
            r = margin.r;
            b = margin.b;
            w = frame.size.width;
            h = frame.size.height;
        }else{
            l = 0;
            t = 0;
            r = 0;
            b = 0;
            w = 0;
            h = 0;
        }
        cl = l+cr;
        ct = t;
        cr = cl+w;
        cb = ct+h;
        height = MAX(height, h+t);
        view._luaRect = LuaRectMake(cl+luaViewGroup.leftPadding, ct+luaViewGroup.topPadding, cr+luaViewGroup.leftPadding, cb+luaViewGroup.topPadding, w, h);
    }
    CGRect frame = luaViewGroup.frame;
    CGFloat totalWidth = frame.size.width;
    CGFloat totalHeight = frame.size.height;
    
    if(luaViewGroup.autoresizeWidth){
        totalWidth = cr+luaViewGroup.leftPadding+luaViewGroup.rightPadding;
    }
    if (luaViewGroup.autoresizeHeight) {
        totalHeight = height+luaViewGroup.topPadding+luaViewGroup.bottomPadding;
    }
    frame = CGRectMake(frame.origin.x, frame.origin.y, totalWidth, totalHeight);
    luaViewGroup.frame = frame;
    
    //处理权重
    [self resizeWithWeight:luaViewGroup];
}

- (void)resizeWithWeight:(LuaViewGroup *)luaViewGroup{
    if (luaViewGroup.weight != nil && luaViewGroup.weight.count > 0) {
        CGFloat width = luaViewGroup.frame.size.width;
        NSAssert(width > 0, @"width必须大于0");
        CGFloat remainWidth = width;
        int index = 0;
        for (int i = 0 ;i < luaViewGroup.subLuaViews.count;i++ ) {
            LuaView *view = luaViewGroup.subLuaViews[i];
            if (!view.hidden) {
                LuaRect rect = view._luaRect;
                Margin margin = view._margin;
                if(index > luaViewGroup.weight.count-1){
                    remainWidth = remainWidth-margin.l-margin.r-rect.w;
                }else{
                    remainWidth = remainWidth - margin.l-margin.r;
                }
                index++;
            }
        }
        remainWidth = remainWidth-luaViewGroup.leftPadding-luaViewGroup.rightPadding;
        double totalWeight = 0.0;
        NSMutableArray<NSNumber *> *widthArray = [NSMutableArray array];
        for(NSNumber *n in luaViewGroup.weight){
            totalWeight += n.doubleValue;
            [widthArray addObject:@(remainWidth*n.doubleValue)];
        }
        NSAssert(((int)totalWeight) == 1, @"权重之和必须为1");
        
        index = 0;
        CGFloat l = 0, t = 0,r = 0,b = 0,w = 0, h = 0;
        CGFloat cl = 0, ct = 0,cr = 0, cb = 0;
        
        for (int i = 0 ;i < luaViewGroup.subLuaViews.count;i++ ) {
            LuaView *view = luaViewGroup.subLuaViews[i];
            if (!view.hidden) {
                Margin margin = view._margin;
                LuaRect rect = view._luaRect;
                l = margin.l+r;
                t = margin.t+b;
                r = margin.r;
                b = margin.b;
                if (index <= widthArray.count-1) {
                    w = [widthArray objectAtIndex:index].floatValue;
                }else{
                    w = rect.w;
                }
                h = rect.h;
                index ++;
                
            }else{
                l = 0;
                t = 0;
                r = 0;
                b = 0;
                w = 0;
                h = 0;
            }
            cl = l+cr;
            ct = t;
            cr = cl+w;
            cb = ct+h;
            view._luaRect = LuaRectMake(cl+luaViewGroup.leftPadding, ct+luaViewGroup.topPadding, cr+luaViewGroup.leftPadding, cb+luaViewGroup.topPadding, w, h);
        }
    }
}

@end
