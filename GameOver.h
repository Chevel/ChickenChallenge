//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Menu.h"

#import "Namespace.XniGame.classes.h"

@interface GameOver: Menu {
    
    Label *title;
    Label *difficulty;
    Label *score;
    Label *bestScore;
    
    Button *restartGame;
    Button *submit;
    Button *resetGame;
    
    float tmpPositionX;
    
}
@property float tmpPositionX;

- (void) setScore:(int)currentScore Best:(int)bestPoints;

- (void) setDisplayMessage:(NSString*)theTitle;

@end
