//
//  CPNPopBackView.m
//  
//
//  Created by CPN on 15/11/19.
//  Copyright © 2015年 . All rights reserved.
//

#import "CPNPopBackView.h"
#import "AppDelegate.h"

@interface CPNPopBackView ()

@property(nonatomic,strong)UIButton *hiddenButton;
@property(nonatomic,copy)CPNPopViewCloseBlock   popViewCloseBlock;

@end

@implementation CPNPopBackView

static CPNPopBackView *_defaultPopView;
+ (CPNPopBackView *)sharedInstance{
    if (_defaultPopView == nil) {
        _defaultPopView = [[CPNPopBackView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _defaultPopView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        _defaultPopView.userInteractionEnabled = YES;
    }
    return _defaultPopView;
}


- (UIButton *)hiddenButton{
    if (!_hiddenButton) {
        _hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _hiddenButton.backgroundColor = [UIColor clearColor];
        _hiddenButton.frame = _defaultPopView.bounds;
        [_hiddenButton addTarget:self action:@selector(clickClosePopView) forControlEvents:UIControlEventTouchUpInside];
        _hiddenButton.hidden = YES;
        _hiddenButton.exclusiveTouch = YES;
        [_defaultPopView addSubview:_hiddenButton];
    }
    _hiddenButton.frame = _defaultPopView.bounds;
    [_defaultPopView sendSubviewToBack:_hiddenButton];
    return _hiddenButton;
}


- (void)displayPopBackView:(UIView *)superView subView:(UIView *)subView {
    [_defaultPopView removeAllSubviewsExcept:@[self.hiddenButton]];
    
    _defaultPopView.alpha = 1.0;
    _defaultPopView.frame = superView.bounds;
    _defaultPopView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    subView.center = _defaultPopView.center;
    [_defaultPopView addSubview:subView];
    
    self.hiddenButton.hidden = NO;
    
    _defaultPopView.hidden = NO;
    [superView addSubview:_defaultPopView];
    [superView bringSubviewToFront:_defaultPopView];
}


- (void)displayPopBackView:(UIView *)subView {
    [self displayPopBackView:[UIApplication sharedApplication].delegate.window subView:subView];
}

-(void)addCloseGestureWithBlock:(CPNPopViewCloseBlock)block{
    self.popViewCloseBlock = block;
    self.hiddenButton.hidden = NO;
}

-(void)clickClosePopView{
    if (self.popViewCloseBlock) {
        self.popViewCloseBlock();
    }
}


-(void)removeCloseGesture{
    self.popViewCloseBlock = nil;
    self.hiddenButton.hidden = YES;
}


- (void)close {
    for (UIGestureRecognizer *gesture in _defaultPopView.gestureRecognizers) {
        [_defaultPopView removeGestureRecognizer:gesture];
    }
    
    [UIView animateWithDuration:0.01 animations:^{
        _defaultPopView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_defaultPopView removeAllSubviewsExcept:@[self.hiddenButton]];
        _defaultPopView.hidden = YES;
    }];
}

@end
