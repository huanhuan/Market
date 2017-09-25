//
//  CPNAddAdressViewController.m
//  MarketO2O
//
//  Created by satyapeng on 25/9/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNAddAdressViewController.h"
#import "UIAutoScrollView.h"
#import "UITextView+Placeholder.h"
#import "STPickerArea.h"

@interface CPNAddAdressViewController ()

@property (nonatomic, strong)UIAutoScrollView *scrollView;
@property (nonatomic, strong)UITextField *name;
@property (nonatomic, strong)UITextField *telephoneNumber;
@property (nonatomic, strong)UITextField *cityAddress;
@property (nonatomic, strong)UITextView *detailAddress;
@property (nonatomic, strong)UIButton *confirmButton;
@property (nonatomic, strong)STPickerArea *pickerArea;

@end

@implementation CPNAddAdressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"新建收货人";
    self.scrollView = [UIAutoScrollView new];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.equalTo(self.view);
    }];
    [self initViews];
    [self.view addSubview:self.confirmButton];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)initViews
{
    UILabel *nameLabel = [CPNCommonLabel commonLabelWithTitle:@"收货人："
                                                     textFont:CPNCommonFontFifteenSize
                                                    textColor:CPNCommonMaxDarkGrayColor];
    nameLabel.frame = CGRectMake(10, 50, 90, 22);
    [self.scrollView addSubview:nameLabel];
    self.name = [UITextField new];
    self.name.frame = CGRectMake(100, 50, self.view.width - 110, 22);
    self.name.font = CPNCommonFontFifteenSize;
    [self.scrollView addSubview:self.name];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.name.frame) + 10, MAIN_SCREEN_WIDTH, onePixel)];
    [line setBackgroundColor:CPNCommonLineLayerColorColor];
    [self.scrollView addSubview:line];
    
    UILabel *telephoneNumberLabel = [CPNCommonLabel commonLabelWithTitle:@"联系方式："
                                                     textFont:CPNCommonFontFifteenSize
                                                    textColor:CPNCommonMaxDarkGrayColor];
    telephoneNumberLabel.frame = CGRectMake(10, 100, 90, 22);
    [self.scrollView addSubview:telephoneNumberLabel];
    self.telephoneNumber = [UITextField new];
    self.telephoneNumber.frame = CGRectMake(100, 100, self.view.width - 110, 22);
    self.telephoneNumber.font = CPNCommonFontFifteenSize;
    self.telephoneNumber.keyboardType = UIKeyboardTypePhonePad;
    [self.scrollView addSubview:self.telephoneNumber];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.telephoneNumber.frame) + 10, MAIN_SCREEN_WIDTH, onePixel)];
    [line1 setBackgroundColor:CPNCommonLineLayerColorColor];
    [self.scrollView addSubview:line1];
    
    UILabel *cityAddressLabel = [CPNCommonLabel commonLabelWithTitle:@"收获地区："
                                                     textFont:CPNCommonFontFifteenSize
                                                    textColor:CPNCommonMaxDarkGrayColor];
    cityAddressLabel.frame = CGRectMake(10, 150, 90, 22);
    [self.scrollView addSubview:cityAddressLabel];
    self.cityAddress = [UITextField new];
    self.cityAddress.font = CPNCommonFontFifteenSize;
    self.cityAddress.frame = CGRectMake(100, 150, self.view.width - 110, 22);
    [self.scrollView addSubview:self.cityAddress];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cityAddress.frame) + 10, MAIN_SCREEN_WIDTH, onePixel)];
    [line2 setBackgroundColor:CPNCommonLineLayerColorColor];
    [self.scrollView addSubview:line2];
    
    UILabel *detailAddressLabel = [CPNCommonLabel commonLabelWithTitle:@"详情地址："
                                                            textFont:CPNCommonFontFifteenSize
                                                           textColor:CPNCommonMaxDarkGrayColor];
    detailAddressLabel.frame = CGRectMake(10, 200, 90, 22);
    [self.scrollView addSubview:detailAddressLabel];
    self.detailAddress = [UITextView new];
    self.detailAddress.font = CPNCommonFontFifteenSize;
    [self.detailAddress setBackgroundColor:[UIColor clearColor]];
    [self.detailAddress setPlaceholder:@"街道、楼牌号等"];
    self.detailAddress.frame = CGRectMake(100, 200, self.view.width - 110, 25);
    self.detailAddress.centerY = detailAddressLabel.centerY;
    [self.scrollView addSubview:self.detailAddress];
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.detailAddress.frame) + 10, MAIN_SCREEN_WIDTH, onePixel)];
    [line3 setBackgroundColor:CPNCommonLineLayerColorColor];
    [self.scrollView addSubview:line3];
    [self.scrollView addAutoScrollAbility];
    [self.cityAddress setDelegate:(id<UITextFieldDelegate>)self];
}

-(void)keyboardHide:(id)sender
{
    [self.name resignFirstResponder];
    [self.telephoneNumber resignFirstResponder];
    [self.cityAddress resignFirstResponder];
    [self.detailAddress resignFirstResponder];
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 104, MAIN_SCREEN_WIDTH, 40)];
        [_confirmButton setBackgroundColor:CPNCommonLightRedColor];
        [_confirmButton.titleLabel setFont:CPNCommonFontFifteenSize];
        [_confirmButton setTitle:@"保存地址" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:CPNCommonWhiteColor forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_confirmButton];
    }
    return _confirmButton;
}

- (void)confirmButtonClick:(id)sender
{

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self keyboardHide:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        STPickerArea *pickerArea = [[STPickerArea alloc]init];
        [pickerArea setDelegate:(id <STPickerAreaDelegate>)self];
        [pickerArea setContentMode:STPickerContentModeBottom];
        [pickerArea show];
        self.pickerArea = pickerArea;
    });
    return NO;
}

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *addressCity = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    [self.cityAddress setText:addressCity];
}
@end
