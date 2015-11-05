//
//  SFUMastermindMenuViewController.h
//  SFU APP
//
//  Created by Tony Dinh on 2015-09-01.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * UIViewController subclass. Serves as the Menu Screen for Mastermind game.
 *
 * @author Tony Dinh
 * @version 1.0
 */
@interface SFUMastermindMenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)playForFunPressed:(id)sender;


@end
