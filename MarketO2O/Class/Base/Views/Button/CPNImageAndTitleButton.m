//
//  CPNImageAndTitleButton.m
//  
//
//  Created by CPN on 16/1/20.
//  Copyright © 2016年 . All rights reserved.
//

#import "CPNImageAndTitleButton.h"

@implementation CPNImageAndTitleButton


- (void)layoutSubviews{
    [super layoutSubviews];
    if (!self.currentTitle || !self.imageView.image) {
        return;
    }
    [self.titleLabel sizeToFit];
    switch (self.imagePosition) {
        case CPNImageAndTitleButtonImagePositionLeft:{
            self.imageView.left = (self.width - self.imageAndTitleOffset - self.imageView.width - self.titleLabel.width)/2;
            self.titleLabel.left = self.imageView.right + self.imageAndTitleOffset;
            self.imageView.centerY =
            self.titleLabel.centerY = self.height/2;
        }
            break;
        case CPNImageAndTitleButtonImagePositionRight:{
            self.titleLabel.left = (self.width - self.imageAndTitleOffset - self.imageView.width - self.titleLabel.width)/2;
            self.imageView.left = self.titleLabel.right + self.imageAndTitleOffset;
            self.imageView.centerY =
            self.titleLabel.centerY = self.height/2;
        }
            break;
        case CPNImageAndTitleButtonImagePositionUp:{
            self.imageView.top = (self.height - self.imageAndTitleOffset - self.imageView.height - self.titleLabel.height)/2;
            self.titleLabel.top = self.imageView.bottom + self.imageAndTitleOffset;
            self.imageView.centerX =
            self.titleLabel.centerX = self.width/2;
        }
            break;
        case CPNImageAndTitleButtonImagePositionDown:{
            self.titleLabel.top = (self.height - self.imageAndTitleOffset - self.imageView.height - self.titleLabel.height)/2;
            self.imageView.top = self.titleLabel.bottom + self.imageAndTitleOffset;
            self.imageView.centerX =
            self.titleLabel.centerX = self.width/2;
        }
            break;
            
        default:
            break;
    }
}

@end
