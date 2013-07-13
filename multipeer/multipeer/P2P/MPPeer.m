//
//  MPPeer.m
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import "MPPeer.h"

@implementation MPPeer
@synthesize peerId=_peerId;
@synthesize userName=_userName;
@synthesize deviceType=_deviceType;
@synthesize idString=_idString;
@synthesize selected=_selected;
@synthesize connected=_connected;
@synthesize profileImage=_profileImage;
@synthesize services=_services;

- (NSDictionary *) getDiscoveryDictionary {
    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                           self.userName, @"userName",
                           self.deviceType,@"deviceType",
                           self.idString,@"idString",
                           nil];
    
    if (dict.count == 0) {
        dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                @"testUserName", @"userName",
                @"testDeviceType",@"deviceType",
                @"testIdString",@"idString",
                nil];
    }
    return dict;
}

- (void) pressedSelected {
    self.selected=!self.selected;
}

@end
