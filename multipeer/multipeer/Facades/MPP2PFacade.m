//
//  MPP2PFacade.m
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import "MPP2PFacade.h"
#import "MPPeer.h"
#import "MPAdvertiser.h"
#import "MPMessageConstants.h"

#define TIMEOUT_SEC 10

@interface MPP2PFacade()
@property (strong, nonatomic) MCNearbyServiceBrowser *browser;
@property (strong, nonatomic) MPAdvertiser* advertiser;
@property (strong, nonatomic) NSMutableArray *peers;
@property (strong, nonatomic) MPPeer *myPeer;

@end

@implementation MPP2PFacade
@synthesize browser=_browser;
@synthesize advertiser=_advertiser;

+ (MPP2PFacade *) sharedInstance {
    static MPP2PFacade *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MPP2PFacade alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        self.peers = [[NSMutableArray alloc] initWithCapacity:1];
        NSUUID * uuid = [NSUUID UUID];
        
        self.myPeer = [[MPPeer alloc] init];
        MCPeerID *myPeerId = [[MCPeerID alloc] initWithDisplayName:[uuid UUIDString]];
        self.myPeer.peerId = myPeerId;
        self.myPeer.deviceType = [UIDevice currentDevice].model;
        self.myPeer.userName = @"github_user";
        self.browser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.myPeer.peerId serviceType:kServiceType];
        self.browser.delegate=self;

        self.advertiser = [[MPAdvertiser alloc] initWithPeerId:self.myPeer.peerId andDiscoveryInfo:[self.myPeer getDiscoveryDictionary] andServiceType:kServiceType];
        self.advertiser.delegate = self;
        [self startBrowsing];
    }
    return self;
}



#pragma mark - MCNearbyServiceBrowserDelegate
- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error {
    NSLog(@"MCNearbyServiceABrowserDelegate :: didNotStartBrowsingForPeers :: error :: %@",error);
    
}

- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
    NSLog(@"MCNearbyServiceABrowserDelegate :: foundPeer :: PeerID : %@ :: DiscoveryInfo : %@",peerID,info.description);
    NSLog(@"Creamos sesión automáticamente");
        
    MPPeer *peer = [[MPPeer alloc] init];
    peer.peerId = peerID;
    peer.deviceType=[info objectForKey:@"deviceType"]; //TODO: Crear clase discoveryInfo para evitar esto...
    peer.userName = [info objectForKey:@"userName"];
    peer.idString = [peerID valueForKey:@"idString"];
    
    if ([peer.userName isEqualToString:@"46417594Y"]) {
        peer.profileImage = [UIImage imageNamed:@"john.jpeg"];
    } else if ([peer.userName isEqualToString:@"39172214V"]) {
        peer.profileImage = [UIImage imageNamed:@"harrison.jpeg"];
        
    } else  if ([peer.userName isEqualToString:@"27237757F"]) {
        peer.profileImage = [UIImage imageNamed:@"ringo.jpg"];
        
    } else  if ([peer.userName isEqualToString:@"49352011Z"]) {
        peer.profileImage = [UIImage imageNamed:@"mcartney.jpeg"];
    }
    
    
    if (![self isKnownDeviceWithIdString:peer.idString]) {
        [self.peers addObject:peer];
        [self.peerViewDelegate didFoundPeer:peer];
    }
    
    if (!peer.idString) {
        peer.idString=@"TestDevice";
    }
    
    //[self.browser invitePeer:peerID toSession:self.session withContext:[@"HOLA" dataUsingEncoding:NSUTF8StringEncoding] timeout:10];
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID {
    NSLog(@"MCNearbyServiceABrowserDelegate :: lostPeer :: PeerID : %@",peerID);
    NSLog(@"idString: %@",[peerID valueForKey:@"idString"]);
    [self removePeerForKey:peerID];
}

- (MPPeer *)getLocalPeer {
    return self.myPeer;
}

#pragma mark - Private Methods

- (void) startBrowsing {
    [self.browser startBrowsingForPeers];
}

- (void) removePeerForKey:(MCPeerID *)peerID {
    NSInteger index=[self getIndexOfPeerWithIdString:[peerID valueForKey:@"idString"]];
    if (index>=0) {
        [self.peers removeObjectAtIndex:index];
        [self.peerViewDelegate didLostPeer:index];
    }
}

- (BOOL) isKnownDeviceWithIdString:(NSString *)idString {
    for (MPPeer *peer in self.peers) {
        if ([peer.idString isEqualToString:idString]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Public Methods

- (NSInteger) getPeerCount {
    return self.peers.count;
}

- (MPPeer *) getPeerWithIdString:(NSString *)idString {
    for (MPPeer *peer in self.peers) {
        if ([peer.idString isEqualToString:idString]) {
            return peer;
        }
    }
    return nil;
}

- (NSInteger) getIndexOfPeerWithIdString:(NSString *) peerId {
    for (NSInteger i=0;i<self.peers.count;i++) {
        MPPeer *peer = [self.peers objectAtIndex:i];
        if ([peer.idString isEqualToString:peerId])
        return i;
    }
    return -1;
}

- (MPPeer *) getPeerAtIndexPath:(NSIndexPath *)indexPath {
    return [self.peers objectAtIndex:indexPath.row];
}

- (void) selectedPressedInPeerAtIndexPath:(NSIndexPath *)indexPath {
    [(MPPeer *)[self.peers objectAtIndex:indexPath.row] pressedSelected];
}

- (void) simulateConnections:(NSInteger) numOfSimulatedConnections {
    NSMutableArray * arr = [[NSMutableArray alloc] initWithCapacity:numOfSimulatedConnections];
    
    for (int i=0;i<numOfSimulatedConnections;i++) {
        MPAdvertiser * adv = [[MPAdvertiser alloc] initWithPeerId:self.myPeer.peerId andDiscoveryInfo:[self.myPeer getDiscoveryDictionary] andServiceType:kServiceType];
        [arr insertObject:adv atIndex:i];
        [NSThread sleepForTimeInterval:1];
    }
    
    [NSThread sleepForTimeInterval:10];
    
    for (int i=numOfSimulatedConnections-1;i>=0;i--) {
        [arr removeObjectAtIndex:i];
        [NSThread sleepForTimeInterval:3];
    }
    
    
    //    self.advertiser = [[MPAdvertiser alloc] initWithPeerId:self.myPeer.peerId andDiscoveryInfo:[self.myPeer getDiscoveryDictionary] andServiceType:kServiceType];
}

- (void) replacePeerAtIndexPath:(NSIndexPath *) fromIndexPath toIndexPath:(NSIndexPath *) toIndexPath {
    MPPeer *peer = [self.peers objectAtIndex:fromIndexPath.row];
    [self.peers removeObjectAtIndex:fromIndexPath.row];
    [self.peers insertObject:peer atIndex:toIndexPath.row];
}

- (void) invitePeer:(MPPeer *)peer {
    [self.browser invitePeer:peer.peerId toSession:[self.advertiser getMCSession] withContext:[kSessionInvitationContext dataUsingEncoding:NSUTF8StringEncoding] timeout:TIMEOUT_SEC];
}

#pragma mark - MPAdvertiserDelegate
- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL accept, MCSession *session))invitationHandler {
    NSString *contextString = [[NSString alloc] initWithData:context encoding:NSUTF8StringEncoding];
    NSLog(@"Invitation Context: %@", contextString);
    
    // if ([contextString isEqualToString:kSessionInvitationContext]) { //AutoAceptamos nuestro contexto por ser conocido por la aplicacion
    invitationHandler(TRUE, [self.advertiser getMCSession]);
    // }
}

- (void) changePeerAtIndex:(NSInteger) index setConnectedTo:(BOOL) connected {
    [(MPPeer *)[self.peers objectAtIndex:index] setConnected:connected];
}

- (NSMutableArray *) getSelectedMCPeerIDs {
    NSMutableArray * array=[[NSMutableArray alloc] initWithCapacity:1];
    for (NSInteger i=0;i<self.peers.count;i++) {
        MPPeer *peer = [self.peers objectAtIndex:i];
        if (peer.selected) {
            [array addObject:peer.peerId];
        }
    }
    return array;
}

- (void) didReceiveInfo:(NSDictionary *)dictInfo fromPeer:(MCPeerID *) peerId {
    MPPeer * peer = [self getPeerWithIdString:[peerId valueForKey:@"idString"]];
    peer.userName=[dictInfo valueForKey:@"name"];
    peer.profileImage=[dictInfo valueForKey:@"profileImage"];
    peer.services=[dictInfo valueForKey:@"services"];
    [self.peerViewDelegate didReceivePeerInfo:peer];
}

- (void) requestInfoToSelectedPeers {
    [self.advertiser sendRequestInfoMessageToPeers:[self getSelectedMCPeerIDs]];
}

- (NSInteger) getNumberOfPossibleActionsWithSelection {
    return 2;
}

- (UIImage *) getMyPeerImage {
    return self.myPeer.profileImage;
}


@end
