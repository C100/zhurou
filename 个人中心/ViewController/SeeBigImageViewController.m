//
//  SeeBigImageViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/22.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "SeeBigImageViewController.h"
#import "SeeBigImageView.h"

@interface SeeBigImageViewController ()

@end

@implementation SeeBigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    SeeBigImageView *seeBigView = [[SeeBigImageView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    [self.view addSubview:seeBigView];
    seeBigView.seeBigImage = self.seeBigImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
