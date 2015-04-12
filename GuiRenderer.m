//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "GuiRenderer.h"

#import "Namespace.XniGame.h"




@implementation GuiRenderer

@synthesize camera;

- (id) initWithGame:(Game*)theGame scene:(id<IScene>)theScene
{
	self = [super initWithGame:theGame];
	if (self != nil) {
		scene = theScene;
        
        // SCALE
        // RETINA v.s. NON-RETINA
        //
        float scaleX;
        float scaleY;
        if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
            ([UIScreen mainScreen].scale == 2.0))
        {
            scaleX = 2;
            scaleY = 2;
        }
        else {
            scaleX = 1;
            scaleY = 1;
        }
        camera = [Matrix createScale:[Vector3 vectorWithX:scaleX
                                                        y:scaleY
                                                        z:1]
                  ];
	}
	return self;
}




- (void) loadContent {
	spriteBatch = [[SpriteBatch alloc] initWithGraphicsDevice:self.graphicsDevice ];
    FontTextureProcessor *fontProcessor = [[FontTextureProcessor alloc] init];
    
	crkopis = [self.game.content load:@"Retrotype" processor:fontProcessor];  
}


- (void) drawWithGameTime:(GameTime *)gameTime {
    
    
    

    
    // changes background for highscore
	[spriteBatch beginWithSortMode:SpriteSortModeDeffered
						BlendState:nil 
					  SamplerState:[SamplerState pointClamp]
				 DepthStencilState:nil 
				   RasterizerState:nil
                            Effect:nil
                   TransformMatrix:camera
     ];
	
    
    
    
    // RENDER GUI ELEMENTS
	for (id item in scene) {
		Label *label = [item isKindOfClass:[Label class]] ? item : nil;
		Image *image = [item isKindOfClass:[Image class]] ? item : nil;
		Button *button = [item isKindOfClass:[Button class]] ? item : nil;
        
        
		if (label) {
			[spriteBatch drawStringWithSpriteFont:label.font 
                                             text:label.text 
                                               to:label.position 
                                    tintWithColor:label.color
										 rotation:label.rotation 
                                           origin:label.origin 
                                            scale:label.scale 
                                          effects:SpriteEffectsNone 
                                       layerDepth:label.layerDepth
             ];
            
		}
		
        
		if (image) {
			[spriteBatch draw:image.texture 
                           to:image.position 
                fromRectangle:image.sourceRectangle 
                tintWithColor:image.color
					 rotation:image.rotation 
                       origin:image.origin 
                        scale:image.scale 
                      effects:SpriteEffectsNone 
                   layerDepth:image.layerDepth
             ];
		}
        

        if (button){
            
            //btn background
             [spriteBatch draw:button.backgroundImage.texture
                           to:button.backgroundImage.position 
                fromRectangle:button.backgroundImage.sourceRectangle 
                tintWithColor:button.backgroundImage.color
					 rotation:button.backgroundImage.rotation 
                       origin:button.backgroundImage.origin 
                        scale:button.backgroundImage.scale 
                      effects:SpriteEffectsNone 
                   layerDepth:button.backgroundImage.layerDepth];
            
            //btn text
            [spriteBatch drawStringWithSpriteFont:button.label.font 
                                             text:button.label.text 
                                               to:button.label.position 
                                    tintWithColor:button.label.color
										 rotation:button.label.rotation 
                                           origin:button.label.origin 
                                            scale:button.label.scale 
                                          effects:SpriteEffectsNone 
                                       layerDepth:button.label.layerDepth];
            
        }
    }
	
	[spriteBatch end];
    

}



@end
