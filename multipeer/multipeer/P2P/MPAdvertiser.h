//
//  MPAdvertiser.h
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "MPSessionDelegate.h"
#import "MPAdvertiserDelegate.h"

@interface MPAdvertiser : NSObject<MCNearbyServiceAdvertiserDelegate, MPSessionDelegate>
@property id <MPAdvertiserDelegate> delegate;
- (id)initWithPeerId:(MCPeerID *) peerId andDiscoveryInfo:(NSDictionary *)discoveryInfo andServiceType:(NSString *)serviceType;
- (void) sendRequestInfoMessageToPeers:(NSArray *) peers;
- (MCSession *) getMCSession;
@end
