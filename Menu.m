//
//  Menu.m
//  friHockey
//
//  Created by Matej Jan on 22.12.10.
//  Modified by snowman
//  Copyright 2010 Retronator. All rights reserved.
//


#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Content.Pipeline.Processors.h"
#import "Igra.h"
#import "Namespace.XniGame.h"

@class Igra;


@implementation Menu

- (id) initWithGame:(Game *)theGame {
	self = [super initWithGame:theGame];
	if (self != nil) {
        
        // SCENE FOR ALL GUI-OBJECTS
		scene = [[Scene alloc] initWithGame:self.game];
        
		renderer = [[GuiRenderer alloc] initWithGame:self.game scene:scene];
        
	}
	return self;
}

@synthesize scene;  
@synthesize renderer;  

- (void) initialize {
    
	// Fonts
	FontTextureProcessor *fontProcessor = [[FontTextureProcessor alloc] init];
	screenFont = [self.game.content load:@"Retrotype" processor:fontProcessor]; 
    screenFont.lineSpacing = 7;
    
    
    buttonFont = [self.game.content load:@"RetrotypeMain" processor:fontProcessor];  
    buttonFont.lineSpacing = 7;
    
    
    screenFontBig = [self.game.content load:@"Retrotype_BIG" processor:fontProcessor];  
    screenFontBig.lineSpacing = 7;
    
    
    // BLACK SCREEN "loading" ON INIT
    [renderer.graphicsDevice clearWithColor:[Color black]];  
    
    
	[super initialize];
    
}


- (void) activate {
    
    [self.game.components addComponent:scene];
	[self.game.components addComponent:renderer];
    
}

- (void) deactivate {
    
	[self.game.components removeComponent:scene];
	[self.game.components removeComponent:renderer];
    
}




- (void) updateWithGameTime:(GameTime *)gameTime {
    
    //NSLog(@" UPDATE ");
    
    
	// Update all buttons.
	for (id item in scene) {
		Button *button = [item isKindOfClass:[Button class]] ? item : nil;
		
		if (button) {
			[button update];
		}
	}	
 
    

    
    
    
    
    
     
}



@end
