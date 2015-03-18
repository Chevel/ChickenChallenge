//
//  HumanPlayer.h
//  XniGame
//
//  Created by snowman on 11/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Namespace.XniGame.classes.h"
#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.h"

@interface AIPlayer : GameComponent{
    
    Rat *rat;
	Rectangle *inputArea;
	BOOL grabbed;
    
}

- (id) initWithGame:(Game *)theGame
                rat:(Rat *)theRat;

@end

