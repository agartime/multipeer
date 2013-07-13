//
//  MPGetInfoResponseMessage.m
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import "MPGetInfoResponseMessage.h"
#import "MPMessageConstants.h"

@implementation MPGetInfoResponseMessage
@synthesize name=_name;
@synthesize services=_services;
@synthesize profileImage=_profileImage;


- (MPGetInfoResponseMessage *) init {
    self = [super init];
    if (self) {
        self.messageType=kMessageTypeGetInfoResponse;
    }
    return self;
}

- (NSMutableDictionary *) getDictionary {
    NSMutableDictionary * dict = [super getDictionary];
    [dict setObject:self.name forKey:@"name"];
    [dict setObject:self.services forKey:@"services"];
    [dict setObject:self.profileImage forKey:@"profileImage"];
    return dict;
}

- (MPGetInfoResponseMessage *) initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    if (self) {
        self.name = [dictionary objectForKey:@"name"];
        self.services = [dictionary objectForKey:@"services"];
        self.profileImage = [dictionary objectForKey:@"profileImage"];
    }
    return self;
}
@end
