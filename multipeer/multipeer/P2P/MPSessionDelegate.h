//
//  MPSessionDelegate.h
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MPSessionDelegate
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state;
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID;
@end
