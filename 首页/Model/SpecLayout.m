//
//  SpecLayout.m
//  XiJuOBJ
//
//  Created by xiyoukeji on 16/10/8.
//  Copyright © 2016年 kerr. All rights reserved.
//

#import "SpecLayout.h"
#import "SpecModel.h"

@implementation SpecLayout


{
    NSMutableArray *_attrArray;
}
//返回的CGSize是collectionView的本身的contentSize
-(CGSize)collectionViewContentSize
{
    CGFloat heightLeft = 0.0;
    CGFloat heightRight = 0.0;
    CGFloat heightMax = 0.0;
    CGFloat heightTemp = 0.0;
    
    SpecModel *lastModel = nil;
    for (int i = 0; i<_dataArray.count; i++) {
        SpecModel *model = _dataArray[i];
        lastModel = model;
        CGFloat height = model.cellHeight;
        if (i%2 == 0) {
            if (heightLeft <= heightRight) {
                heightMax  =  heightRight + heightMax;
            }
            else
            {
                heightMax =   heightLeft + heightMax;
            }
            
        }
        
        if (i%2==0) {
            heightTemp =heightMax;
            heightLeft = height;
            
        }else
        {
            heightRight = height;
            
        }
    }
    return CGSizeMake(0,heightMax + lastModel.cellHeight + 114);
}


-(void)setDataArray:(NSArray *)dataArray
{
    //    NSLog(@"================%@",dataArray);
    _dataArray = dataArray;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    CGFloat heightLeft = 0.0;
    CGFloat heightRight = 0.0;
    CGFloat heightMax = 0.0;
    CGFloat heightTemp = 0.0;

    for (int i = 0; i<_dataArray.count; i++) {
        
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        SpecModel *model = _dataArray[i];
        CGFloat height = model.cellHeight;
        
      
        
        if (i%2 == 0) {
            if (heightLeft <= heightRight) {
                heightMax  =  heightRight + heightMax;
            }
            else
            {
                heightMax =   heightLeft + heightMax;
            }
 
        }
        
        if (i%2==0) {
            heightTemp =heightMax;
            attr.center = CGPointMake(KHScreenW/4, heightMax + model.cellHeight / 2);
            heightLeft = height;
            
        }else
        {
            attr.center = CGPointMake(KHScreenW/4*3, heightTemp + model.cellHeight / 2);
            heightRight = height;
            
        }
        
        attr.size = CGSizeMake(KHScreenW/2, model.cellHeight);
        [arr addObject:attr];
    }
    _attrArray = arr;
    //    NSLog(@"---%@",_attrArray);
}

//返回的数组,里面是所有cell所对应的UICollectionViewLayoutAttributes
//返回所有cell的属性数组
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //    NSLog(@"==%@",_attrArray);
    return _attrArray;
}

@end




