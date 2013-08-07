//
//  ServiceCircleCollectionViewCell.m
//  multipeer
//
//  Created by Antonio González Artime on 07/08/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import "ServiceCircleCollectionViewCell.h"

@implementation ServiceCircleCollectionViewCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 35.0;
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor grayColor].CGColor;
        self.contentView.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void) setUserImage:(UIImage *)image {
    if (self.contentView.layer.sublayers.count > 0) {
        CALayer *oldLayer = [self.contentView.layer.sublayers objectAtIndex:0];
        [oldLayer removeFromSuperlayer];
    }
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = self.contentView.layer.bounds;
    imageLayer.cornerRadius = 35.0;
    imageLayer.contents = (id) image.CGImage;
    imageLayer.masksToBounds = YES;
    [self.contentView.layer addSublayer:imageLayer];
}

- (void) setSelected:(BOOL)selected {
    if (selected) {
        self.contentView.backgroundColor = [UIColor orangeColor];
        self.contentView.alpha = 1;
    } else {
        self.contentView.backgroundColor = [UIColor orangeColor];
        self.contentView.alpha = 0.5;
    }
}

@end
