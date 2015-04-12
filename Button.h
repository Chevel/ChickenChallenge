//
//  Button.h
//  friHockey
//
//  Created by Matej Jan on 21.12.10.
//  Modified by snowman
//  Copyright 2010 Retronator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Namespace.XniGame.classes.h"
#import "ISceneUser.h"

#import "Retronator.Xni.Framework.Input.Touch.h"

@interface Button : NSObject <ISceneUser> {
	id<IScene> scene;

	Image *backgroundImage;
	Label *label;
		
	Rectangle *inputArea;
	BOOL enabled;
	
	BOOL isDown;
	BOOL wasPressed;
	BOOL wasReleased;
	int pressedID;	
	
	Color *labelColor, *labelHoverColor, *backgroundColor, *backgroundHoverColor;
    
	
    Matrix *inverseView;
    
}


- (void) setLabelText:(NSString *)txt;

- (void) setCamera:(Matrix *)camera;

- (id) initWithInputArea:(Rectangle*)theInputArea 
              background:(Texture2D*)background 
                    font:(SpriteFont *)font 
                    text:(NSString *)text;

- (id) initWithInputArea:(Rectangle*)theInputArea
                    font:(SpriteFont*)font
                    text:(NSString*)text;

@property (nonatomic, readonly) Rectangle *inputArea;
@property (nonatomic) BOOL enabled;

@property (nonatomic, readonly) BOOL isDown;
@property (nonatomic, readonly) BOOL wasPressed;
@property (nonatomic, readonly) BOOL wasReleased;

@property (nonatomic, readonly) Image *backgroundImage;
@property (nonatomic, readonly) Label *label;

@property (nonatomic, retain) Color *labelColor, *labelHoverColor, *backgroundColor, *backgroundHoverColor;

- (void) update;

- (void) setBackgroundTexture:(Texture2D*) theTexture;

@end
