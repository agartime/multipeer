//
//  MPGetInfoResponseMessage.h
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import "MPStandardMessage.h"

@interface MPGetInfoResponseMessage : MPStandardMessage
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray * services;
@property (strong, nonatomic) UIImage * profileImage;
- (NSMutableDictionary *) getDictionary;
@end
