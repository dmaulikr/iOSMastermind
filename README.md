

## Mastermind Objective-C
###### Implemented by Tony Dinh
**Version 1.0** -- Xcode 6.4 and above.

Mastermind is a code-breaking game. In this implementation, the player's objective is to correctly guess the hidden 5-length code within 8 tries.

#### How to Play


**2.** Make a guess by selecting colours from the colour palette at the bottom of the screen. Then tap `OK`.

**3.** After each guess, information will be given through the 5 small pegs.

  * **Red Peg: Correct Colour - Incorrect Spot**  
     
    ![Screenshot](/Screenshots/ss3.png)

> A red peg indicates that from the guess, one of the colours pair with one from the secret code 
> but it is in the incorrect spot.

  * **Black Peg: Correct Colour - Correct Spot**

      ![Screenshot](/Screenshots/ss4.png)

> A black peg indicates that from the guess, one of the colours pair with one from the secret code 
> and it is in the correct spot.

**4.** Use the information gained from the previous guesses to make your next guess.
![Screenshot](/Screenshots/ss1.png)
