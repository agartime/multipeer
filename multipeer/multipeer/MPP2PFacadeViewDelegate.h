//
//  MPP2PFacadeViewDelegate.h
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "MPPeer.h"

@protocol MPP2PFacadeViewDelegate <NSObject>
- (void) didFoundPeer:(MPPeer *) newPeer;
- (void) didLostPeer:(NSInteger) peerIndex;
- (void) didReceivePeerInfo:(MPPeer *) peer;
@end
