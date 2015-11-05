//
//  SFUMastermindGuessCell.h
//  SFU APP
//
//  Created by Tony Dinh on 2015-09-02.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SFUMastermindGameTableViewController;

@interface SFUMastermindGuessCell : UITableViewCell
@property int turn;
@property SFUMastermindGameTableViewController *gameBoard;
@property (nonatomic, weak) IBOutlet UILabel *turnLabel;

@property IBOutlet UIButton *colour1;
@property IBOutlet UIButton *colour2;
@property IBOutlet UIButton *colour3;
@property IBOutlet UIButton *colour4;
@property IBOutlet UIButton *colour5;

@property IBOutlet UILabel *peg1;
@property IBOutlet UILabel *peg2;
@property IBOutlet UILabel *peg3;
@property IBOutlet UILabel *peg4;
@property IBOutlet UILabel *peg5;

@property IBOutlet UIButton *guessButton;
@property NSArray *guess;

- (void)reset;
- (int)correctColour;
- (int)correctColourANDPosition;
- (void) setGuess: (int) position
withColourAtIndex: (NSInteger) index;
- (void) updateGuessWithCode: (NSArray *)guessCode;
- (BOOL) correctGuess;
@end
