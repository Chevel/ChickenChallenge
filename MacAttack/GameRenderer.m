//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "Namespace.XniGame.h"




//
// scene is recieved by level
//
@implementation GameRenderer



- (id) initWithGame:(Game *)theGame level:(Level *)theLevel{
    self = [super initWithGame:theGame];
    
    if (self != nil){
        
        
        igra = (Igra *)theGame; 
        level = theLevel;
        content = [[ContentManager alloc] initWithServiceProvider:theGame.services];
        
        // ANIMATIONS STORAGE
        powerUps = [[PowerUpContent alloc] init];
        animations = [[AnimationContent alloc] init];
        
        acrossScreen = -256;
        
        startTime = 0;
        
        msg1 = true;
        msg2 = true;
        msg3 = true;

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

- (void) initialize {
    
    // INIT SPRITE BATCHES
    spriteBatch = [[SpriteBatch alloc] initWithGraphicsDevice:self.graphicsDevice];
    
    
    centre = [Vector2 vectorWithX:self.graphicsDevice.viewport.width/2
                                y:self.graphicsDevice.viewport.height/2
              ];
    
    // draw background
    drawRect = [Vector2 vectorWithX:120 y:igra.backgroundProgress];  // TESTING PURPOSE VALUE = 3150
    
    // HELP
    deathAnimationStart = YES;
    
    imagePoz = 1024;
    
    [super initialize];
}


@synthesize camera, acrossScreen, powerUps, animations;
@synthesize deathAnimationStart;
@synthesize imagePoz;

- (void) reUpdateProgress:(int)value {
    [drawRect setY:value];
}

- (void) loadContent{
    
    //
    // LOAD ENEMIES
    //
    // LOAD AIRPLANE TEXTURE
    airplaneSprite = [[Sprite alloc] init];
    //NSString *airAss = @"Airplane";
    airplaneSprite.texture = [content load:@"Airplane"];
    airplaneSprite.origin = [Vector2 vectorWithX:128 y:128 ];
    airplaneSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:256 height:256];
    
    // LOAD CHICKEN TEXTURE
    chickenSprite = [[Sprite alloc] init];
    //NSString *chickenAss = @"chicken";
    chickenSprite.texture = [content load:@"chicken"];
    chickenSprite.origin = [Vector2 vectorWithX:128 y:128 ];
    chickenSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:256 height:256];
    
    // LOAD UNICORN TEXTURE
    unicornSprite = [[Sprite alloc] init];
    //NSString *unicornAss = @"unicorn";
    unicornSprite.texture = [content load:@"unicorn"];
    unicornSprite.origin = [Vector2 vectorWithX:128 y:128 ];
    unicornSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:256 height:256];

    // LOAD ALIEN TEXTURE
    alienSprite = [[Sprite alloc] init];
    //NSString *alienAss = @"ufo";
    alienSprite.texture = [content load:@"ufo"];
    alienSprite.origin = [Vector2 vectorWithX:128 y:128 ];
    alienSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:256 height:256];

    
    // LOAD EGG BREAKED
    // NORMAL
    eggCrackedSprite = [[Sprite alloc] init];
    eggCrackedSprite.texture = [content load:@"break"];
    eggCrackedSprite.origin = [Vector2 vectorWithX:128 y:128 ];
    eggCrackedSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:256 height:256];
    
    // EASTER
    eggCrackedEasterSprite = [[Sprite alloc] init];
    eggCrackedEasterSprite.texture = [content load:@"breakEaster"];
    eggCrackedEasterSprite.origin = [Vector2 vectorWithX:128 y:128 ];
    eggCrackedEasterSprite.sourceRectangle = [[Rectangle alloc] initWithX:0 y:0 width:256 height:256];
    
    
    
    //
    // LOAD BACKGROUND
    //
    background = [content load:@"background"]; 
    
    image1 = [content load:@"image1"];
    
    
    
    //
    // LOAD POWER UP ANIMATIONS
    //
    Texture2D *goldPowerUp = [content load:@"BoxPowerUp_gold"];
    Texture2D *slowPowerUp = [content load:@"BoxPowerUp_slow"];
    Texture2D *deathPowerUp = [content load:@"BoxPowerUp_dead"];
    
    [powerUps addPowerUp:goldPowerUp type:PowerUpTypeGoldenEgg];
    [powerUps addPowerUp:slowPowerUp type:PowerUpTypeSlow];
    [powerUps addPowerUp:deathPowerUp type:PowerUpTypeDeath];
    
    
    //
    // LOAD ANIMATIONS
    //
    Texture2D *flappingWings = [content load:@"SpriteBatchWings2"];
    Texture2D *easterEgg = [content load:@"SpriteBatchWingsEaster"];
    Texture2D *animatedStage1 = [content load:@"Stage1"];
    Texture2D *animatedStage2 = [content load:@"Stage2"];
    Texture2D *forceFieldEgg = [content load:@"forceFieldEgg"];
    Texture2D *forceFieldEasterEgg = [content load:@"forceFieldEasterEgg"];
        // intro
    Texture2D *introWings = [content load:@"introAnimation"];
        // boom animations
    Texture2D *boomChicken = [content load:@"Boom_chicken"];
    Texture2D *boomUnicorn = [content load:@"Boom_unicorn"];
    Texture2D *boomAirplane = [content load:@"Boom_airplane"];
    Texture2D *boomAlien = [content load:@"Boom_alien"];

    [animations addAnimation:flappingWings type:AnimationFlappingWings];
    [animations addAnimation:easterEgg type:AnimationEasterEgg];
    [animations addAnimation:animatedStage1 type:AnimationStage1];
    [animations addAnimation:animatedStage2 type:AnimationStage2];
    [animations addAnimation:forceFieldEgg type:AnimationForceField];
    [animations addAnimation:forceFieldEasterEgg type:AnimationForceFieldEaster];
        // intro
    [animations addAnimation:introWings type:IntroAnimation];
        // boom animations
    [animations addAnimation:boomChicken type:BoomChicken];
    [animations addAnimation:boomUnicorn type:BoomUnicorn];
    [animations addAnimation:boomAirplane type:BoomAirplane];
    [animations addAnimation:boomAlien type:BoomAlien];

    
    //
    // INTRO MESSAGE
	//
    FontTextureProcessor *fontProcessor = [[FontTextureProcessor alloc] init];
	retrotype = [self.game.content load:@"Retrotype_BIG" processor:fontProcessor];
	retrotype.lineSpacing = 7;
    
    float scale = 0.7;
    
    instructionsL1 = [[Label alloc]
             initWithFont:retrotype
             text:@" TAP OR SWIPE THE CHICKENS"
             position:[Vector2 vectorWithX:(screenWidth/2)
                                         y:(screenHeight/2) - 140]
             depth:0.1
             ];
	instructionsL1.horizontalAlign = HorizontalAlignCenter;
    [instructionsL1 setScaleUniform:scale];
    [instructionsL1 setColor:[Color white]];
    
    
    instructionsL2 = [[Label alloc]
                      initWithFont:retrotype
                      text:@"PROTECT YOUR EGG !"
                      position:[Vector2 vectorWithX:(screenWidth/2)
                                                  y:(screenHeight/2) - 70]
                      depth:0.1
                      ];
	instructionsL2.horizontalAlign = HorizontalAlignCenter;
    [instructionsL2 setScaleUniform:scale];
    [instructionsL2 setColor:[Color white]];
    
    
}

- (void) drawWithGameTime:(GameTime *)gameTime
{
    
    [spriteBatch beginWithSortMode:SpriteSortModeBackToFront
                        BlendState:nil
                      SamplerState:nil
                 DepthStencilState:nil
                   RasterizerState:nil
                            Effect:nil
                   TransformMatrix:camera];
    
    if([[GameKitHelper sharedGameKitHelper:igra] gamePaused])
    {
        
    }
    //
    // INTRO RENDER
    //
    else if(igra.intro)
    {
        // initialize time count
        if(igra.introStart){
            introStart = [[NSDate date] timeIntervalSince1970];
            [igra setIntroStart:false];
        }
        NSTimeInterval _tmpTime = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval _introDuration = fabsf(introStart - _tmpTime);
        AnimatedSprite *animation = [animations getAnimation:IntroAnimation];

        
        
        eggAnimation = [[animations getAnimation:IntroAnimation] spriteAtTime:_introDuration];
        
        // INTRO EGG ANIMATION HAS PLAYED OUT
        //
        if([animation spriteAtTime:_introDuration] == nil){
            eggAnimation = igra.easterEgg ? [[animations getAnimation:AnimationEasterEgg] spriteAtTime:gameTime.totalGameTime] : [[animations getAnimation:AnimationFlappingWings] spriteAtTime:gameTime.totalGameTime];

            // EGG OUT OF SCREEN, QUIT INTRO
            if (igra.eggY < -128){
                [igra setEggY:screenHeight/2]; // set animation on center screen
                [igra setIntro:false]; // quit
                [igra setBackgroundProgress:3150]; // 3150 - a little up, so that grass isnt visible <- TEST
            }
            else{
                // INTRO ANIMATION IS OVER and EGG ISNT OUT OF SCREEN
                [igra setEggY: igra.eggY-6 ]; // animate egg flying up
            }
        }
        
        // EGG ANIMATION
        //
        [spriteBatch draw:eggAnimation.texture
                       to:[Vector2 vectorWithX:screenWidth/2
                                             y:igra.eggY
                           ]
            fromRectangle:eggAnimation.sourceRectangle
            tintWithColor:[Color white]
                 rotation:0
                   origin:eggAnimation.origin
             scaleUniform:0.7 
                  effects:SpriteEffectsNone
               layerDepth:0.7
         ];
        
        
        // BACKGROUND ANIMATION
        //
        [spriteBatch draw:background
                       to:[Vector2 vectorWithX:0
                                             y:0
                           ]
            fromRectangle:nil
            tintWithColor:[Color white]
                 rotation:0
                   origin:drawRect
             scaleUniform:2  // 2
                  effects:SpriteEffectsNone
               layerDepth:0.9 // 0=at the top, 0.9
         ];
        
        
        // INTRO MESSAGE
        //
        [spriteBatch drawStringWithSpriteFont:instructionsL1.font
                                         text:instructionsL1.text
                                           to:instructionsL1.position
                                tintWithColor:instructionsL1.color
                                     rotation:instructionsL1.rotation
                                       origin:instructionsL1.origin
                                        scale:instructionsL1.scale
                                      effects:SpriteEffectsNone
                                   layerDepth:instructionsL1.layerDepth
         ];
        [spriteBatch drawStringWithSpriteFont:instructionsL2.font
                                         text:instructionsL2.text
                                           to:instructionsL2.position
                                tintWithColor:instructionsL2.color
                                     rotation:instructionsL2.rotation
                                       origin:instructionsL2.origin
                                        scale:instructionsL2.scale
                                      effects:SpriteEffectsNone
                                   layerDepth:instructionsL2.layerDepth
         ];
    }

    //
    // ACTIVE GAMEPLAY RENDER
    //
    else
    {
        if(igra.stop){
            gameTime = 0;
        }
        
        currentTime = [[NSDate date] timeIntervalSince1970];
        int difference = abs(startTime-currentTime);
        
        //NSLog(@" DIFFERENCE = %d", difference);
        
        
        //
        // STAGE UP ANIMATION
        //
        // RAINBOW STAGE - MSG
        if(igra.stage == 1){
            if(difference < 5){
                
                Sprite *stageSprite = [[animations getAnimation:AnimationStage1] spriteAtTime:gameTime.totalGameTime];
                
                [spriteBatch draw:stageSprite.texture
                               to:[Vector2 vectorWithX:screenWidth/2
                                                     y:screenHeight/2]
                    fromRectangle:stageSprite.sourceRectangle
                    tintWithColor:[Color white]
                         rotation:0
                           origin:stageSprite.origin
                     scaleUniform:1
                          effects:SpriteEffectsNone
                       layerDepth:0
                 ];
            }
            if(msg1){
                startTime = [[NSDate date] timeIntervalSince1970];
                msg1 = false;
            }
        }
        //
        // AEROPLANE STAGE - MSG
        if(igra.stage == 2){
            if(difference < 10){
                
                Sprite *stageSprite = [[animations getAnimation:AnimationStage2] spriteAtTime:gameTime.totalGameTime];
                
                [spriteBatch draw:stageSprite.texture
                               to:[Vector2 vectorWithX:acrossScreen
                                                     y:screenHeight/2]
                    fromRectangle:stageSprite.sourceRectangle
                    tintWithColor:[Color white]
                         rotation:0
                           origin:stageSprite.origin
                     scaleUniform:1
                          effects:SpriteEffectsNone
                       layerDepth:0
                 ];
                acrossScreen += 2;
            }
            if(msg2){
                startTime = [[NSDate date] timeIntervalSince1970];
                msg2 = false;
            }
        }
        
        //
        // ACTIVE GAME RENDER
        //
        if( igra.active )
        {
            
            // EGG FLAPPING ANIMATION
            eggAnimation = igra.easterEgg ? [[animations getAnimation:AnimationEasterEgg] spriteAtTime:gameTime.totalGameTime] : [[animations getAnimation:AnimationFlappingWings] spriteAtTime:gameTime.totalGameTime];
            
            //
            // FREEPLAY MODE
            //
            if(igra.freeplayActive)
            {
                // ENDLESS BACKGROUND ANIMATION
                
                [drawRect setY: imagePoz];
                [spriteBatch draw:image1
                               to:[Vector2 vectorWithX:120
                                                     y:-(0)
                                   ] 
                    fromRectangle:nil
                    tintWithColor:[Color white]
                         rotation:0
                           origin:drawRect
                     scaleUniform:1  // 2
                          effects:SpriteEffectsNone
                       layerDepth:0.9 // 0=at the top, 0.9
                 ];
                
                // animate backgorund
                if(!igra.stop){
                    imagePoz -= 1.5;
                }
                // reset background
                
                if(imagePoz < 1 ){
                    imagePoz = 1024;
                }
                
            }
            //
            // STORY MODE
            //
            else
            {
                // FINITE BACKGROUND ANIMATION
                int t = gameTime.totalGameTime;
                if( (t % 1) == 0 && !igra.stop){
                    [igra updateBackgroundProgress];
                }
                 
                // BACKGROUND ANIMATION
                [drawRect setY: igra.backgroundProgress];
                [spriteBatch draw:background
                               to:[Vector2 vectorWithX:0
                                                     y:-500
                                   ] //x:0 y:-500
                    fromRectangle:nil
                    tintWithColor:[Color white]
                         rotation:0
                           origin:drawRect
                     scaleUniform:2  // 2
                          effects:SpriteEffectsNone
                       layerDepth:0.9 // 0=najbolj na vrhu, 0.9
                 ];
            }
        
            
            
            
            
            

            //
            // OBJECTS IN THE SCENE RENDER
            //
            for (id<NSObject> item in level.scene) {
                
                // CONFORNS TO PROTOCOL
                id<IKillable, IMovable> itemWithLife = nil;
                id<ILifetime, IKillable, IMovable, IPowerUp> itemPowerUp = nil;
                
                // RENDER POWERUP
                if([item conformsToProtocol:@protocol(ILifetime)] &&
                   [item conformsToProtocol:@protocol(IKillable)] &&
                   [item conformsToProtocol:@protocol(IMovable)] &&
                   [item conformsToProtocol:@protocol(IPowerUp)]
                   )
                {
                    itemPowerUp = (id<ILifetime, IKillable, IMovable, IPowerUp>)item;
                }
                // RENDER ENEMY
                else if ([item conformsToProtocol:@protocol(IKillable)] &&
                    [item conformsToProtocol:@protocol(IMovable)] )
                {
                    itemWithLife = (id<IKillable, IMovable>)item;
                }

                
                
                // DETERMINE THE SPRITE TO RENDER, BASED ON THE ITEM
                Sprite *sprite = nil;
                
                //
                // ENEMY SPRITE
                //
                if ([item isKindOfClass:[Rat class]]) {
                    sprite = chickenSprite;
                }
                else if([item isKindOfClass:[Unicorn class]]){
                    sprite = unicornSprite;
                }
                else if([item isKindOfClass:[Airplane class]]){
                    sprite = airplaneSprite;
                }
                else if([item isKindOfClass:[Alien class]]){
                    sprite = alienSprite;
                }
                
                //
                // POWER-UP SPRITE
                //
                else if ([item isKindOfClass:[PowerUp class]]){
                    
                    if( ((PowerUp*)item).getType == PowerUpTypeGoldenEgg ){
                         sprite = [[powerUps getPowerUp:PowerUpTypeGoldenEgg] spriteAtTime:gameTime.totalGameTime];
                    }
                    if( ((PowerUp*)item).getType == PowerUpTypeSlow ){
                         sprite = [[powerUps getPowerUp:PowerUpTypeSlow] spriteAtTime:gameTime.totalGameTime];
                    }
                   if( ((PowerUp*)item).getType == PowerUpTypeDeath ){
                         sprite = [[powerUps getPowerUp:PowerUpTypeDeath] spriteAtTime:gameTime.totalGameTime];
                    }
                }
                
                
                //
                // ITEM IS POWERUP
                //
                if(itemPowerUp && sprite)
                {
                    
                    // GOD POWERUP ANIMATION
                    if( [itemPowerUp getType] == PowerUpTypeGoldenEgg  && [itemPowerUp isActivated] ){
                        
                        // FORCE FIELD - BLINKING VFX
                        float perc = ((Lifetime*)[itemPowerUp lifetime]).percentage;
                        int val = (int)(perc*100);
                        if(val > 70 && val%5==0 )
                        {
                            eggAnimation = igra.easterEgg ? [[animations getAnimation:AnimationEasterEgg] spriteAtTime:gameTime.totalGameTime] : [[animations getAnimation:AnimationFlappingWings] spriteAtTime:gameTime.totalGameTime];
                        }
                        else{
                            eggAnimation = igra.easterEgg ? [[animations getAnimation:AnimationForceFieldEaster] spriteAtTime:gameTime.totalGameTime] : [[animations getAnimation:AnimationForceField] spriteAtTime:gameTime.totalGameTime];
                        }
                    }
                    
                    
                    // DEATH POWERUP ANIMATION - BLINKING VFX
                    if( [itemPowerUp getType] == PowerUpTypeDeath  && [itemPowerUp isActivated] )
                    {
                        
                        if(deathAnimationStart)
                        {
                            startDeath = [[NSDate date] timeIntervalSince1970];
                            deathAnimationStart = NO;
                        }
                        
                        currentTime = [[NSDate date] timeIntervalSince1970];
                        float _introDuration = fabsf(startDeath - currentTime);
                        
                        int val = (int) (_introDuration*10);
                        
                        //NSLog(@" TIME = %f", _introDuration);
                        
                        if( val % 6 == 0 ) // every 2 seconds on/off
                        {
                            sprite = [[powerUps getPowerUp:PowerUpTypeDeath] spriteAtTime:0];
                            
                            // DRAW DEATH POWERUP
                            [spriteBatch draw:sprite.texture
                                           to:itemPowerUp.position
                                fromRectangle:sprite.sourceRectangle
                                tintWithColor:[Color white]
                                     rotation:0
                                       origin:sprite.origin
                                 scaleUniform:itemPowerUp.size
                                      effects:SpriteEffectsNone
                                   layerDepth:0.7]; 
                        }
                        

                        
                    }
                    
                    // FREE FALLING ANIMATION
                    if( ![itemPowerUp isActivated] && [itemPowerUp visible] ){
                        [spriteBatch draw:sprite.texture
                                       to:itemPowerUp.position
                            fromRectangle:sprite.sourceRectangle
                            tintWithColor:[Color white]
                                 rotation:0
                                   origin:sprite.origin
                             scaleUniform:itemPowerUp.size
                                  effects:SpriteEffectsNone
                               layerDepth:0.7]; 
                    }
                }
                
                
                
                
                
                //
                // ITEM IS ENEMY ALIVE
                //
                if(itemWithLife && sprite && [itemWithLife isDead]==false) {
                    [spriteBatch draw:sprite.texture
                                   to: itemWithLife.position
                        fromRectangle:sprite.sourceRectangle
                        tintWithColor:[Color white]
                             rotation:itemWithLife.rotation
                               origin:sprite.origin
                         scaleUniform:itemWithLife.size
                              effects:SpriteEffectsNone
                           layerDepth:0.5];
                }
                
                
                
                
                //
                //ITEM IS ENEMY DEAD
                //
                if(itemWithLife && sprite && [itemWithLife isZombie]==true) {
                    Vector2 *tmp = itemWithLife.position;
                    
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
                    
                    _enemyTemp = [item isKindOfClass:[Enemy class]] ? (Enemy*)item : nil;
                    
                    sprite = [[animations getAnimation:type] spriteAtTime: _enemyTemp.deadTime];

                    
                    
                    [spriteBatch draw:sprite.texture
                                   to: tmp
                        fromRectangle:sprite.sourceRectangle
                        tintWithColor:[Color white]
                             rotation: 0 
                               origin:sprite.origin
                         scaleUniform:itemWithLife.size
                              effects:SpriteEffectsNone
                           layerDepth:0.5];
                   
                }
            }// END FOR ITEMS IN SCENE
            

            
            //
            // OUTRO
            //
            if(igra.outro){
                 currentTime = [[NSDate date] timeIntervalSince1970];
                 
                 if(currentTime-startTime > 0.05){
                     startTime = currentTime;
                     [igra setEggY: igra.eggY-6 ]; 
                 }
             }
        

            // EGG AREA - TESTING PURPOSE
            /*
            [spriteBatch draw:airplaneSprite.texture
                           to:[Vector2 vectorWithX:screenWidth/2
                                                 y:screenHeight/2
                               ]
                fromRectangle:airplaneSprite.sourceRectangle
                tintWithColor:[Color white]
                     rotation:0
                       origin:airplaneSprite.origin
                 scaleUniform:1
                      effects:SpriteEffectsNone
                   layerDepth:0.8
             ];
             */
            
            
            //
            // USE EGG BREAKED - GAME OVER
            if(igra.stop)
            {
                
                if(igra.easterEgg){
                    eggAnimation = eggCrackedEasterSprite;
                    eggAnimation.sourceRectangle = eggCrackedEasterSprite.sourceRectangle;
                }
                else{
                    eggAnimation = eggCrackedSprite;
                    eggAnimation.sourceRectangle = eggCrackedSprite.sourceRectangle;
                }
                
            }
            
            
            
            //
            // DRAW EGG
            [spriteBatch draw:eggAnimation.texture
                            to:[Vector2 vectorWithX:screenWidth/2
                                                  y:igra.eggY
                                ]
                 fromRectangle:eggAnimation.sourceRectangle
                 tintWithColor:[Color white]
                      rotation:0
                        origin:eggAnimation.origin
                  scaleUniform:0.7 // TEST 0.6
                       effects:SpriteEffectsNone
                    layerDepth:0.7
              ];
         } // END GAME RENDERER
    }// END IF ACTIVE
    
    [spriteBatch end];
}







//
//RELEASE
//
- (void) unloadContent{
    [content unload];
}

@end
