//
//  ZHPigBuyView.m
//  XiJuOBJ
//
//  Created by Rain Day on 2017/12/11.
//  Copyright © 2017年 kerr. All rights reserved.
//

#import "ZHPigBuyView.h"
#import "UIView+Nib.h"
#import "AppDelegate.h"
#import "PPNumberButton.h"
#import "ZHScreenAdaptation.h"
#import "ZHPigInfoModel.h"
#import "ZHPigBuyModel.h"

@interface ZHPigBuyView ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *actionSheetTopConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *actionSheetHeightConstraint;
@property (nonatomic, weak) IBOutlet UIView *backgroundView;

@property (nonatomic, strong) UIWindow *viewWindow;

@property (nonatomic, assign) CGFloat actionSheetViewHeight;

@property (nonatomic, getter=isVisible) BOOL visible;

@property (nonatomic, weak) IBOutlet UIImageView *imageViewPig;
@property (nonatomic, weak) IBOutlet UILabel *labelPigBreed;
@property (nonatomic, weak) IBOutlet UILabel *labelPigIntro;
@property (nonatomic, weak) IBOutlet UILabel *labelPigRemain;
@property (nonatomic, weak) IBOutlet UILabel *labelNumber;
@property (nonatomic, weak) IBOutlet UILabel *labelPigPrice;

@property (nonatomic, weak) IBOutlet UIView *numberViewContainer;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *pigImageViewWidthConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topViewHeightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *middleViewHeightConstraint;

@property (nonatomic, strong) ZHPigInfoModel *pigInfoModel;
@property (nonatomic, strong) ZHPigBuyModel *pigBuyModel;

@property (nonatomic, assign) BOOL isConfirm;

@end

@implementation ZHPigBuyView

- (instancetype)init {
    if (self = [super init]) {
        [self zhAddNibNamed:@"ZHPigBuyView"];
        self.actionSheetViewHeight = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:140] + 100;
        [self initialize];
    }
    return self;
}

- (void)initialize {

    self.pigImageViewWidthConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:110];
    self.topViewHeightConstraint.constant = [ZHScreenAdaptation adaptFloatIn4Point7InchScreen:140];

    self.labelPigBreed.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:18]];
    self.labelPigIntro.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:14]];
    self.labelPigRemain.font = [UIFont systemFontOfSize:[ZHScreenAdaptation adaptFloatIn4Point7InchScreen:12]];

    PPNumberButton *numberButton = [[PPNumberButton alloc] initWithFrame:self.numberViewContainer.bounds];
    numberButton.borderColor = The_line_Color_grary;
    numberButton.shakeAnimation = YES;
    __weak typeof(numberButton) weakNumberButton = numberButton;
    numberButton.numberBlock = ^(NSString *num){
        NSInteger buyCount = [num integerValue];
        NSInteger remainCount = [self.pigInfoModel.presentCount integerValue];
        if (buyCount > remainCount) {
            weakNumberButton.textField.text = [NSString stringWithFormat:@"%@", self.pigInfoModel.presentCount];
            self.pigBuyModel.buyCount = remainCount;
            [self configureLabelPigPriceWithPigNumber:remainCount];
        } else {
            self.pigBuyModel.buyCount = buyCount;
            [self configureLabelPigPriceWithPigNumber:buyCount];
        }

    };

    [self.numberViewContainer addSubview:numberButton];
}

- (void)configureLabelPigPriceWithPigNumber:(NSInteger)number {
    self.labelPigPrice.text = [NSString stringWithFormat:@"¥%.2f", [self.pigInfoModel.presentPrice floatValue] * number];
}

- (void)configureLabelPigRemainWithPigRemain:(NSNumber *)pigRemain {
    NSString *pigNumber = [NSString stringWithFormat:@"%@", pigRemain];
    NSString *labelPigRemainText = [NSString stringWithFormat:@"剩余数量：%@头", pigNumber];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelPigRemainText];
    NSRange range = NSMakeRange(5, pigNumber.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:136/255.0f green:136/255.0f blue:136/255.0f alpha:1.0] range:range];
    self.labelPigRemain.attributedText = attributedString;
}

- (void)configureWithPigInfoModel:(ZHPigInfoModel *)pigInfoModel {
    self.pigInfoModel = pigInfoModel;
    [self configureLabelPigPriceWithPigNumber:1];
    self.labelPigBreed.text = pigInfoModel.title;
    self.labelPigIntro.text = pigInfoModel.subtitle;
    [self.imageViewPig sd_setImageWithURL:[NSURL URLWithString:pigInfoModel.pigImage]];
    [self configureLabelPigRemainWithPigRemain:pigInfoModel.presentCount];

    self.pigBuyModel = [[ZHPigBuyModel alloc] initWithPigInfoModel:pigInfoModel];
}

- (void)show {

    if (self.isVisible == YES) {
        return;
    }
    self.visible = YES;
    
    self.viewWindow = [[UIWindow alloc] initWithFrame:[UIApplication sharedApplication].delegate.window.frame];
    self.window.tintColor = self.tintColor;

    UIViewController *viewController = [[UIViewController alloc] init];

    viewController.view = self;

    self.viewWindow.rootViewController = viewController;
    self.viewWindow.backgroundColor = [UIColor clearColor];
    self.viewWindow.windowLevel = UIWindowLevelAlert;
    self.viewWindow.hidden = NO;

    self.actionSheetTopConstraint.constant = [[UIScreen mainScreen] bounds].size.height;
    self.actionSheetHeightConstraint.constant = self.actionSheetViewHeight;
    [self setNeedsLayout];
    [self layoutIfNeeded];

    [self.viewWindow makeKeyAndVisible];

    [UIView animateWithDuration:0.3 animations:^{
        self.actionSheetTopConstraint.constant = [[UIScreen mainScreen] bounds].size.height - self.actionSheetViewHeight;
        self.backgroundView.alpha = 0.6;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {

    }];
}

- (void)dismiss {

    if (self.isVisible == NO) {
        return;
    }
    self.visible = NO;

//    [self setNeedsLayout];
//    [self layoutIfNeeded];

    [UIView animateWithDuration:0.3 animations:^{
        self.actionSheetTopConstraint.constant = [[UIScreen mainScreen] bounds].size.height;
        self.backgroundView.alpha = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.viewWindow.hidden = YES;
        self.viewWindow = nil;
        [self removeFromSuperview];
        if (self.isConfirm) {
            if ([self.delegate respondsToSelector:@selector(pigBuyView:confirmWithModel:)]) {
                [self.delegate pigBuyView:self confirmWithModel:self.pigBuyModel];
            }
        }
    }];
}

#pragma mark - IBAction
- (IBAction)dismissButtonClick:(id)sender {
    self.isConfirm = NO;
    [self dismiss];
}

- (IBAction)confirmButtonClick:(id)sender {
    self.isConfirm = YES;
    [self dismiss];
}

@end
