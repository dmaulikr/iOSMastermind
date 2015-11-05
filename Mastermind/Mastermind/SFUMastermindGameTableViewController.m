//
//  SFUMastermindGameTableViewController.m
//  SFU APP
//
//  Created by Tony Dinh on 2015-09-01.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#include <stdlib.h>
#import "SCLAlertView.h"
#import "SFUColourPaletteCell.h"
#import "SFUMastermindGuessCell.h"
#import "SFUMastermindSecretCodeCell.h"
#import "SFUMastermindGameTableViewController.h"



#define numGuesses 8
#define codeLength 5

@implementation SFUMastermindGameTableViewController
{
    UIButton *menuButton;
    BOOL locked;
}

#pragma ========================================================================
#pragma mark - View Delegate Methods
#pragma ========================================================================

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initializeButtons];
    [self.tableView setScrollEnabled:NO];
    
    [self beginGame];

}

#pragma ========================================================================
#pragma mark - Initialization Methods
#pragma ========================================================================
- (void)initializeButtons{
    menuButton = [[UIButton alloc] init];
    menuButton.backgroundColor = SFUBlack;
    menuButton.layer.cornerRadius = 3;
    [menuButton setEnabled:YES];
    
    [menuButton setTitle:@"Menu" forState:UIControlStateNormal];
    [menuButton addTarget:self
                   action:@selector(displayMenu)
         forControlEvents:UIControlEventTouchUpInside];
    
    [menuButton setFrame:
     CGRectMake(self.tableView.frame.size.width-68, 27, 60, 30)];
}

- (void)initializeArrays{
    //--- Empty out Arrays ---//
    if(!_secretFlags) _secretFlags = [[NSMutableArray alloc]
                                      initWithCapacity:numGuesses];

    if(!_guessFlags) _guessFlags = [[NSMutableArray alloc]
                                    initWithCapacity:numGuesses];
    
    if(!_secretCode) _secretCode = [[NSMutableArray alloc]
                                    initWithCapacity:codeLength];
    
    if(!_guessCode) _guessCode = [[NSMutableArray alloc]
                                  initWithCapacity:codeLength];
    
    [self resetCode: _guessCode];
    [self resetCode: _secretCode];
    [self zero: _secretFlags];
    [self zero: _guessFlags];
    
}

- (void) zero: (NSMutableArray *) array
{
    [array removeAllObjects];
    for (int i = 0 ; i < numGuesses ; i ++){
        @autoreleasepool {
            [array insertObject: @0 atIndex:i];
        }
    }
    NSLog(@"%@",array);
}

- (void) resetCode: (NSMutableArray *)array{
    [array removeAllObjects];
    for (int i = 0 ; i < codeLength ; i ++){
        @autoreleasepool {
            [array insertObject: @(-1) atIndex:i];
        }
    }
    NSLog(@"%@",array);
}
#pragma ========================================================================
#pragma mark - Menu Button Functionality
#pragma ========================================================================

- (void) displayMenu{
    NSLog(@"menuButtonPressed");
    SCLAlertView *menu = [[SCLAlertView alloc] initWithNewWindow];
    menu.showAnimationType = FadeIn;
    menu.iconTintColor = [UIColor whiteColor];
    [menu removeTopCircle];
    [menu addButton:@"Restart" actionBlock:^{
        [self beginGame];

    }];
    
    [menu addButton:@"Help" actionBlock:^{
        SCLAlertView *help = [[SCLAlertView alloc] initWithNewWindow];
        help.showAnimationType = FadeIn;
        help.iconTintColor = [UIColor whiteColor];
        help.viewText.textAlignment = NSTextAlignmentLeft;

        [help showCustom:[UIImage imageNamed:@"helpIcon"]
                   color:ordinaryPurple
                   title:@"Help"
                subTitle:@"\tSolve the puzzle by selecting the correct "
         "combination of colours within 8 tries. \n\n\tEach guess will provide "
         "some information: \n\n • A small red dot indicates there is a correct"
         " colour in the incorrect spot.\n • A small black dot indicates there "
         "is a correct colour in the correct spot.\n"
         
        closeButtonTitle:@"Dismiss" duration:0.0f];
    }];
    
    [menu addButton:@"Quit" actionBlock:^{
        [self.presentingViewController
         dismissViewControllerAnimated:YES
         completion:nil];
    }];
    
    [menu showCustom:nil
               color:SFUBlack
               title:nil
            subTitle:nil
    closeButtonTitle:@"Cancel"
            duration:0.0f];
}

#pragma ========================================================================
#pragma mark - Table View Delegate Methods
#pragma ========================================================================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return numGuesses;
            break;
        case 2:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}

-(NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 64;
            break;
        default:
            return 15;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView
    viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *header = [[UIView alloc] initWithFrame:
                          CGRectMake(0,0,self.tableView.frame.size.width,64)];
        [header addSubview:menuButton];
        [self.tableView addSubview:header];
        return header;
        
    }else return [super tableView:tableView viewForHeaderInSection:section];
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = (int)indexPath.section;
    if (section == 0)
    {
        SFUMastermindSecretCodeCell *secretCodeCell =
        [tableView dequeueReusableCellWithIdentifier:@"secretCodeCell"];
        secretCodeCell.gameBoard = self;
        return secretCodeCell;
        
    }else if (section == 1)
    {
        SFUMastermindGuessCell *guessCell =
        [tableView dequeueReusableCellWithIdentifier:@"SFUMastermindGuessCell"];
        guessCell.turn = numGuesses - (int)indexPath.row;
        guessCell.guessButton.tag = numGuesses - (int)indexPath.row;
        guessCell.gameBoard = self;
        [guessCell reset];
        return guessCell;
    }else
    {
        SFUColourPaletteCell *colourPalette =
        [tableView dequeueReusableCellWithIdentifier:@"SFUColourPaletteCell"];
        colourPalette.gameBoard = self;
        colourPalette.colour1.backgroundColor = colourCode[0];
        colourPalette.colour2.backgroundColor = colourCode[1];
        colourPalette.colour3.backgroundColor = colourCode[2];
        colourPalette.colour4.backgroundColor = colourCode[3];
        colourPalette.colour5.backgroundColor = colourCode[4];
        colourPalette.colour6.backgroundColor = colourCode[5];
        colourPalette.colour7.backgroundColor = colourCode[6];
        colourPalette.colour8.backgroundColor = colourCode[7];
        return colourPalette;
    }
}

#pragma ========================================================================
#pragma mark - Mastermind Game
#pragma ========================================================================

- (void)beginGame{
    if(locked) return;
    locked = YES;
    
    SFUMastermindSecretCodeCell *codeCell;
    codeCell = (SFUMastermindSecretCodeCell *)
    [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                             inSection:0]];
    [self resetGuesses];
    [self initializeArrays];
    [self generateSecretCode];
    [codeCell hideCode];
   
     _turn = 1;
    locked = NO;
    
}

- (void)generateSecretCode{

    //--- Generate a random code ---//
    for ( int i = 0 ; i < codeLength ; i ++){
        @autoreleasepool {
            int r = arc4random_uniform(8);
            NSNumber *num = [NSNumber numberWithInt:r];
            [_secretCode replaceObjectAtIndex:i withObject:num];
            
            //--- Keep track of current colours guessed ---//
            NSNumber *counter = [NSNumber numberWithInt:
                                 [[_secretFlags objectAtIndex:r] intValue]+1];
            
            [_secretFlags replaceObjectAtIndex:r withObject:counter];
        }
    }

    NSLog(@"code: %@", _secretCode);
    NSLog(@"flags: %@", _secretFlags);
}

- (void) resetGuesses{
    for (int i = 0 ; i < numGuesses ; i ++){
        @autoreleasepool {
            SFUMastermindGuessCell *guess =
            (SFUMastermindGuessCell*)[self.tableView cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:i inSection:1]];
            [guess reset];
        }
        
    }
}

- (void) displayCurrentGuess{
    @autoreleasepool {
        NSLog(@"updating for turn: %u", _turn);
        SFUMastermindGuessCell *currentTurn =
            (SFUMastermindGuessCell *)[self.tableView cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:numGuesses -_turn inSection:1]];
        
        [currentTurn updateGuessWithCode:_guessCode];
    }
  
}

- (IBAction)guessButtonPressed:(id)sender
{
    @autoreleasepool {
        NSLog(@"updating for turn: %u", _turn);
        SFUMastermindGuessCell *currentTurn =
            (SFUMastermindGuessCell *)[self.tableView cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:numGuesses -_turn inSection:1]];
        
        currentTurn.guess = [_guessCode copy];
        [currentTurn setUserInteractionEnabled: NO];
        UIButton *guessButton = (UIButton *)sender;
        [guessButton setHidden:YES];
        
        if([currentTurn correctGuess]){
            NSLog(@"gameOver");
            SFUMastermindSecretCodeCell *codeCell =
            (SFUMastermindSecretCodeCell *)[self.tableView cellForRowAtIndexPath:
            [NSIndexPath indexPathForRow:0 inSection:0]];
            [codeCell showCode];
            [self showWinMessage];
            
        }else{
            if(_turn == numGuesses){
                SFUMastermindSecretCodeCell *codeCell =
                (SFUMastermindSecretCodeCell *)[self.tableView cellForRowAtIndexPath:
                [NSIndexPath indexPathForRow:0 inSection:0]];
                [codeCell showCode];
                [self showLoseMessage];
                
            }else{
                [self setUpForNextTurn];
            }
        }
    }
}

- (void) setUpForNextTurn{
    _turn++;
    [self resetCode: _guessCode];
    [self zero:_guessFlags];
    NSLog(@"new turn: %u", _turn);
}
- (void) showWinMessage{
    SCLAlertView *message = [[SCLAlertView alloc] initWithNewWindow];
    message.showAnimationType = FadeIn;
    message.iconTintColor = [UIColor whiteColor];
    [message addButton:@"Play Again" actionBlock:^{
        [self beginGame];
    }];
    [message showSuccess:@"Congrats!"
                subTitle:@"You win nothing"
        closeButtonTitle:@"Dismiss"
                duration:0.0f];
}

- (void) showLoseMessage{
    SCLAlertView *message = [[SCLAlertView alloc] initWithNewWindow];
    message.showAnimationType = FadeIn;
    message.iconTintColor = [UIColor whiteColor];
    [message addButton:@"Play Again" actionBlock:^{
        [self beginGame];
    }];
    [message showCustom:[UIImage imageNamed:@"privacyIcon"]
                  color:SFURedIOS
                  title:@"Sorry!"
               subTitle:@"You lose"
       closeButtonTitle:@"Dismiss"
               duration:0.0f];
    
}

@end
