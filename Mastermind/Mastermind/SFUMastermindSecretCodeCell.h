//
//  SFUMastermindSecretCodeCell.h
//  SFU APP
//
//  Created by Tony Dinh on 2015-09-02.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFUMastermindGameTableViewController.h"

@interface SFUMastermindSecretCodeCell : UITableViewCell
@property SFUMastermindGameTableViewController *gameBoard;
@property (weak, nonatomic) IBOutlet UIButton *colour1;
@property (weak, nonatomic) IBOutlet UIButton *colour2;
@property (weak, nonatomic) IBOutlet UIButton *colour3;
@property (weak, nonatomic) IBOutlet UIButton *colour4;
@property (weak, nonatomic) IBOutlet UIButton *colour5;

-(void) showCode;
-(void) hideCode;
@end
