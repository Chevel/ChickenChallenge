//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "Menu.h"

#import "Namespace.XniGame.classes.h"

@interface Options : Menu {
	
    Image *background;
	
	Button *back;
    
    Image *titleTXT;
    
    
    // DIFFICULTY SELECT
    Label *difficulty;
    Button *sunnySideUp;
    Button *featherFriendly;
    Button *hardBoiled;
    
    
    // MUSIC
    Label *music;
    Button *musicSelect;
    
    
    // SFX
    Label *sfx;
    Button *sfxSelect;
    
}



@end
