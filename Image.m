//
//  Image.m
//  Artificial I
//
//  Created by Matej Jan on 21.12.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Image.h"
#import "Namespace.XniGame.h"

@implementation Image


- (id) initWithTexture:(Texture2D *)theTexture
              position:(Vector2 *)thePosition
{
	self = [super init];
	if (self != nil) {
		texture = theTexture;
		position = thePosition;
		
		color = [Color white];
		origin = [Vector2 zero];
		scale = [Vector2 one];
	}
	return self;
}

- (id) initWithTexture:(Texture2D *)theTexture
              position:(Vector2 *)thePosition
                 depth:(float)theDepth
{
	self = [super init];
	if (self != nil) {
		texture = theTexture;
		position = thePosition;
		
		color = [Color white];
		origin = [Vector2 zero];
		scale = [Vector2 one];
        
        layerDepth = theDepth;
	}
	return self;
}






@synthesize texture, sourceRectangle, color, position, origin, scale, rotation, layerDepth;

- (void) setScaleUniform:(float)value {
	scale.x = value;
	scale.y = value;
}

@end
