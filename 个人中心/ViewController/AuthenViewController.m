//
//  AuthenViewController.m
//  XiJuOBJ
//
//  Created by 王陈洁 on 17/6/15.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "AuthenViewController.h"
#import "AuthenView.h"
#import "SeeBigImageViewController.h"
#import "PersonalCenterVC.h"

@interface AuthenViewController ()<AuthenViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) AuthenView *authenView;
@property (nonatomic,strong) UIImage *selectImage1;
@property (nonatomic,strong) UIImage *selectImage2;
@property (nonatomic,strong) UIImage *selectImage3;
@property (nonatomic,assign) NSInteger selectTag;
@property (nonatomic,strong) NSString *cardImageStr;
@property (nonatomic,strong) NSString *certificateStr;
@property (nonatomic,strong) NSString *LicenseStr;

@end

@implementation AuthenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [HttpRequestManager postChangeDesignerAuthStatusWithFinishBlock:^(NSDictionary *data) {
//        
//    }];
    
    self.title = @"设计师认证";
    self.authenView = [[AuthenView alloc]initWithFrame:CGRectMake(0, 0, KHScreenW, KHScreenH-64)];
    [self.authenView.applyButton addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
    self.authenView.authenViewDelegate = self;
    [self.view addSubview:self.authenView];
    
}

#pragma mark AuthenViewDelegate
-(void)tapImageViewWithTag:(NSInteger)tag{
    self.selectTag = tag;
    
    switch (tag-100) {
        case 0:
            if (self.selectImage1) {
                //查看大图
                SeeBigImageViewController *vc = [[SeeBigImageViewController alloc]init];
                vc.seeBigImage = self.selectImage1;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self showAlertSheet];
            }
            break;
        case 1:
            if (self.selectImage2) {
                SeeBigImageViewController *vc = [[SeeBigImageViewController alloc]init];
                vc.seeBigImage = self.selectImage2;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self showAlertSheet];
            }
            break;
        case 2:
            if (self.selectImage3) {
                SeeBigImageViewController *vc = [[SeeBigImageViewController alloc]init];
                vc.seeBigImage = self.selectImage3;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [self showAlertSheet];
            }
            break;
        default:
            break;
    }
    
    
    
}


#pragma mark UIImagePicker delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImageView *iv = [self.authenView viewWithTag:self.selectTag];
    iv.image = image;
    UIButton *deleteButton = [self.authenView viewWithTag:self.selectTag+100];
    deleteButton.hidden = NO;
    [deleteButton addTarget:self action:@selector(deleteImageView:) forControlEvents:UIControlEventTouchUpInside];
    switch (self.selectTag-100) {
        case 0:
        {
            self.selectImage1 = image;
            
        }
            break;
        case 1:
        {
            self.selectImage2 = image;
        }
            
            break;
        case 2:
        {
            self.selectImage3 = image;
        }
            
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)applyAction{
    if (!self.selectImage1||!self.selectImage2||!self.selectImage3) {
        [LUtils toastview:@"请完善资料"];
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    
    /*创建信号量*/
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    /*创建全局并行*/
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件B");
        dispatch_async(dispatch_get_main_queue(), ^{
            [HttpRequestManager getPicUrlWithBase64:[weakSelf imagechange:weakSelf.selectImage2] WithFinishBlock:^(NSString *str) {
                if (str) {
                    weakSelf.cardImageStr = str;
                }
                
                dispatch_semaphore_signal(semaphore);
            }];
        });
        
        
        
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件C");
        dispatch_async(dispatch_get_main_queue(), ^{
            [HttpRequestManager getPicUrlWithBase64:[weakSelf imagechange:weakSelf.selectImage1] WithFinishBlock:^(NSString *str) {
                if (str) {
                    weakSelf.certificateStr = str;
                }
                
                dispatch_semaphore_signal(semaphore);
            }];
        });
        
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件D");
        dispatch_async(dispatch_get_main_queue(), ^{
            [HttpRequestManager getPicUrlWithBase64:[weakSelf imagechange:weakSelf.selectImage3] WithFinishBlock:^(NSString *str) {
                if (str) {
                    weakSelf.LicenseStr = str;
                }
                dispatch_semaphore_signal(semaphore);
            }];
        });
        
    });
    
    dispatch_group_notify(group, queue, ^{
        /*四个请求对应四次信号等待*/
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"处理事件E");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [HttpRequestManager postDesignerAuthRequestWithCardImage:weakSelf.cardImageStr andCertificateImage:weakSelf.certificateStr andLicenseImage:weakSelf.LicenseStr andFinishBlock:^(NSDictionary *dataDic) {
                if (dataDic) {
                    NSNumber *code = dataDic[@"code"];
                    if (code.intValue==kSuccessCode) {
                        PersonalCenterVC *vc = self.navigationController.viewControllers[1];
                        vc.authenStatus = @"认证中";
                        [weakSelf.navigationController popToViewController:vc animated:YES];
                    }
                    
                }
            }];
        });
        
    });
    
    
    
    
}

-(void)deleteImageView:(UIButton *)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否确认删除图片？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        UIImageView *iv = [self.authenView viewWithTag:sender.tag-100];
        iv.image = [UIImage imageNamed:@"xiangji"];
        sender.hidden = YES;
        switch (sender.tag-200) {
            case 0:
            {
                self.selectImage1 = nil;
                
            }
                break;
            case 1:
            {
                self.selectImage2 = nil;
            }
                
                break;
            case 2:
            {
                self.selectImage3 = nil;
            }
                
                break;
            default:
                break;
        }
        
        
        
        
        
    }];
    UIAlertAction *a3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:a1];
    [alert addAction:a3];
    
    [self presentViewController:alert animated:YES completion:nil];

    
    
}

-(void)showAlertSheet{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openImagePickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *a3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:a1];
    [alert addAction:a2];
    [alert addAction:a3];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

-(void)openImagePickerWithType:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = type;
    [self presentViewController:picker animated:YES completion:nil];
}

-(NSString*)imagechange:(UIImage *)image
{
    
    //
    //    UIImage *image=[imageArray objectAtIndex:i];
    NSData *imgData=UIImageJPEGRepresentation(image, 0.2);
    
    BXLog(@"图片大小%ldk",[imgData length]/1024);
    
    NSString *base64Str=[imgData base64EncodedStringWithOptions:0];
    imgData=UIImageJPEGRepresentation(image, 102400.0/base64Str.length);
    base64Str=[imgData base64EncodedStringWithOptions:0];
    
    //   NSString *baseString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
    //                                                                                        (CFStringRef)base64Str,
    //NULL,
    //CFSTR(":/?#[]@!$&’()*+,;="),
    //kCFStringEncodingUTF8);
    
    return base64Str;
}

@end
