//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Namespace.XniGame.classes.h"
#import "Retronator.Xni.Framework.h"
#import "GameState.h"

@interface Gameplay : GameState{
	
    Level *level;
    
    BOOL gameRunning;
	

    
    GameHud *hud;
	GuiRenderer *hudRenderer;
	GameRenderer *renderer;	
    
    int timeUntilNextPowerUp;
    
    NSCalendar *cal;
    NSDate *now;
    NSDateComponents *components;
    
    int startTime;
    int nowTime;
    
    BOOL stage1,stage2,stage3;
    BOOL stage1active,stage2active,stage3active;
    
    int stage1_start, stage1_end;
    int stage2_start, stage2_end;
    int stage3_start, stage3_end;
    
    int criticalDistance;
    
    //POWERUP
    BOOL immortal;
    
    CGRect eggArea;
    
}

@property BOOL stage1active, stage2active, stage3active;

@property (readonly)PowerUp* rePowerUp;
@property (readonly)PowerUp* powerTemp;

- (id) initSinglePlayerWithGame:(Game*)theGame levelClass:(Class)levelClass;

- (void) setDisplayMessage:(NSString*)theMessage;


@end
