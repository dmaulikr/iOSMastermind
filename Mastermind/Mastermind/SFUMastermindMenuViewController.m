//
//  SFUMastermindMenuViewController.m
//  SFU APP
//
//  Created by Tony Dinh on 2015-09-01.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUMastermindMenuViewController.h"
#import "SFUMastermindGameTableViewController.h"
@implementation SFUMastermindMenuViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //--- Set aesthetics for PLAY button ---//
    _playButton.layer.cornerRadius = 3;
    _playButton.backgroundColor = SFURedIOS;
    _playButton.tintColor = [UIColor whiteColor];
}

- (IBAction)playForFunPressed:(id)sender {
    //--- Present game board ---//
    SFUMastermindGameTableViewController *gameBoard =
        [self.storyboard instantiateViewControllerWithIdentifier:
                        @"SFUMastermindGameTableViewController"];

    [self presentViewController:gameBoard animated:YES completion:nil];
}

@end
