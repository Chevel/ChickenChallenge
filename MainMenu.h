//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "Menu.h"

#import "DeviceNFO.h"

@interface MainMenu : Menu
{
	Image *background, *titleTXT, *easterTxt1, *easterTxt2;
	
	Label *warningLabel, *warning2;
	
	Button *singleplayer, *highscore, *options, *freeplayButton, *about, *continueButton;
    
    Texture2D *buttonPlay, *buttonBackground, *buttonAbout, *buttonBreak1, *buttonBreak2;
    
    GameState *newState;
    
    BOOL added;
    
}


@property BOOL added;

@property (nonatomic, readonly) Matrix *camera;

@property (nonatomic,retain) Button *singleplayer;

- (void) resetPlayBtn;
- (void) unlockFreeplay;
- (void) setContinueButton;

@end
