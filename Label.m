//
//  Label.m
//  Artificial I
//
//  Created by Matej Jan on 20.12.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Namespace.XniGame.h"

#import "Retronator.Xni.Framework.Graphics.h"

@interface Label ()

- (void) updateOrigin;

@end



@implementation Label

- (id) initWithFont:(SpriteFont*)theFont
               text:(NSString*)theText
           position:(Vector2*)thePosition
              depth:(float)theDepth
{
	self = [super init];
	if (self != nil) {
		font = theFont;
		text = theText;
		position = thePosition;
		
		color = [Color white];
		origin = [Vector2 zero];
		scale = [Vector2 one];
		
        layerDepth = theDepth;
	}
	return self;
}


- (id) initWithFont:(SpriteFont*)theFont
               text:(NSString*)theText
           position:(Vector2*)thePosition
              depth:(float)theDepth
              color:(Color*)theColor
{
   	self = [super init];
	if (self != nil) {
		font = theFont;
		text = theText;
		position = thePosition;
		
		color = theColor;
		origin = [Vector2 zero];
		scale = [Vector2 one];
		
        layerDepth = theDepth;
	}
	return self;
    
}

@synthesize font, text, color, position, origin, scale, rotation, layerDepth, horizontalAlign, verticalAlign;



- (void) setFont:(SpriteFont *)value {
	font = value;
	[self updateOrigin];
}

- (void) setText:(NSString *)value {
	text = value;
	[self updateOrigin];
}

- (void) setOrigin:(Vector2 *)value {
	origin = value;
	horizontalAlign = HorizontalAlignCustom;
	verticalAlign = VerticalAlignCustom;
}

- (void) setHorizontalAlign:(HorizontalAlign)value {
	horizontalAlign = value;
	[self updateOrigin];
}

- (void) setVerticalAlign:(VerticalAlign)value {
	verticalAlign = value;
	[self updateOrigin];
}

- (void) setScaleUniform:(float)value {
	scale.x = value;
	scale.y = value;
}



- (void) updateOrigin {
	Vector2 *size = [font measureString:text];

	switch (horizontalAlign) {
		case HorizontalAlignLeft:
			origin.x = 0;
			break;
		case HorizontalAlignCenter:
			origin.x = size.x / 2;
			break;
		case HorizontalAlignRight:
			origin.x = size.x;
			break;
            
        //test to fix warning
        case HorizontalAlignCustom:
            break;
	}
	
	switch (verticalAlign) {
		case VerticalAlignTop:
			origin.y = 0;
			break;
		case VerticalAlignMiddle:
			origin.y = size.y / 2;
			break;
		case VerticalAlignBottom:
			origin.y = size.y;
			break;
            
        //test to fix warning
        case VerticalAlignCustom:
            break;
	}
    
    
    
}


@end
