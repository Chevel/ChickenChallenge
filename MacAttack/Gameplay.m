//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import "Namespace.XniGame.h"





/*
GAMEPLAY SHOULD HAVE
 -> LEVEL
 -> GAME RENDERER //scene objects,enemies,powerups...
*/
@implementation Gameplay


- (id) initSinglePlayerWithGame:(Game *)theGame
                     levelClass:(Class)levelClass
{
    
	self = [super initWithGame:theGame];
    
	if (self != nil) {
        level = [[levelClass alloc]
                 initWithGame:self.game
                 ];
        
        stage1 = false;
        stage2 = false;
        stage3 = false;

        stage1active = false;
        stage2active = false;
        stage3active = false;
        
        
        
        // REAL
        
        stage1_start = 2351;
        stage1_end =  2239;
        
        stage2_start = 1400;
        stage2_end =  1398;
        
        stage3_start = 351;
        stage3_end =  349;
    
        
        
        // TESTING - QUICK
        /*
        stage1_start = 3101;
        stage1_end =  3099;
        
        stage2_start = 2501;
        stage2_end =  2499;
        
        stage3_start = 2301;
        stage3_end =  2299;
        */
        
        
        
        [self finishInit];
	}
	return self;
}

@synthesize powerTemp, rePowerUp, stage1active, stage2active, stage3active; 

- (void) finishInit{
    
    
    
    // GAME RENDER
    renderer = [[GameRenderer alloc] initWithGame:self.game level:level];
    
    // HUD
    hud = [[GameHud alloc] initWithGame:self.game];
    hudRenderer = [[GuiRenderer alloc] initWithGame:self.game
                                              scene:hud.scene];
    
    // TOUCHING POSITION FIX
    [level setCamerasOnObjects:renderer.camera];
    
    // SET GAME DIFFICULTY
    [level setDifficulty:igra.difficulty];
    
    // GAME RULES
    eggArea = CGRectMake( (screenWidth/2)-64, (screenHeight/2)-64, 64, 64);
    criticalDistance = 90; //hardcoded
    immortal = NO;
    
    // HELP
    startTime = 0;
    nowTime = 0;
    
    // FINALIZE OBJECT SETUP
    [self objectsSetup];
    
    // DISPLAY THE CORRECT HIGHSCORE
    [igra updateBestScoreDisplay];
    
    
 
    
  }

- (void) objectsSetup{
    
    
    NSMutableArray *toRemove = [NSMutableArray array];
    for(id item in level.scene){
        Enemy* _enemyTemp = [item isKindOfClass:[Enemy class]] ? item : nil;
        PowerUp* _powerTemp = [item isKindOfClass:[PowerUp class]] ? item : nil;
        
        if(_enemyTemp)
        {
            
            // if rat
            
            // if unicorn
            
            // if plane
            
            if( [_enemyTemp isKindOfClass:[Rat class]] )
            {
                int speedModifier = igra.freeplayActive ? 2.0 : 1.0;
                [_enemyTemp setSpeed:igra.difficulty + speedModifier];
            }
            else if( [_enemyTemp isKindOfClass:[Unicorn class]] )
            {
                [_enemyTemp setSpeed:igra.difficulty - 1];
            }
            else if( [_enemyTemp isKindOfClass:[Airplane class]] )
            {
                [_enemyTemp setSpeed:igra.difficulty + 0];
            }
            
            
            
        }
        else if(_powerTemp)
        {
            if(igra.freeplayActive)
            {
                [toRemove addObject:_powerTemp];
            }
            else
            {
                float x = 64 + (random() % ((int)screenWidth)-128);
                float y = (5 + (random() % 150)) * -1;
                
                while( [self ObjectWithinEggArea:x] || [self powerUpCollision] )
                {
                    x = 64 + (random() % ((int)screenWidth)-128);
                    
                    
                    [_powerTemp.position set:[Vector2 vectorWithX:x
                                                               y:y]
                     ];
                    [_powerTemp setHitArea:CGRectMake(x, y, _powerTemp.width, _powerTemp.height)];
                    break;
                }
            }
        }
    }
    
    
    
    for(id item in toRemove){
        [level.scene removeItem:item];
    }
    
    
}


- (void) activate {
    [self.game.components addComponent:renderer];
	[self.game.components addComponent:hud];
	[self.game.components addComponent:hudRenderer];
    [self.game.components addComponent:level];
}

- (void) deactivate {
    [self.game.components removeComponent:renderer];
	[self.game.components removeComponent:hud];
	[self.game.components removeComponent:hudRenderer];
	[self.game.components removeComponent:level];
    
}


- (void) setDisplayMessage:(NSString*)theMessage{
    

}



//
// GAME RULES 
//
- (void) updateWithGameTime:(GameTime *)gameTime{
    
    if( igra.stop || [[GameKitHelper sharedGameKitHelper:igra] gamePaused] ){
    
    }
    else if(igra.intro){

    }
    else{
        
        //
        // GAME PROGRESS - NEXT STAGE
        //
        int tmp = ((int)igra.backgroundProgress);
        
        // STAGE = 1
        if( !stage1active && !stage1 && tmp < stage1_start)
        {
            Level1 *tmpLVL = (Level1 *)level;
            [tmpLVL updateLVL:1];
            [level setCamerasOnObjects: renderer.camera];
            [igra setStage:1];
           // NSLog(@"LVL UP - 1");
            [SoundEngine play:3 withVolume:1];
            
            stage1 = true;
            stage2 = false;
            stage3 = false;
            
            stage1active = true;
        }
        
        // STAGE = 2
        else if( !stage2active && !stage2 && tmp < stage2_start)
        {
            Level1 *tmpLVL = (Level1 *)level;
            [tmpLVL updateLVL:2];
            [level setCamerasOnObjects: renderer.camera];
            [igra setStage:2];
          //  NSLog(@"LVL UP - 2");
            [SoundEngine play:4 withVolume:1];
            
            stage1 = false;
            stage2 = true;
            stage3 = false;
        
            stage2active = true;
        }
        
        // STAGE = 3
        else if( !stage3active && !stage3 && tmp < stage3_start )
        {
            Level1 *tmpLVL = (Level1 *)level;
            [tmpLVL updateLVL:3];
            [level setCamerasOnObjects: renderer.camera];
            [igra setStage:3];
          //  NSLog(@"LVL UP - 3");
            
            stage1 = false;
            stage2 = false;
            stage3 = true;
            
            stage3active = true;
        }
        
        // GAME OVER - WIN - OUTRO
        if((int)igra.backgroundProgress < -180)
        {
            
            [level.scene clear];
            
            [igra setOutro:YES];
            
            
            // egg out of bounds
            if(igra.eggY < -50)
            {
                [igra setOutro:NO]; 
                [igra gameOver];
            }
        }
        
        
        
        
        //
        // APPLY RULES TO OBJECTS IN GAME
        //
        NSMutableArray *toRemove = [NSMutableArray array];
        NSMutableArray *toAdd = [NSMutableArray array];
        for(id item in level.scene)
        {
            Enemy *enemyTemp = [item isKindOfClass:[Enemy class]] ? item : nil;
            powerTemp = [item isKindOfClass:[PowerUp class]] ? item : nil;

            //
            // ENEMY STUFF
            //
            if(enemyTemp){
                
                if(immortal)
                {
                    criticalDistance = 150;
                }
                else
                {
                    criticalDistance = 90;
                }
                
                // GAME OVER - CHECK
                if( [self atCenter:enemyTemp] )
                {
                    if(immortal)
                    {
                        [enemyTemp reincarnation];
                    }
                    else
                    {
                        [igra gameOver]; // <------- GOD MODE ON/OFF
                        
                        //[enemyTemp reincarnation];  // COMMENT WHEN DONE TESTING
                        
                        break;
                    }
                }
                
                
                // ENEMY KILLED
                else if(enemyTemp.dead){
           
                    if(enemyTemp.zombie)
                    {
                        
                        // DONT RESPAWN DEAD ENEMIES IN FOREIGN STAGES
                        if( ((igra.stage==3) && [item isKindOfClass:[Rat class]]) ||
                            ((igra.stage==2 || igra.stage==3) && [item isKindOfClass:[Unicorn class]]) ||
                             (igra.stage==3 && [item isKindOfClass:[Airplane class]])
                           ){
                            [toRemove addObject:enemyTemp];
                        }
                        // ENEMY ZOMBIE IN THE RIGHT STAGE
                        else{
                            int type;
                            if([item isKindOfClass:[Rat class]]){
                                type = BoomChicken;
                            }
                            else if([item isKindOfClass:[Unicorn class]]){
                                type = BoomUnicorn;
                            }
                            else if([item isKindOfClass:[Airplane class]]){
                                type = BoomAirplane;
                            }
                            else if([item isKindOfClass:[Alien class]]){
                                type = BoomAlien;
                            }
                            
                            // DONT RESPAWN, UNTIL THE ANIMATION IS PLAYED OUT
                            AnimatedSprite *animation = [renderer.animations getAnimation:type];
                            NSTimeInterval deathAnimationDuration = animation.duration;
                            
                           // NSLog(@" DEADTIME = %f  |  DURATION = %f", enemyTemp.deadTime,deathAnimationDuration);
                            
                            if( enemyTemp.deadTime > deathAnimationDuration ){
                                [enemyTemp reincarnation];
                                //NSLog(@" REINCARNATION ");
                            }
                        }
                    }
                    else{
                        igra.score += enemyTemp.worth;
                        [enemyTemp setZombie:YES];
                    }
                }

                
                // ENEMY ALIVE and OUT-OF-BOUNDS
                else if(enemyTemp.respawn){
                    
                    // DONT RESPAWN DEAD ENEMIES IN FOREIGN STAGES
                    if( ((igra.stage==2 || igra.stage==3) && [item isKindOfClass:[Rat class]]) ||
                        ((igra.stage==2 || igra.stage==3) && [item isKindOfClass:[Unicorn class]]) ||
                        (igra.stage==3 && [item isKindOfClass:[Airplane class]])
                       ){
                        // if enemy out of its stage, remove it
                        [toRemove addObject:enemyTemp];
                    }
                    else{
                        [enemyTemp reincarnation];
                        //NSLog(@" REINCARNATION ");
                    }
                }
                
                // ENEMY ALIVE
                else{
                    if( !igra.slowed ){
                        [enemyTemp moveCloser];
                    }
                }
                // UPDATE ANYWAY
                [enemyTemp updateWithGameTime:gameTime];
            }
            
            
            //
            // POWERUP STUFF
            //
            if(powerTemp){
                
                // FORCE FIELD
                if( powerTemp.type == PowerUpTypeGoldenEgg )
                {
                    if(powerTemp.isActivated)
                    {
                        immortal = YES;
                    }
                }
                // SLOW
                else if( powerTemp.type == PowerUpTypeSlow )
                {
                    if(powerTemp.isActivated)
                    {
                        [igra setSlowed:YES];
                        
                        if( [self noEnemiesInView ] ){
                            [powerTemp deactivate];
                            [igra setSlowed:NO];
                        }

                    }
                }
                
                // DEAD
                else if( powerTemp.type == PowerUpTypeDeath )
                {
                    if(powerTemp.isActivated)
                    {
                        [igra gameOver];
                    }
                }
                
                
                
                
                // ZOMBIE POWERUP
                if(powerTemp.isDead && !powerTemp.isActivated)
                {
                    //
                    // POWERUP TIMEDOUT
                    if( powerTemp.type==PowerUpTypeSlow && ((SlowedPowerUp*)powerTemp).reset )
                    {
                        [igra setSlowed:NO];
                    }
                    if( powerTemp.type==PowerUpTypeGoldenEgg && ((GoldenEggPowerUp*)powerTemp).reset )
                    {
                            immortal = NO;
                    }
                    
                    
                    // set powerup spawn interval
                    if(startTime == 0){
                        timeUntilNextPowerUp = 0.5; 
                        startTime = gameTime.totalGameTime;
                    }
                    else{
                         nowTime = gameTime.totalGameTime;
                        
                         // TIME HAS ELAPSED SINCE LAST POWERUP - CREATE NEW POWERUP
                         if( (nowTime-startTime) > timeUntilNextPowerUp ){
                         
                             rePowerUp = [PowerUpFactory createRandomPowerUp];
                             [rePowerUp setCamera:renderer.camera];
                             [toAdd addObject:rePowerUp];
                             
                             // remove previous powerup
                             [toRemove addObject:powerTemp];
                             
                             startTime = 0;
                         }
                    }
                }
                // CURRENTLY ACTIVE
                else if (powerTemp.isActivated)
                {
                    //NSLog(@" POWERUP ACTIVATED ");
                    // updates the lifetime of activation as well
                    [powerTemp updateWithGameTime:gameTime];
                                    
                }
                
                else
                {
                    [powerTemp moveCloser];
                    [powerTemp updateWithGameTime:gameTime];
                }
                
            }
        }
        
        if(!igra.gameover)
        {
            // REMOVE ANY OBJECTS THAT WERE KILLED
            for(id item in toRemove){
                [level.scene removeItem:item];
            }
            [toRemove removeAllObjects];
            
            // REINCARNATE ANY KILLED OBJECTS
            for(id item in toAdd){
                [level.scene addItem:item];
            }
            [toAdd removeAllObjects];
        }
        
    } // intro
}



// HELPERS
//
- (BOOL) atCenter: (Enemy*) theEnemy{
    
    
    // distance between enemy and egg
    CGFloat dx = theEnemy.position.x - screenWidth/2;
    CGFloat dy = theEnemy.position.y - screenHeight/2;
    float dist = sqrt(dx*dx + dy*dy );
    
    
    if( [theEnemy isKindOfClass:[Unicorn class]] || [theEnemy isKindOfClass:[Alien class]] || [theEnemy isKindOfClass:[Airplane class]])
    {
        return false; // cannot kill you
    }
    else{
        return (dist < criticalDistance);
    }
    
}

- (BOOL) powerUpCollision{
    
        // POWERUPS MUST NOT INTERLACE
    for(id item in level.scene){
        PowerUp* _power1 = [item isKindOfClass:[PowerUp class]] ? item : nil;
        
        for(id item in level.scene){
            PowerUp* _power2 = [item isKindOfClass:[PowerUp class]] ? item : nil;
            if([_power1 isEqual:_power2]){
                break;
            }
            else{
                /*
                NSLog(@" P1 = %f - %f | %f - %f",_power1.hitArea.origin.x, _power1.hitArea.origin.x+_power1.hitArea.size.width, _power1.hitArea.origin.y, _power1.hitArea.origin.y+_power1.hitArea.size.height);
                NSLog(@" P2 = %f - %f | %f - %f\n\n",_power2.hitArea.origin.x, _power2.hitArea.origin.x+_power2.hitArea.size.width, _power2.hitArea.origin.y, _power2.hitArea.origin.y+_power2.hitArea.size.height);
                */
                
                if( CGRectIntersectsRect(_power1.hitArea, _power2.hitArea) ){
                    return true;
                }
            }
        }
    }
    
    return false;
    
}

- (BOOL) ObjectWithinEggArea:(int) objectXcoordinate{
    
    
    BOOL status = ( objectXcoordinate >= ((screenWidth/2)-128) && objectXcoordinate <= ((screenWidth/2)+128)  );
    
    
    //NSLog(@" ObjectWithinEggArea = %@ ", status?@"YES":@"NO");
    
    
    return status;
    
}

- (BOOL) noEnemiesInView{
    
    for(id item in level.scene)
    {
        Enemy *enemyTemp = [item isKindOfClass:[Enemy class]] ? item : nil;
        
        if(enemyTemp &&
           CGRectContainsPoint(CGRectMake(0, 0, screenWidth, screenHeight), CGPointMake(enemyTemp.position.x, enemyTemp.position.y)) )
        {
            return NO;
        }
        
    }
    return YES;
    
}


@end
