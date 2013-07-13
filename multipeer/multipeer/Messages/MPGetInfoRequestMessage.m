//
//  MPGetInfoRequestMessage.m
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import "MPGetInfoRequestMessage.h"
#import "MPMessageConstants.h"

@implementation MPGetInfoRequestMessage
- (MPGetInfoRequestMessage *) init {
    self = [super init];
    if (self) {
        self.messageType=kMessageTypeGetInfoRequest;
    }
    return self;
}

- (MPGetInfoRequestMessage *) initWithDictionary:(NSDictionary *) dictionary {
    self = [super initWithDictionary:dictionary];
    return self;
}

@end
