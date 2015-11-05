//
//  SFUMastermindSecretCodeCell.m
//  SFU APP
//
//  Created by Tony Dinh on 2015-09-02.
//  Copyright (c) 2015 Simon Fraser University. All rights reserved.
//

#import "SFUMastermindSecretCodeCell.h"

static NSArray *buttons;

@implementation SFUMastermindSecretCodeCell{
    BOOL show;
}

- (void)awakeFromNib{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setUserInteractionEnabled:NO];
     buttons = @[_colour1,
                 _colour2,
                 _colour3,
                 _colour4,
                 _colour5];
    
    int i = 0;
    for (UIButton *colour in buttons){
        @autoreleasepool {
            colour.tag = i;
            colour.layer.masksToBounds = YES;
            colour.layer.cornerRadius = colour.frame.size.height/2;
        }
        i++;
    }
    [self hideCode];
}
-(void) showCode{

    for (int i = 0 ; i < 5 ; i ++){
        @autoreleasepool {
            UIButton *colour = (UIButton *)buttons[i];
            
            int colour_i = [_gameBoard.secretCode[i] intValue];
            
            colour.backgroundColor = colourCode[colour_i];
            colour.titleLabel.textColor = [UIColor clearColor];
        }
    }

}

-(void) hideCode{
    
    for (UIButton *colour in buttons){
        @autoreleasepool {
            colour.backgroundColor = [UIColor lightGrayColor];
            colour.titleLabel.textColor = [UIColor whiteColor];
        }
    }
}
@end
