//
//  NoticeCenterModel.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/11.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "NoticeCenterModel.h"

@implementation NoticeCenterModel

//按姓名排序
-(NSComparisonResult)compareByTime:(NoticeCenterModel *)model{
//    return [model.timeStr compare:self.timeStr];
    //入职时间
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    
    NSDate *date1= [dateFormatter dateFromString:model.timeStr];
    NSDate *date2= [dateFormatter dateFromString:self.timeStr];
    
    if (date1 == [date1 earlierDate: date2]) { //不使用intValue比较无效
        
        return NSOrderedAscending;//升序
        
    }else if (date1 == [date1 laterDate: date2]) {
        return NSOrderedDescending;//降序
        
    }else{
        return NSOrderedSame;//相等
    }
}

@end
