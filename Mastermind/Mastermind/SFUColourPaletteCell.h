//
//  SFUColourPaletteCell.h
//  SFU APP
//
//  Created by Tony Dinh on 2015-09-01.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFUMastermindGameTableViewController;
@interface SFUColourPaletteCell : UITableViewCell

@property IBOutlet UIButton *colour1;
@property IBOutlet UIButton *colour2;
@property IBOutlet UIButton *colour3;
@property IBOutlet UIButton *colour4;
@property IBOutlet UIButton *colour5;
@property IBOutlet UIButton *colour6;
@property IBOutlet UIButton *colour7;
@property IBOutlet UIButton *colour8;
- (void) colourIndex: (id)sender;

@property SFUMastermindGameTableViewController *gameBoard;

@end
