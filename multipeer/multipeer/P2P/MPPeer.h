//
//  MPPeer.h
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface MPPeer : NSObject
@property (strong, nonatomic) MCPeerID *peerId;
@property (strong, nonatomic) NSString * userName;
@property (strong, nonatomic) NSString *deviceType;
@property (strong, nonatomic) NSString *idString;
@property (strong, nonatomic) UIImage *profileImage;
@property (strong, nonatomic) NSMutableArray *services;
@property (nonatomic) BOOL selected;
@property (nonatomic) BOOL connected;
- (NSDictionary *) getDiscoveryDictionary;
- (void) pressedSelected;
@end
