//
//  MPAdvertiser.m
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import "MPAdvertiser.h"
#import "MPSession.h"
#import "MPMessageConstants.h"
#import "MPGetInfoRequestMessage.h" //TODO: Factory here soon
#import "MPGetInfoResponseMessage.h"


@interface MPAdvertiser()
@property (strong, nonatomic) MCNearbyServiceAdvertiser * advertiser;
@property (strong, nonatomic) MPSession* session;
@end

@implementation MPAdvertiser
@synthesize session=_session;
@synthesize delegate=_delegate;

- (id)initWithPeerId:(MCPeerID *) peerId andDiscoveryInfo:(NSDictionary *)discoveryInfo andServiceType:(NSString *)serviceType {
    if (self = [super init]) {
        self.session = [[MPSession alloc] initWithPeerId:peerId];
        self.session.delegate=self;
        self.advertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:peerId discoveryInfo:discoveryInfo serviceType:serviceType];
        self.advertiser.delegate = self;
        [self.advertiser startAdvertisingPeer];
    }
    return self;
}

#pragma mark - MCNearbyServiceAdvertiserDelegate

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didNotStartAdvertisingPeer:(NSError *)error {
    NSLog(@"MCNearbyServiceAdvertiserDelegate :: didNotStartAdvertisingPeer :: %@",error);
}

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL accept, MCSession *session))invitationHandler {
    
    NSLog(@"MCNearbyServiceAdvertiserDelegate :: didReceiveInvitationFromPeer :: peerId :: %@",peerID);
    [self.delegate advertiser:advertiser didReceiveInvitationFromPeer:peerID withContext:context invitationHandler:invitationHandler];
    //invitationHandler(TRUE,self.session);
    
}

- (MCSession *) getMCSession {
    return [self.session getMCSession];
}



#pragma mark - MPSessionDelegate
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    
    NSString *idString = [peerID valueForKey:@"idString"];
    NSInteger position = [self.delegate getIndexOfPeerWithIdString:idString];
    
    switch (state) {
            case MCSessionStateConnected: {
                NSLog(@"MCSessionStateConnected");
                [self.delegate changePeerAtIndex:position setConnectedTo:TRUE];
            }
            break;
            case MCSessionStateConnecting: {
            }
            break;
            case MCSessionStateNotConnected: {
                NSLog(@"MCSessionStateConnected");
                [self.delegate changePeerAtIndex:position setConnectedTo:FALSE];
            }
            break;
        default: {
        }
    }
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    NSDictionary *myDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    MPStandardMessage *message  = [[MPStandardMessage alloc] initWithDictionary:myDictionary];
    NSLog(@"Received %@",myDictionary);
    
    switch (message.messageType) {
            case kMessageTypeGetInfoRequest: {
                NSLog(@"kMessageTypeGetInfoRequest");
                MPGetInfoRequestMessage *getInfo = [[MPGetInfoRequestMessage alloc] initWithDictionary:myDictionary];
                NSLog(@"%@", [getInfo getDictionary]);
                [self sendInfoMessageToPeer:peerID];
            }
            break;
            
            case kMessageTypeGetInfoResponse: {
                NSLog(@"kMessageTypeGetInfoResponse");
                MPGetInfoResponseMessage *getInfo = [[MPGetInfoResponseMessage alloc] initWithDictionary:myDictionary];
                NSDictionary *dict=[getInfo getDictionary];
                NSLog(@"%@", dict);
                [self.delegate didReceiveInfo:dict fromPeer:peerID];
            }
            break;
            
        default: {
            NSLog(@"Unknown Message Type Received");
        }
    }
}

- (void) sendRequestInfoMessageToPeers:(NSArray *) peers {
    MPGetInfoRequestMessage *message = [[MPGetInfoRequestMessage alloc] init];
    [[self.session getMCSession] sendData:[message getData] toPeers:peers withMode:MCSessionSendDataReliable error:nil];
}

- (void) sendInfoMessageToPeer:(MCPeerID *) peerID {
    MPGetInfoResponseMessage *message = [[MPGetInfoResponseMessage alloc] init];
    message.name=@"";
    message.services=[NSArray arrayWithObject:@"MP_SayHello"];
    message.profileImage=[UIImage imageNamed:@"github.gif"];
    [[self.session getMCSession] sendData:[message getData] toPeers:[NSArray arrayWithObjects:peerID, nil] withMode:MCSessionSendDataReliable error:nil];
}

@end
