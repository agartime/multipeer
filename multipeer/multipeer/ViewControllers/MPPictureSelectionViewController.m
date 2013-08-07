//
//  MPPictureSelectionViewController.m
//  multipeer
//
//  Created by Antonio González Artime on 07/08/13.
//  Copyright (c) 2013 Antonio González Artime. All rights reserved.
//

#import "MPPictureSelectionViewController.h"

@interface MPPictureSelectionViewController ()

@end

@implementation MPPictureSelectionViewController

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
    self.navigationController.navigationBarHidden = YES;

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didClickedPictureButton:(id)sender {
}
@end
