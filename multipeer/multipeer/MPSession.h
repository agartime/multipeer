//
//  MPSession.h
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "MPSessionDelegate.h"

@interface MPSession : NSObject <MCSessionDelegate>
@property id <MPSessionDelegate> delegate;

- (id) initWithPeerId:(MCPeerID *)peerId;
- (MCSession *) getMCSession;

@end
