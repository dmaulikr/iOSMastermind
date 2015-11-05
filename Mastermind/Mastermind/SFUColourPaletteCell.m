//
//  SFUColourPaletteCell.m
//  SFU APP
//
//  Created by Tony Dinh on 2015-09-01.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUColourPaletteCell.h"
#import "SFUMastermindGameTableViewController.h"

#define codeLength 5

@implementation SFUColourPaletteCell
- (void)awakeFromNib {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSArray *buttons = @[_colour1,
                         _colour2,
                         _colour3,
                         _colour4,
                         _colour5,
                         _colour6,
                         _colour7,
                         _colour8];
    
    int i = 0;
    for (UIButton *colour in buttons){
        @autoreleasepool {
            colour.tag = i;
            //colour.layer.masksToBounds = YES;
            colour.layer.cornerRadius = colour.frame.size.height/2;
            [colour addTarget:self
                         action:@selector(colourIndex:)
               forControlEvents:UIControlEventTouchUpInside];
        }
        i++;
    }
    
}

- (void) colourIndex: (id)sender{
    int chosenColour = (int)((UIButton *) sender).tag;
    NSNumber *num = [NSNumber numberWithInt:chosenColour];
    for (int i = 0 ; i < codeLength ; i ++){
        @autoreleasepool {
            if ([_gameBoard.guessCode[i] intValue] < 0){
                [_gameBoard.guessCode replaceObjectAtIndex:i
                                                withObject:num];
                
                //--- Keep track of current colours guessed ---//
                NSNumber *counter = [NSNumber numberWithInt:
                        [[_gameBoard.guessFlags
                          objectAtIndex:chosenColour]
                         intValue]+1];
                
                [_gameBoard.guessFlags replaceObjectAtIndex:chosenColour
                                                 withObject:counter];
                NSLog(@"Guess: %@", _gameBoard.guessCode);
                NSLog(@"Guess flags: %@", _gameBoard.guessFlags);
                [_gameBoard displayCurrentGuess];
                return;
            }
        }
    }
    NSLog(@"Guess: %@", _gameBoard.guessCode);
    NSLog(@"Guess flags: %@", _gameBoard.guessFlags);
    return ;
}
@end
