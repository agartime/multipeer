//
//  MPStandardMessage.h
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPStandardMessage : NSObject
@property (nonatomic) NSInteger const messageType;
- (NSMutableDictionary *) getDictionary;
- (NSData *) getData;
- (MPStandardMessage *) initWithDictionary:(NSDictionary *) dictionary;
@end
