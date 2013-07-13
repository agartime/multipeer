//
//  MPAdvertiserDelegate.h
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@protocol MPAdvertiserDelegate <NSObject>
- (NSInteger) getIndexOfPeerWithIdString:(NSString *) string;
- (void) changePeerAtIndex:(NSInteger) index setConnectedTo:(BOOL) connected;
- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL accept, MCSession *session))invitationHandler;
- (void) didReceiveInfo:(NSDictionary *)dictInfo fromPeer:(MCPeerID *) peerId;
@end
