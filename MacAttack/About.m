//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "About.h"
#import "Namespace.XniGame.h"
#import "Retronator.Xni.Framework.h" 

@implementation About



- (void) initialize {
    
    [super initialize];
    
    float scale = 1.0;      // BUTTON IMAGE
    float scaleFont = 0.5;  // LABEL TXT
    
    
    //
    // WARNING
    //
    // layer depth has no role,
    // the depth is determined by the order of items added to scene
    
    
    // BACKGROUND IMAGE
	Texture2D *backgroundTexture = [self.game.content load:@"image-title"];
	background = [[Image alloc]
                  initWithTexture:backgroundTexture
                  position:[Vector2 vectorWithX:0 y:0]
                  depth:0.9
                  ];
	[background setScaleUniform: 1.0];
	[scene addItem:background];
    
    
    // TITLE LABEL
	Texture2D *title = [self.game.content load:@"TITLE"];
	titleTXT = [[Image alloc] initWithTexture:title
                                     position: [Vector2 vectorWithX:20 y:60]
                ];
	[scene addItem:titleTXT];
    
    
    // BACK BUTTON
    Texture2D *backButton = [self.game.content load:@"ButtonBackground"];  
	back = [[Button alloc]
            initWithInputArea:[Rectangle rectangleWithX:50
                                                      y:screenHeight-200
                                                  width:backButton.width*scale
                                                 height:backButton.height*scale]
            background:backButton
            font:buttonFont
            text:@"\nBACK"];
	[back.backgroundImage setScaleUniform:scale];
    [back.label setScaleUniform:scaleFont];
    
    back.label.verticalAlign = VerticalAlignMiddle;
    
    [back setCamera:self.renderer.camera];
    [scene addItem:back];
    
    
    
    
    // TXT 1
    scale = 0.7;
    scaleFont = 0.34;
    txt1 = [[Label alloc]
             initWithFont:screenFontBig
             text:@"gameteam presents:\n\n\n\n\n\n\n\n\n\nCHICKEN CHALLENGE\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nFeaturing: MATEJ KOKOSINEK\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nDone with XNI framework:                   \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nVisit us on the web:                       \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nDone within TINR course taught by Bojan Klemenc\n\n\n\n\n\n\n\n\n\n\n & Peter Peer\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nComputer Vision Lab\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nFaculty of Computer and Information Science\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nUniversity of Ljubljana\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nSlovenia\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n2014"
             position:[Vector2 vectorWithX:screenWidth/2
                                         y:220]
             depth:0
             ];
	txt1.horizontalAlign = HorizontalAlignCenter;
    
    [txt1 setScaleUniform:scaleFont];
	[scene addItem:txt1];

    
    scale = 0.5;
    Texture2D *link1 = [self.game.content load:@"link1"];  
	linkBtn1 = [[Button alloc]
            initWithInputArea:[Rectangle rectangleWithX:screenWidth/2 + 0
                                                      y:screenHeight/2 - 200
                                                  width:link1.width*scale
                                                 height:link1.height*scale]
            background:link1
            font:buttonFont
            text:@""];
	[linkBtn1.backgroundImage setScaleUniform:scale];
    [linkBtn1 setCamera:self.renderer.camera];
    [scene addItem:linkBtn1];
    
    
    
    Texture2D *link2 = [self.game.content load:@"link2"];  
	linkBtn2 = [[Button alloc]
                initWithInputArea:[Rectangle rectangleWithX:screenWidth/2 - 50
                                                          y:screenHeight/2 - 150
                                                      width:link1.width*scale
                                                     height:link1.height*scale]
                background:link2
                font:buttonFont
                text:@""];
	[linkBtn2.backgroundImage setScaleUniform:scale];
    [linkBtn2 setCamera:self.renderer.camera];
    [scene addItem:linkBtn2];
    
}


- (void) updateWithGameTime:(GameTime *)gameTime {
	[super updateWithGameTime:gameTime];
	
    
    // BACK SELECT
	if (back.wasReleased)
    {
        [igra popState];
	}
    // XNI.RETRONATOR
    else if(linkBtn1.wasReleased)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://xni.retronator.com"]];
    }
    // GAMETEAM.FRI
    else if(linkBtn2.wasReleased)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://gameteam.fri.uni-lj.si"]];
    }
    
  
}






- (void) deactivate {
    [super deactivate];
    
}



@end
