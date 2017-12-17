//
//  AddCreditTextField.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/21.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AddCreditTextField.h"

@implementation AddCreditTextField

-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);//更好理解些
    return inset;
}

@end
