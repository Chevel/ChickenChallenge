//
//  GameState.m
//  friHockey
//
//  Created by Matej Jan on 22.12.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Namespace.XniGame.h"

@implementation GameState

- (id) initWithGame:(Game *)theGame
{
	self = [super initWithGame:theGame];
	if (self != nil) {
		igra = (Igra*)self.game;
	}
	return self;
}

- (void) activate {
    NSLog(@" GAMESTATE --> ACTIVATE() ");
}


- (void) deactivate {
    NSLog(@" GAMESTATE --> DEACTIVATE() ");
}





@end
