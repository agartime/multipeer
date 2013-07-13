//
//  MPSession.m
//  multipeer
//
//  Created by Antonio González Artime on 13/07/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import "MPSession.h"

@interface MPSession()
@property (strong, nonatomic) MCSession * session;
@end

@implementation MPSession
@synthesize delegate=_delegate;

- (id)initWithPeerId:(MCPeerID *)peerId {
    if (self = [super init]) {
        self.session = [[MCSession alloc] initWithPeer:peerId securityIdentity:nil encryptionPreference:MCEncryptionNone]; //No Encryption? Come on, it's just a sample!! :)
        
        self.session.delegate = self;
    }
    return self;
}

#pragma mark - MCSessionDelegate

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    NSLog(@"MCSessionDelegate :: didReceiveData :: Received %@ from %@",[data description],peerID);
    [self.delegate session:session didReceiveData:data fromPeer:peerID];
    
    /*
     NSString * message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Received Message" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
     [alert show];
     */
}

- (void)session:(MCSession *)session didReceiveResourceAtURL:(NSURL *)resourceURL fromPeer:(MCPeerID *)peerID {
    NSLog(@"MCSessionDelegate :: didReceiveResourceAtURL :: Received Resource %@ from %@",[resourceURL description],peerID);
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
    NSLog(@"MCSessionDelegate :: didReceiveStream :: Received Stream %@ from %@",[stream description],peerID);
    
}

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    NSLog(@"MCSessionDelegate :: didChangeState :: PeerId %@ changed to state %d",peerID,state);
    
    [self.delegate session:session peer:peerID didChangeState:state];
    /*
     
     if (state == MCSessionStateConnected && self.session) {
     NSError *error;
     [self.session sendData:[@"HELLO" dataUsingEncoding:NSUTF8StringEncoding] toPeers:[NSArray arrayWithObject:peerID] withMode:MCSessionSendDataReliable error:&error];
     }
     */
}

- (BOOL)session:(MCSession *)session shouldAcceptCertificate:(SecCertificateRef)peerCert forPeer:(MCPeerID *)peerID {
    NSLog(@"MCPickerViewControllerDelegate :: shouldAcceptCertificate from peerID :: %@",peerID);
    return TRUE;
}

- (MCSession *) getMCSession {
    return self.session;
}


@end
