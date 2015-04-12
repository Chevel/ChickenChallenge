//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "MainMenu.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Namespace.XniGame.h"


@implementation MainMenu





- (void) initialize {
	[super initialize];

    
    
    if(!added)
    {
        //good stuff
        screenBound = [[UIScreen mainScreen] bounds];
        screenSize = screenBound.size;  
        screenWidth = screenSize.width;
        screenHeight = screenSize.height;
        
        // BUTTON SCALING
        float scale = 1.0;

        // FONT SCALE
        float fontScale = 0.5;
        

        // BACKGROUND IMAGE
        Texture2D *backgroundTexture = [self.game.content load:@"image-title"];
        background = [[Image alloc] initWithTexture:backgroundTexture
                                           position: [Vector2 vectorWithX:0 y:0]
                      ];
        [background setScaleUniform: 1.0];
        [scene addItem:background];
        
        
        
        // TITLE LABEL
        Texture2D *title = [self.game.content load:@"TITLE"];
        titleTXT = [[Image alloc] initWithTexture:title
                                         position: [Vector2 vectorWithX:20 y:60]
                      ];
        [scene addItem:titleTXT];
        
        
        
        // EPILEPSY LABEL
        fontScale = 0.4;
        warningLabel = [[Label alloc]
                             initWithFont:screenFontBig
                             text:@"EPILEPSY WARNING"
                             position:[Vector2 vectorWithX:screenWidth/2 - 130
                                                         y:screenHeight-30]
                             depth:0.1
                            ];
        [warningLabel setScaleUniform:fontScale];
        [scene addItem:warningLabel];
        
        warning2 = [[Label alloc]
                        initWithFont:screenFontBig
                        text:@"THIS GAME CONTAINS BRIGHT IMAGES"
                        position:[Vector2 vectorWithX:screenWidth/2 - 260
                                                    y:screenHeight-5]
                        depth:0.1
                        ];
        [warning2 setScaleUniform:fontScale];
        [scene addItem:warning2];
        
        
        //
        // BUTTONS
        //
        
        // TEXTURES
         buttonPlay = [self.game.content load:@"ButtonPlay"];
         buttonBackground = [self.game.content load:@"ButtonBackground"];
         buttonAbout = [self.game.content load:@"ButtonAbout"];
         buttonBreak1 = [self.game.content load:@"ButtonBreak1"];
         buttonBreak2 = [self.game.content load:@"ButtonBreak2"];
        
        
        if(igra.freeplayUnlocked)
        {
            
            // BREAK 1 BUTTON
            fontScale = 0.5;
            int x = ((screenWidth/2) - (buttonBreak1.width*scale)/2) - 50;
            singleplayer = [[Button alloc]
                            initWithInputArea:[Rectangle rectangleWithX:x
                                                                      y:300
                                                                  width:buttonBreak1.width * scale
                                                                 height:buttonBreak1.height * scale]
                            background:buttonBreak1
                            font:buttonFont
                            text:@""];
            
            [singleplayer.backgroundImage setScaleUniform:scale];
            [singleplayer.label setScaleUniform:fontScale];
            
            [singleplayer setLabelColor:[Color black]];
            [singleplayer setCamera:renderer.camera];
            [scene addItem:singleplayer];
            
            
            // BREAK 2 BUTTON
            fontScale = 0.5;
            x = ((screenWidth/2) - (buttonBreak2.width*scale)/2) + 50;
            freeplayButton = [[Button alloc]
                            initWithInputArea:[Rectangle rectangleWithX:x
                                                                      y:300
                                                                  width:buttonBreak2.width * scale
                                                                 height:buttonBreak2.height * scale]
                            background:buttonBreak2
                            font:buttonFont
                            text:@""];
            
            [freeplayButton.backgroundImage setScaleUniform:scale];
            [freeplayButton.label setScaleUniform:fontScale];
            
            [freeplayButton setLabelColor:[Color black]];
            [freeplayButton setCamera:renderer.camera];
            [scene addItem:freeplayButton];
            
        }
        else
        {
            
            // PLAY BUTTON
            fontScale = 0.5;
            int x = ((screenWidth/2) - (buttonBackground.width*scale)/2);
            singleplayer = [[Button alloc]
                            initWithInputArea:[Rectangle rectangleWithX:x
                                                                      y:300
                                                                  width:buttonBackground.width * scale
                                                                 height:buttonBackground.height * scale]
                            background:buttonPlay
                            font:buttonFont
                            text:@""];
            
            [singleplayer.backgroundImage setScaleUniform:scale];
            [singleplayer.label setScaleUniform:fontScale];
            
            [singleplayer setLabelColor:[Color black]];
            [singleplayer setCamera:renderer.camera];
            [scene addItem:singleplayer];
             
        }
        

        
        // TOP 10 BUTTON
        float mod = 0.0;
        highscore = [[Button alloc] 
                       initWithInputArea:[Rectangle rectangleWithX:(screenWidth/2) - (buttonBackground.width*scale)/2
                                                                 y:500
                                                             width:buttonBackground.width * (scale + mod)
                                                            height:buttonBackground.height * scale]
                              background:buttonBackground
                                    font:buttonFont
                                    text:@"TOP 10"];
        
        [highscore.backgroundImage setScale:[Vector2 vectorWithX:scale + mod y:scale]];
        [highscore.label setScaleUniform:fontScale];
        
        [highscore setLabelColor:[Color black]];
        [highscore setCamera:renderer.camera];
        [scene addItem:highscore];
        
        
        
        // OPTIONS BUTTON
        options = [[Button alloc] 
                   initWithInputArea:[Rectangle rectangleWithX:(screenWidth/2) - (buttonBackground.width*scale)/2
                                                             y:700
                                                         width:buttonBackground.width * scale
                                                        height:buttonBackground.height * scale]
                        background:buttonBackground
                              font:buttonFont
                              text:@"OPTIONS"];
        
        [options.backgroundImage setScaleUniform:scale];
        [options.label setScaleUniform:fontScale];
        
        
        [options setLabelColor:[Color black]];
        [options setCamera:renderer.camera];
        [scene addItem:options];
        
        
        
        // ? BUTTON
        about = [[Button alloc]
                   initWithInputArea:[Rectangle rectangleWithX:0 + 10
                                                             y:screenHeight - (buttonAbout.height*scale) - 20
                                                         width: (buttonAbout.width*scale)
                                                        height: (buttonAbout.height*scale)
                                      ]
                   background:buttonAbout
                   font:buttonFont
                   text:@""];
        
        [about.backgroundImage setScaleUniform:scale];
        [about.label setScaleUniform:fontScale];
        
        [about setLabelColor:[Color black]];
        [about setCamera:renderer.camera];
        [scene addItem:about];
    }
    added = YES;
}


@synthesize singleplayer, added;


- (void) setCamera:(Matrix *)camera
{
    self.camera = camera;
}


// STACK OF GAME STATES
- (void) updateWithGameTime:(GameTime *)gameTime
{
	[super updateWithGameTime:gameTime];
    
	
	newState = nil;
    /*
    //
    // CONTINUE BUTTON
    //
    if(continueButton.wasReleased && continueButton.enabled)
    {
        newState = [igra loadState];
        [continueButton setEnabled:NO];
        [scene removeItem:continueButton];
    }
    */
    //
    // PLAY BUTTON
    //
	if (singleplayer.wasReleased)
    {
       
        // CONTINUE GAME
        if(igra.savedState && !igra.gameover)
        {
            newState = [igra loadState];
        }
        
        // NEW GAME
        else
        {
            Class levelClass = [igra getLevelClass:0]; //we start in level1 located at [0]
            Gameplay *gameplay = [[Gameplay alloc] initSinglePlayerWithGame:self.game
                                                                  levelClass:levelClass];
            newState = gameplay;
            
            
            [igra loadScore];
            
        }
	}
    
    //
    // TOP 10 BUTTON
    //
    else if (highscore.wasReleased)
    {
        
        // GET LEADERBOARD TYPE
        // !! in current version - only case 3 exists !! (difficulty settings disabled)
        NSString *leaderboardType = @"";
        switch (igra.difficulty) {
            case 1:
                leaderboardType = @"ChickenChallenge.easy";
                break;
                
            case 2:
                leaderboardType = @"ChickenChallenge.medium";
                break;
                
            case 3:
                leaderboardType = @"ChickenChallenge.hard";
                break;
                
            default:
                NSLog(@"ERROR HighScore -> initialize");
                break;
        }
        
        
        if( [[GameKitHelper sharedGameKitHelper:igra] isPlayerAuthenticated] )
        {
            [[GameKitHelper sharedGameKitHelper:igra] showLeaderboard:leaderboardType];
        }
        else
        {
            [[GameKitHelper sharedGameKitHelper:igra] authenticateLocalPlayer]; // TEST
        }
	}
    
    //
    // OPTIONS BUTTON
    //
    else if (options.wasReleased)
    {
		newState = [[Options alloc] initWithGame:self.game];
	}
    
    //
    // FREEPLAY BUTTON
    //
    else if(freeplayButton.wasReleased && !igra.freeplayActive && !igra.savedState)
    {
        [igra setFreeplayActive:YES];
        [igra setIntro:NO];
        [igra setIntroStart:NO];
        [igra setEggY:screenHeight/2];
        
        // NEW GAME
        Class levelClass = [igra getLevelClass:0]; //we start in level1 located at [0]
        Gameplay *gameplay = [[Gameplay alloc] initSinglePlayerWithGame:self.game
                                                             levelClass:levelClass];
        newState = gameplay;
        
        [igra loadScore];
        
        
    }
    
    //
    // ABOUT
    //
    else if(about.wasReleased)
    {
        newState = [[About alloc] initWithGame:self.game];
    }


    // PUSH NEW MENU STATE
	if (newState)
    {
		[igra pushState:newState];
	}
    
    
}





// HELP
- (void) unlockFreeplay
{
    float scale;
    float fontScale;
    int x;

    [scene removeItem:singleplayer];
    
    //
    // BREAK 1 BUTTON
    //
    scale = 1.0;
    fontScale = 0.5;
    x = ((screenWidth/2) - (buttonBreak2.width*scale)/2) - 50;
    singleplayer = [[Button alloc]
                      initWithInputArea:[Rectangle rectangleWithX:x
                                                                y:300
                                                            width:buttonBreak1.width * scale
                                                           height:buttonBreak1.height * scale]
                      background:buttonBreak1
                      font:buttonFont
                      text:@""];
    
    [singleplayer.backgroundImage setScaleUniform:scale];
    [singleplayer.label setScaleUniform:fontScale];
    [singleplayer setLabelColor:[Color black]];
    [singleplayer setCamera:renderer.camera];
    [scene addItem:singleplayer];
    
    
    //
    // BREAK 2 BUTTON
    //
    scale = 1.0;
    fontScale = 1.0;
    x = ((screenWidth/2) - (buttonBreak2.width*scale)/2) + 48;
    freeplayButton = [[Button alloc]
                      initWithInputArea:[Rectangle rectangleWithX:x
                                                                y:300
                                                            width:buttonBreak2.width * scale
                                                           height:buttonBreak2.height * scale]
                      background:buttonBreak2
                      font:buttonFont
                      text:@""];
    
    [freeplayButton.backgroundImage setScaleUniform:scale];
    [freeplayButton.label setScaleUniform:fontScale];
    [freeplayButton setLabelColor:[Color black]];
    [freeplayButton setCamera:renderer.camera];
    [scene addItem:freeplayButton];

}

- (void) resetPlayBtn
{
    [scene removeItem:singleplayer];
    float scale = 1.0;
    float fontScale = 0.5;
    float x = ((screenWidth/2) - (buttonBackground.width*scale)/2);
    singleplayer = [[Button alloc]
                    initWithInputArea:[Rectangle rectangleWithX:x
                                                              y:300
                                                          width:buttonBackground.width * scale
                                                         height:buttonBackground.height * scale]
                    background:buttonPlay
                    font:buttonFont
                    text:@""];
    
    [singleplayer.backgroundImage setScaleUniform:scale];
    [singleplayer.label setScaleUniform:fontScale];
    
    [singleplayer setLabelColor:[Color black]];
    [singleplayer setCamera:renderer.camera];
    [scene addItem:singleplayer];

}

// DISPLAY RESUME BUTTON - PLAY BUTTON
- (void) setContinueButton
{
    [scene removeItem:freeplayButton]; 
    [scene removeItem:singleplayer];
    
    float scale = 1.0;
    float fontScale = 0.5;
    int x = (screenWidth/2) - (buttonBackground.width*scale)/2;
    singleplayer = [[Button alloc]
                    initWithInputArea:[Rectangle rectangleWithX:x
                                                              y:300
                                                          width:buttonBackground.width * scale
                                                         height:buttonBackground.height * scale]
                    background:buttonBackground
                    font:buttonFont
                    text:@"CONTINUE"];
    
    [singleplayer.backgroundImage setScaleUniform:scale];
    [singleplayer.label setScaleUniform:fontScale];
    
    [singleplayer setLabelColor:[Color black]];
    [singleplayer setCamera:renderer.camera];
    [scene addItem:singleplayer];
}

- (void) deactivate {
    [super deactivate];
}



@end
