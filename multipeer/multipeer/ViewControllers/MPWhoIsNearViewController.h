//
//  MPWhoIsNearViewController.h
//  multipeer
//
//  Created by Antonio González Artime on 07/08/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MPP2PFacade.h"

@interface MPWhoIsNearViewController : UICollectionViewController <MPP2PFacadeViewDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
