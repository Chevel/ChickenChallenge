//
//  Menu.h
//  friHockey
//
//  Created by Matej Jan on 22.12.10.
//  Modified by snowman
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Namespace.XniGame.classes.h"
#import "GameState.h"

@interface Menu : GameState {
    
    
	Scene *scene;           
    GuiRenderer *renderer;  
    
	// FONT STUFF
	SpriteFont *screenFont, *buttonFont, *screenFontBig;
	
}

@property (nonatomic, readonly) Scene *scene;
@property (nonatomic, readonly) GuiRenderer *renderer;

@end
