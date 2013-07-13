//
//  MPP2PFacade.h
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPP2PFacadeViewDelegate.h"
#import "MPAdvertiserDelegate.h"

@interface MPP2PFacade : NSObject <MCNearbyServiceBrowserDelegate, MPAdvertiserDelegate>
+ (MPP2PFacade *) sharedInstance;
@property id<MPP2PFacadeViewDelegate> peerViewDelegate;

- (void) simulateConnections:(NSInteger) numOfSimulatedConnections;
- (NSInteger) getPeerCount;
- (MPPeer *) getPeerWithIdString:(NSString *)idString;
- (MPPeer *) getPeerAtIndexPath:(NSIndexPath *)indexPath;
- (void) selectedPressedInPeerAtIndexPath:(NSIndexPath *)indexPath;
- (void) replacePeerAtIndexPath:(NSIndexPath *) fromIndexPath toIndexPath:(NSIndexPath *) toIndexPath;
- (void) invitePeer:(MPPeer *)peer;
- (void) requestInfoToSelectedPeers;
- (MPPeer *)getLocalPeer;
- (UIImage *) getMyPeerImage;
- (NSInteger) getNumberOfPossibleActionsWithSelection;

@end
