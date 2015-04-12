//
//  GameState.h
//  friHockey
//
//  Created by Matej Jan on 22.12.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.h" //could not find interface declaration fix
#import "Namespace.XniGame.classes.h"

@interface GameState : GameComponent {
	Igra *igra;
}

- (void) activate;
- (void) deactivate;

@end
