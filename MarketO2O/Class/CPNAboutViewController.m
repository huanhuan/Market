//
//  CPNAboutViewController.m
//  MarketO2O
//
//  Created by satyapeng on 15/9/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNAboutViewController.h"

@interface CPNAboutViewController ()

@property (nonatomic, strong)UIImageView *logoImage;
@property (nonatomic, strong)UILabel *versionLabel;


@end

@implementation CPNAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    
    self.logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appIcon"]];
    self.logoImage.frame = CGRectMake(0, 0, 90, 90);
    self.logoImage.centerX = self.view.centerX;
    self.logoImage.centerY = 80;
    [self.view addSubview:self.logoImage];
    
    self.versionLabel = [UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, <#CGFloat height#>)
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
