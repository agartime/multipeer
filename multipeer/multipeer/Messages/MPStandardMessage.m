//
//  MPStandardMessage.m
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import "MPStandardMessage.h"

@implementation MPStandardMessage
@synthesize messageType=_messageType;

- (NSMutableDictionary *) getDictionary {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:self.messageType],@"messageType", nil];
    return dictionary;
}

- (NSData *) getData {
    NSDictionary * dict = [self getDictionary];
    return [NSKeyedArchiver archivedDataWithRootObject:dict];
}

- (MPStandardMessage *) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        self.messageType = [(NSNumber *)[dictionary objectForKey:@"messageType"] integerValue];
    }
    return self;
}

@end
