//
//  SFUMastermindGameTableViewController.h
//  SFU APP
//
//  Created by Tony Dinh on 2015-09-01.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * UITableViewController subclass serves as the gameboard. Game logic is
 * implemented in this class.
 *
 * @author Tony Dinh
 * @version 1.0
 */
@interface SFUMastermindGameTableViewController : UITableViewController

/**
 * Current guess number
 */
@property unsigned int turn;

/**
 * NSMutableArray storing the current guess
 */
@property NSMutableArray *guessCode;

/**
 * NSMutableArray of size equal to number of colours on the colour palette.
 * Tracks user's guess by incrementing the counter at the index corresponding to
 * each colour.
 */
@property NSMutableArray *guessFlags;

/**
 * NSMutableArray storing the secret code to be broken.
 */
@property NSMutableArray *secretCode;

/**
 * NSMutableArray of size equal to number of colours on the colour palette.
 * Tracks the secret code information by incrememnting counter at the index 
 * corresponding to each colour. Used for comparison with guessFlags at the end
 * of each guess.
 */
@property NSMutableArray *secretFlags;

/**
 * Resets the board to intial state for a new game
 */
- (void)beginGame;

/**
 * Submits the guess for the current turn and displays appropriate message at 
 * the end of the game.
 */
- (IBAction)guessButtonPressed:(id)sender;

/**
 * Updates the UI to reflect the changes in user guesses.
 */
- (void) displayCurrentGuess;
@end
