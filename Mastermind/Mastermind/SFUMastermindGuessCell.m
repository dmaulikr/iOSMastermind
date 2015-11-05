//
//  SFUMastermindGuessCell.m
//  SFU APP
//
//  Created by Tony Dinh on 2015-09-02.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUMastermindGuessCell.h"
#import "SFUMastermindGameTableViewController.h"



@implementation SFUMastermindGuessCell
- (void)awakeFromNib{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
   
    _guessButton.tintColor = [UIColor colorWithRed:34.0f/255.0f green:181.0f/255.0f blue:115.0f/255.0f alpha:1];
    NSArray *buttons = @[_colour1,
                         _colour2,
                         _colour3,
                         _colour4,
                         _colour5];
    
    NSArray *pegs = @[_peg1,
                      _peg2,
                      _peg3,
                      _peg4,
                      _peg5];

    int i = 0;
    for (UIButton *colour in buttons){
        @autoreleasepool {
            colour.tag = i;
            colour.layer.masksToBounds = YES;
            colour.layer.cornerRadius = colour.frame.size.height/2;
            [colour addTarget:self
                       action:@selector(removeColour:)
             forControlEvents:UIControlEventTouchUpInside];
        }
        i++;
    }
    
    i = 0;
    for (UILabel *peg in pegs){
        @autoreleasepool {
            peg.tag = i;
            peg.layer.masksToBounds = YES;
            peg.layer.cornerRadius = peg.frame.size.height/2;
        }
        i++;
    }
}

- (void) reset{
    _turnLabel.textColor = SFUBlack;
    _turnLabel.text = [self romanTurn];

    NSArray *pegs = @[_peg1,
                      _peg2,
                      _peg3,
                      _peg4,
                      _peg5];
    
    NSArray *buttons = @[_colour1,
                         _colour2,
                         _colour3,
                         _colour4,
                         _colour5];

    for (UILabel *peg in pegs){
        @autoreleasepool {
            peg.backgroundColor = [UIColor lightGrayColor];
        }
    }
    
    for (UIButton *colour in buttons){
        @autoreleasepool {
           colour.backgroundColor = [UIColor lightGrayColor];
        }
    }
    //--- disable guess button ---//
    [_guessButton setEnabled: NO];
    [_guessButton setHidden: NO];
    [self setUserInteractionEnabled:YES];
}


- (NSString *) romanTurn{
    switch (_turn) {
        case 1:
            return @"I";
            break;
        case 2:
            return @"II";
            break;
        case 3:
            return @"III";
            break;
        case 4:
            return @"IV";
            break;
        case 5:
            return @"V";
            break;
        case 6:
            return @"VI";
            break;
        case 7:
            return @"VII";
            break;
        default:
            return @"VIII";
            break;
    }
}

- (void) removeColour: (id) sender{
    
    if(_turn != _gameBoard.turn) return;
    
    UIButton *colour = (UIButton*) sender;
    colour.backgroundColor = [UIColor lightGrayColor];
    int index = (int)colour.tag;
    int colourRemoved = [[_gameBoard.guessCode objectAtIndex:index] intValue];
   
    NSLog(@"index to be cleared: %i", index);
    NSLog(@"value at index: %i", colourRemoved);
    
    if (colourRemoved >= 0){
        [_gameBoard.guessCode replaceObjectAtIndex:index withObject:@(-1)];
        NSNumber *counter = [NSNumber numberWithInt:
            [[_gameBoard.guessFlags objectAtIndex:colourRemoved] intValue]- 1];
        
        [_gameBoard.guessFlags replaceObjectAtIndex:colourRemoved withObject:counter];
        
        NSLog(@"Guess: %@", _gameBoard.guessCode);
        NSLog(@"Guess flags: %@", _gameBoard.guessFlags);
        [_gameBoard displayCurrentGuess];
    }
    
}

- (void) updateGuessWithCode: (NSArray *) guessCode{

    NSLog(@"Current guess: %@", guessCode);
    
    for (int i = 0 ; i < 5 ; i ++){
        @autoreleasepool {
            [self setGuess:i
         withColourAtIndex:[guessCode[i] integerValue]];
        }
    }
    if([self coloursFull]) [_guessButton setEnabled:YES];
    else [_guessButton setEnabled: NO];

    
}
- (void) setGuess: (int) position
withColourAtIndex: (NSInteger) index
{
    NSArray *buttons = @[_colour1,
                         _colour2,
                         _colour3,
                         _colour4,
                         _colour5];
    UIButton *guessPosition = (UIButton*)buttons[position];

    if (index < 0){
        [UIView animateWithDuration:0.5 animations:^{
           guessPosition.backgroundColor = [UIColor lightGrayColor];
        }completion:nil];
        
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            guessPosition.backgroundColor = colourCode[index];
        }completion:nil];
        
    }


}

- (BOOL) coloursFull{
    unsigned int coloursFilled = 0;
    for (NSNumber *guess in _gameBoard.guessCode){
        @autoreleasepool {
            if([guess intValue] >= 0){
                coloursFilled++;
            }
        }
    }
    NSLog(@"colours filled: %u", coloursFilled);
    if(coloursFilled == 5) return YES;
    else return NO;
}

- (int) correctColour{
    unsigned int correctColours = 0;
    
    //--- count flags ---//
    for (int i = 0 ; i < 8 ; i ++){
        @autoreleasepool {
            correctColours+= MIN([_gameBoard.guessFlags[i] intValue],
                                 [_gameBoard.secretFlags[i] intValue]);
        }
    }
    
    NSLog(@"correctColours: %u", correctColours);
    return correctColours;
}

- (int) correctColourANDPosition{
    unsigned int correctCOL_POS = 0;
    for (int i = 0 ; i < 5 ; i ++){
        @autoreleasepool {
            if ([_gameBoard.guessCode[i] intValue] ==
                [_gameBoard.secretCode[i] intValue])
            {
                correctCOL_POS ++;
            }
        }
    }
    NSLog(@"correctColoursANDPos: %u", correctCOL_POS);
    return correctCOL_POS;
}

- (void) colourPegs: (int) numCorrectColoursANDPositions
              outOf: (int) numCorrectColours
{
    NSArray *pegs = @[_peg1,
                      _peg2,
                      _peg3,
                      _peg4,
                      _peg5];
    
    for (int i = 0 ; i < numCorrectColours ; i++){
        @autoreleasepool {
            UILabel *peg = pegs[i];
            if(i <numCorrectColoursANDPositions){
                    peg.backgroundColor = SFUBlack;
               
            }else{
                    peg.backgroundColor = SFURed;
            }
            
        }
    }
}

- (BOOL) correctGuess{
    int correctColours = [self correctColour];
    int correctColoursANDPositions = [self correctColourANDPosition];
    
    [self updateGuessWithCode:_guess];
    if( correctColoursANDPositions == 5){
        [self colourPegs: 5
                   outOf: correctColours];
        return YES;
    }else{
        [self colourPegs: correctColoursANDPositions
                   outOf: correctColours];
        return NO;
    }
}
@end
