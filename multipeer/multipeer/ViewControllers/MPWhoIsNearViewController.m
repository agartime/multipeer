//
//  MPWhoIsNearViewController.m
//  multipeer
//
//  Created by Antonio González Artime on 07/08/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import "MPWhoIsNearViewController.h"
#import "CircledCollectionViewLayout.h"
#import "ServiceCircleCollectionViewCell.h"
#import "MPPeer.h"

@interface MPWhoIsNearViewController () {
    int _itemCount;
}
@end

@implementation MPWhoIsNearViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [MPP2PFacade sharedInstance].peerViewDelegate = self;
    self.navigationController.navigationBarHidden = YES;
    [self.collectionView setCollectionViewLayout:[[CircledCollectionViewLayout alloc] init]];
    [self.collectionView registerClass:[ServiceCircleCollectionViewCell class] forCellWithReuseIdentifier:@"PeerCell"];
    [self.collectionView reloadData];
    self.mapView.delegate=self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return self->_itemCount;//[[INGP2PManager sharedInstance] getPeerCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    ServiceCircleCollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"PeerCell" forIndexPath:indexPath];
    MPPeer * peer = [[MPP2PFacade sharedInstance] getPeerAtIndexPath:indexPath];
    
    if (peer.profileImage) {
        [cell setUserImage:peer.profileImage];
    } else {
        [cell setUserImage:[UIImage imageNamed:@"github.gif"]];
    }
    
    cell.selected=peer.selected;
    return cell;   
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MPPeer * peer = [[MPP2PFacade sharedInstance] getPeerAtIndexPath:indexPath];
    NSLog(@"Selected Peer: %@",peer.getDiscoveryDictionary.description);
    [[MPP2PFacade sharedInstance] selectedPressedInPeerAtIndexPath:indexPath];
    [[MPP2PFacade sharedInstance] invitePeer:peer];
    [[MPP2PFacade sharedInstance] requestInfoToSelectedPeers];
    [self updateView];
}

- (void) updateView {
    [self.collectionView reloadData];
}

#pragma mark - P2P
- (void) didFoundPeer:(MPPeer *) newPeer {
    [self.collectionView performBatchUpdates:^{
        self->_itemCount++;
        [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:0 inSection:0]]];
    } completion:nil];
    
    [self updateView];
}

- (void) didLostPeer:(NSInteger) peerIndex {
    //self.cellCount = self.cellCount - 1;
    [self.collectionView performBatchUpdates:^{
        self->_itemCount--;
        [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:peerIndex inSection:0]]];
        
    } completion:nil];
    [self updateView];
}

- (void) didReceivePeerInfo:(MPPeer *) peer {
    [self updateView];
}

#pragma mark - MapView
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 200, 200);
    [mapView setRegion:region animated:YES];
    
}

- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // Add the view as a subview and position it offscreen just below the current view
    //  [[INGP2PManager sharedInstance] requestInfoToSelectedPeers];
    NSLog(@"Selected Picture");
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
	for (MKAnnotationView *anAnnotationView in views) {
		[anAnnotationView setCanShowCallout:NO];
	}
}

@end
