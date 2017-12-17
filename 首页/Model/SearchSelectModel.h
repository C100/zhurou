//
//  SearchSelectModel.h
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/9/20.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchSelectModel : NSObject

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *pragram;

//@property(nonatomic,copy) NSString *title;
@property(nonatomic,assign) BOOL isSelect;



@end
