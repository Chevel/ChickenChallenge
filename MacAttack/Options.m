//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "Options.h"
#import "Namespace.XniGame.h"
#import "Retronator.Xni.Framework.h"

@implementation Options



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
    
    
    
    
    // MUSIC TXT
    scale = 0.7;
    scaleFont = 0.8;
    music = [[Label alloc]
                  initWithFont:screenFontBig
                  text:@"MUSIC:"
                  position:[Vector2 vectorWithX:(screenWidth/2)+10
                                              y:420]
                  depth:0
                  ];
	music.horizontalAlign = HorizontalAlignCenter;
    [music setScaleUniform:scaleFont];
	[scene addItem:music];
    
    // MUSIC BUTTON
    musicSelect = [[Button alloc]
                   initWithInputArea:[Rectangle rectangleWithX:(screenWidth/2)-50
                                                             y:440 
                                                         width:100
                                                        height:50]
                   font: screenFontBig
                   text: igra.mp.state==MediaStateStopped ? @"OFF" : @"ON"];

    [musicSelect.label setScaleUniform:scale];
    [musicSelect setLabelColor:[Color white]];
    [musicSelect setCamera:self.renderer.camera];
    [scene addItem:musicSelect];
    
    
    
    // SFX TXT
    sfx = [[Label alloc]
             initWithFont:screenFontBig
             text:@"SOUND:"
             position:[Vector2 vectorWithX:(screenWidth/2)+10
                                         y:600]
             depth:0
             ];
	sfx.horizontalAlign = HorizontalAlignCenter;
    [sfx setScaleUniform:scaleFont];
	[scene addItem:sfx];
    
    // SFX BUTTON
    sfxSelect = [[Button alloc]
                   initWithInputArea:[Rectangle rectangleWithX:(screenWidth/2)-50
                                                             y:620
                                                         width:100
                                                        height:50]
                   font: screenFontBig
                   text: igra.sfx ? @"ON" : @"OFF"];
    
    [sfxSelect.label setScaleUniform:scale];
    [sfxSelect setLabelColor:[Color white]];
    [sfxSelect setCamera:self.renderer.camera];
    [scene addItem:sfxSelect];
    
	
    
}



- (void) updateWithGameTime:(GameTime *)gameTime {
	[super updateWithGameTime:gameTime];
	

    // BACK SELECT
	if (back.wasReleased) {
        [igra popState];
	}
    
    
    // SFX SELECT
    if(sfxSelect.wasReleased){
        if([sfxSelect.label.text isEqualToString:@"ON"]){
            [sfxSelect setLabelText:@"OFF"];
            [igra sfxSelect:false];
        }
        else{
            [sfxSelect setLabelText:@"ON"];
            [igra sfxSelect:true];
            [SoundEngine play:0 withVolume:1];
        }

    }
    
    // MUSIC SELECT
    if(musicSelect.wasReleased){
        if([musicSelect.label.text isEqualToString:@"ON"]){
            [musicSelect setLabelText:@"OFF"];
            [igra musicSelect:false];
        }
        else{
            [musicSelect setLabelText:@"ON"];
            [igra musicSelect:true];
        }

    }
}






- (void) deactivate {
    [super deactivate];
    
}



@end
