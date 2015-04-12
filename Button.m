//
//  Button.m
//  friHockey
//
//  Created by Matej Jan on 21.12.10. 
//  Modified by snowman
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Button.h"

#import "Retronator.Xni.Framework.Input.Touch.h"

#import "Namespace.XniGame.h"



@implementation Button


- (id) initWithInputArea:(Rectangle*)theInputArea
			 background:(Texture2D*)background
				   font:(SpriteFont*)font 
				   text:(NSString*)text
{
	self = [super init];
	if (self != nil) {
		
		inputArea = theInputArea;
        
        
		enabled = YES;
				
		backgroundImage = [[Image alloc] 
                           initWithTexture:background 
                           position:[Vector2 vectorWithX:inputArea.x
                                                       y:inputArea.y
                                     ]
                           ];
        
        
		label = [[Label alloc] initWithFont:font 
									   text:text 
								   position:[Vector2 vectorWithX:inputArea.x + (inputArea.width/2)
                                                               y:inputArea.y + (inputArea.height/2)
                                             ]
                                      depth:0.1
                 ];
        
		label.verticalAlign = VerticalAlignMiddle;
        label.horizontalAlign = HorizontalAlignCenter;
        
		self.backgroundColor = [Color white];
		self.backgroundHoverColor = [Color dimGray];
        
		self.labelColor = [Color black];
		self.labelHoverColor = [Color black];
		
		
		
	}
	return self;
}

- (id) initWithInputArea:(Rectangle*)theInputArea
                    font:(SpriteFont*)font
                    text:(NSString*)text
{
	self = [super init];
	if (self != nil) {
		
		inputArea = theInputArea;
        
        
		enabled = YES;
        
		label = [[Label alloc] initWithFont:font
									   text:text
								   position:[Vector2 vectorWithX:inputArea.x + inputArea.width/2 + 10
                                                               y:inputArea.y + (inputArea.height/2)+5
                                             ]
                                      depth:0.1
                 ];
        
		label.verticalAlign = VerticalAlignMiddle;
        label.horizontalAlign = HorizontalAlignCenter;

        
		self.backgroundColor = [Color white];
		self.backgroundHoverColor = [Color dimGray];
        
		
		self.labelColor = [Color black];
		self.labelHoverColor = [Color black];
		
	}
	return self;
}



@synthesize inputArea, enabled, isDown, wasPressed, wasReleased, scene, backgroundImage, label;

@synthesize labelColor, labelHoverColor, backgroundColor, backgroundHoverColor;


- (void) setLabelText:(NSString *)txt{
    [self.label setText:txt];
}

- (void) setLabelColor:(Color *)value {
    
    labelColor = value;
    
    
	label.color = labelColor;
}

- (void) setBackgroundColor:(Color *)value {
	backgroundColor = value;
	backgroundImage.color = backgroundColor;
}

- (void) setCamera:(Matrix *)theCamera {
	inverseView = [Matrix invert:theCamera];
}

- (void) setBackgroundTexture:(Texture2D *)theTexture
{
    backgroundImage = [[Image alloc]
     initWithTexture:theTexture
     position:[Vector2 vectorWithX:inputArea.x
                                 y:inputArea.y
               ]
     ];
}


- (void) addedToScene:(id <IScene>)theScene {
	// Add child items to scene.
	[theScene addItem:backgroundImage];
	[theScene addItem:label];
}

- (void) removedFromScene:(id <IScene>)theScene {
	// Remove child items.
	[theScene removeItem:backgroundImage];
	[theScene removeItem:label];
}





- (void) update {	
	if (!enabled) {
		return;
	}
		
	TouchCollection *touches = [TouchPanelHelper getState];
	if (!touches) {
		return;
	}
		
	BOOL wasDown = isDown;
	
	isDown = NO;
	wasPressed = NO;
	wasReleased = NO;
	
	for (TouchLocation *touch in touches) {
        
        // touch.position <----- ----> touchInScene
        // because we ahve device resolution and virtual world
        // transofrm coordinates between the two

        // INIT INVERSE VIEW BEFORE THIS  !!!! either call setCamera or hand-code
        if(inverseView==nil){
        
            NSLog(@"INVERSE VIEW NOT INITIALIZED");
        }
        
        Vector2* touchInScene = [Vector2 transform:touch.position with:inverseView];
        
           
           
		if ([inputArea containsVector:touchInScene] && touch.state != TouchLocationStateInvalid) {
            
            
			if (touch.state == TouchLocationStatePressed) {
				pressedID = touch.identifier;
				wasPressed = YES;
			}
			
			// Only act to the touch that started the push.
			if (touch.identifier == pressedID) {
				if (touch.state == TouchLocationStateReleased) {
					wasReleased = YES;
				} else {
					isDown = YES;		
				}
			}
		}
	}
		
	if (isDown && !wasDown) {
		backgroundImage.color = backgroundHoverColor;
		label.color = labelHoverColor;
	}
    else if (!isDown && wasDown) {
		backgroundImage.color = backgroundColor;
		label.color = labelColor;
	}
}

@end
