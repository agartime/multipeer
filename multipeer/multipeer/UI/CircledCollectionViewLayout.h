//
//  CircledCollectionViewLayout.h
//  multipeer
//
//  Created by Antonio González Artime on 07/08/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircledCollectionViewLayout : UICollectionViewLayout
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger cellCount;
@end
