//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "GameHud.h"
#import "Namespace.XniGame.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.Pipeline.Processors.h"
#import <Social/Social.h>

@implementation GameHud

- (id) initWithGame:(Game *)theGame
{
	self = [super initWithGame:theGame];
	if (self != nil) {
        
        // GAME HUD SCENE
		scene = [[Scene alloc] initWithGame:self.game];
        
        igra = (Igra*)self.game;
        
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
        
        content = [[ContentManager alloc] initWithServiceProvider:theGame.services];
        
	}
	return self;
}

- (void) initialize
{
	FontTextureProcessor *fontProcessor = [[FontTextureProcessor alloc] init];
	SpriteFont *buttonFont = [self.game.content load:@"RetrotypeMain" processor:fontProcessor];
    SpriteFont *screenFont = [self.game.content load:@"Retrotype_BIG" processor:fontProcessor];
    SpriteFont *gameOverFont = [self.game.content load:@"Retrotype_GameOver" processor:fontProcessor];
    screenFont.lineSpacing = 5;
    
    
    Texture2D *buttonTexture = [self.game.content load:@"ButtonBackground"];
    Texture2D *faceTexture = [self.game.content load:@"facebookLogo"];
    Texture2D *tweetTexture = [self.game.content load:@"tweeterLogo"];
    Texture2D *rateTexture = [self.game.content load:@"ratingLogo"];
    
    float scale = 0.2; // IMAGE
    float fontScale = 0.5; // FONT
    float scaleX = 0.4;
    float scaleY = 0.4;
    
    //
    // iRATE
    //
    [iRate sharedInstance].delegate = self;
    
    [iRate sharedInstance].applicationBundleID = @"si.uni-lj.fri.gameteam.ChickenChallenge";
    //[iRate sharedInstance].applicationBundleID = @"com.charcoaldesign.RainbowBlocksLite";
    
	[iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    [iRate sharedInstance].message = @"This game is soo awesome, that I need to rate. I mean NOW !";
    [iRate sharedInstance].RateButtonLabel = @"YES";
    [iRate sharedInstance].RemindButtonLabel = @"Remind me later";
    [iRate sharedInstance].CancelButtonLabel = @"No thanks, still bored";


    //disable minimum day limit and reminder periods
    [iRate sharedInstance].daysUntilPrompt = 7;
    [iRate sharedInstance].remindPeriod = 30;
    

    
    
    
    
    //
    // GAMEHUD
    //
    
    // HIGHSCORE TXT
    fontScale = 0.5;
	bestScore = [[Label alloc]
                 initWithFont:screenFont
                 text:@"HIGHSCORE: 0"
                 position:[Vector2 vectorWithX:(screenWidth/2)
                                             y:50]
                 depth:0.1
                 ];
    [bestScore setScaleUniform:fontScale];

    bestScore.horizontalAlign = HorizontalAlignCenter;
    bestScore.layerDepth = 0.1;
    
    
    // SCORE TXT
    fontScale = 0.5;
    playerScore = [[Label alloc]
                       initWithFont:screenFont
                       text:@"SCORE: 0"
                       position:[Vector2 vectorWithX:(screenWidth/2)
                                                   y:95]
                       depth:0.1
                       ];
    [playerScore setScaleUniform:fontScale];

    playerScore.horizontalAlign = HorizontalAlignCenter;
    playerScore.layerDepth = 0.1;
    
    
    
    
    
    
    //
    // GAME OVER - TITLE
    //
    
    // TITLE TXT
    fontScale = 1.0;
	title = [[Label alloc]
             initWithFont:gameOverFont
             text:@"GAME OVER"
             position:[Vector2 vectorWithX:(screenWidth/2)
                                         y:90]
             depth:0.1
             ];
    [title setScaleUniform:fontScale];
	title.horizontalAlign = HorizontalAlignCenter;
   
    

    unlocked = [[Label alloc]
                   initWithFont:screenFont
                   text:@"ENDLESS FUN UNLOCKED"
                position:[Vector2 vectorWithX:(screenWidth/2)
                                            y:260]
                   depth:0.1
                   ];
    [unlocked setScaleUniform:0.5];
    
    unlocked.horizontalAlign = HorizontalAlignCenter;
    unlocked.layerDepth = 0.1;
    if( igra.freeplayUnlocked )
    {
        [unlocked setText:@""];
    }
    
    
    
    
    // MENU BUTTON
    scale = 1.0;
    fontScale = 0.5;
    resetGame = [[Button alloc]
                 initWithInputArea:[Rectangle rectangleWithX:-40
                                                           y:screenHeight - (buttonTexture.height*scale)
                                                       width:buttonTexture.width * scale
                                                      height:buttonTexture.height * scale]
                 background:buttonTexture
                 font:buttonFont
                 text:@"\n\nMENU"];
    
	[resetGame.backgroundImage setScaleUniform:scale];
    [resetGame.label setScaleUniform:fontScale];
    
    resetGame.label.verticalAlign = VerticalAlignMiddle;
	[resetGame setCamera: camera];
    
    
    // RESTART BUTTON
    scaleX = 1.0;
    scaleY = 1.0;
    fontScale = 0.6;
    restartGame = [[Button alloc]
                   initWithInputArea:[Rectangle rectangleWithX: (screenWidth/2) - (buttonTexture.width*scaleX)/2
                                                             y:screenHeight - (buttonTexture.height*scaleY)
                                                         width:buttonTexture.width * scaleX
                                                        height:buttonTexture.height * scaleY]
                   background:buttonTexture
                   font:buttonFont
                   text:@"\n\nRESTART"];
    
	[restartGame.backgroundImage setScale:[Vector2 vectorWithX:scaleX
                                                             y:scaleY]
    ];
    [restartGame.label setScaleUniform:fontScale];
    
    restartGame.label.verticalAlign = VerticalAlignMiddle;
	[restartGame setCamera: camera];

    
    
    
    // SUBMIT SCORE BUTTON
    if( ! igra.scoreReported ){
        fontScale = 0.5;
        submit = [[Button alloc]
                  initWithInputArea:[Rectangle rectangleWithX:screenWidth - (buttonTexture.width*scale) + 29
                                                            y:screenHeight - (buttonTexture.height*scale)
                                                        width: buttonTexture.width * scale
                                                       height: buttonTexture.height * scale]
                  background:buttonTexture
                  font:buttonFont
                  text:@"\n\nSUBMIT\n\n\n\n\n\nSCORE"];
        
        [submit.backgroundImage setScaleUniform:scale];
        
        [submit.label setScaleUniform:fontScale];
        
        submit.label.verticalAlign = VerticalAlignMiddle;
        [submit setCamera: camera];
        [scene addItem:submit];
    }
    
    

    
    
    
    

    // TWITTER BUTTON
    scaleX = 1;
    scaleY = 1;
    twitterBtn = [[Button alloc]
              initWithInputArea:[Rectangle rectangleWithX:screenWidth - tweetTexture.width * scaleX - 10
                                                        y:screenHeight/2 - (tweetTexture.height * scaleY) - (rateTexture.height*scaleY)
                                                    width: tweetTexture.width * scaleX
                                                   height: tweetTexture.height * scaleY]
              background:tweetTexture
              font:buttonFont
              text:@""];
    [twitterBtn.backgroundImage setScale:[Vector2 vectorWithX:scaleX
                                                            y:scaleY]
    ];
    [twitterBtn setCamera: camera];
    
    
    // RATING BTN
    ratingBtn = [[Button alloc]
                  initWithInputArea:[Rectangle rectangleWithX:screenWidth - rateTexture.width * scaleX - 10
                                                            y:screenHeight/2
                                                        width: rateTexture.width * scaleX
                                                       height: rateTexture.height * scaleY]
                  background:rateTexture
                  font:buttonFont
                  text:@""];
    [ratingBtn.backgroundImage setScale:[Vector2 vectorWithX:scaleX
                                                            y:scaleY]
     ];
    [ratingBtn setCamera: camera];
    
    
    
    
    // FACEBOOK BTN
    facebookBtn = [[Button alloc]
                   initWithInputArea:[Rectangle rectangleWithX:screenWidth - faceTexture.width * scaleX - 10
                                                             y:screenHeight/2 + (faceTexture.height * scaleY) + (rateTexture.height*scaleY)
                                                         width: faceTexture.width * scaleX
                                                        height: faceTexture.height * scaleY]
                   background:faceTexture
                   font:buttonFont
                   text:@""];
    [facebookBtn.backgroundImage setScale:[Vector2 vectorWithX:scaleX
                                                             y:scaleY]
     ];
    [facebookBtn setCamera: camera];
    
    
    
    // BACK buttON
    scaleX = 1.0;
    scaleY = 1.0;
    fontScale = 0.5;
    backMenu = [[Button alloc]
                initWithInputArea:[Rectangle rectangleWithX:-40
                                                          y:screenHeight - (buttonTexture.height*scale)
                                                      width:buttonTexture.width * scaleX
                                                     height:buttonTexture.height * scaleY]
                background:buttonTexture
                font:buttonFont
                text:@"PAUSE"
                ];
    [backMenu.backgroundImage setScale:[Vector2 vectorWithX:scaleX
                                                          y:scaleY]
     ];
    [backMenu.label setScaleUniform:fontScale];
    
    backMenu.label.verticalAlign = VerticalAlignMiddle;
    [backMenu setCamera: camera];
    
    
}


@synthesize scene, camera;








- (void) updateWithGameTime:(GameTime *)gameTime {
    
    [self updateScore:igra.score best:igra.bestScore];
    
    
    [scene clear];
    
    // IN-GAME UPDATE
    if( ![[GameKitHelper sharedGameKitHelper:igra] gamePaused] )
    {
        [resetGame update];
        [restartGame update];
        [submit update];
        [facebookBtn update];
        [twitterBtn update];
        [backMenu update];
        [ratingBtn update];
    }

    
    // SCORE COLOR CHANGE UPDATE
    if(igra.score > igra.bestScore)
    {
        [playerScore setColor:[Color yellow]];
    }
    else
    {
        [playerScore setColor:[Color white]];
    }
    



    //
    // GAME OVER HUD
    if(igra.stop)
    {
        [bestScore setPosition:[Vector2 vectorWithX:screenWidth/2
                                                  y:400]
         ];
        [playerScore setPosition:[Vector2 vectorWithX:screenWidth/2
                                                    y:440]
         ];
        
        [scene addItem:title];
        
        [scene addItem:playerScore];
        [scene addItem:bestScore];
        
        [scene addItem:restartGame];
        
        [scene addItem:resetGame];
        
        [scene addItem:facebookBtn];
        [scene addItem:ratingBtn];
        [scene addItem:twitterBtn];

        
        // SAVE SCORE
        if( !igra.scoreReported && [[GameKitHelper sharedGameKitHelper:igra] isGameCenterAvailable])
        {
            [igra saveScore];
        }
        if( !igra.scoreReported )
        {
            [scene addItem:submit];
        }
        

        // CHECK IF PLAYER WON
        if( igra.eggY < (screenHeight/2) )
        {
            [title setText: @"VICTORY !"];
            [scene addItem:unlocked];
            
            if( !igra.freeplayUnlocked )
            {
                [igra setFreeplayUnlocked:YES];
            }
            
        }
        
        
        //
        // RESTART BUTTON
        if(restartGame.wasReleased)
        {
            [[GameKitHelper sharedGameKitHelper:igra] showAdvertisment:igra.interstitial];
            
            [igra restart];
        }
        //
        // MENU BUTTON
        else if(resetGame.wasReleased)
        {
            [[GameKitHelper sharedGameKitHelper:igra] showAdvertisment:igra.interstitial];
            
            if(igra.freeplayActive)
            {
                [igra setFreeplayActive:NO];
            }
            
            [igra reset];
        }
        //
        // FACEBOOK BUTTON
        else if (facebookBtn.wasReleased)
        {
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                [controller setInitialText:@"Scoring chicks just got easy https://itunes.apple.com/us/app/chicken-challenge/id855265199?ls=1&mt=8"];
                [igra.gameWindow.gameViewController presentViewController:controller animated:YES completion:Nil];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Note" message:@"Please login to your facebook account in settings." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
        //
        // TWEETER BUTTON
        else if (twitterBtn.wasReleased)
        {
            NSString* tweet = @"Just scored ";
            NSString* postpone = igra.score==1 ? @"chick at https://itunes.apple.com/us/app/chicken-challenge/id855265199?ls=1&mt=8" : @"chicks at https://itunes.apple.com/us/app/chicken-challenge/id855265199?ls=1&mt=8";
            tweet = [tweet stringByAppendingString: [NSString stringWithFormat:@"%d ",igra.score]];
            tweet = [tweet stringByAppendingString:postpone];
            
            
            
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                SLComposeViewController *tweetSheet = [SLComposeViewController
                                                       composeViewControllerForServiceType:SLServiceTypeTwitter];
                
                [tweetSheet setInitialText:tweet];
                
                [igra.gameWindow.gameViewController presentViewController:tweetSheet animated:YES completion:nil];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Note" message:@"Please login to your tweeter account in settings." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }
        //
        // RATING BUTTON
        //
        else if(ratingBtn.wasReleased)
        {
            [unlocked setText:@"Connecting to AppStore..."];
            [[iRate sharedInstance] openRatingsPageInAppStore];
        }
        //
        // SUBMIT BUTTON
        else if(submit.wasPressed && !igra.scoreReported)
        {
            if( [[GameKitHelper sharedGameKitHelper:igra] isPlayerAuthenticated] )
            {
                [igra saveScore];
            }
            else
            {
                [[GameKitHelper sharedGameKitHelper:igra] authenticateLocalPlayer];
            }
        }
        //
        // NO BUTTONS WERE PRESSED
        else
        {
            
        }
    }
    
    
    //
    // GAME HUD
    //
    else if(!igra.intro && !igra.introStart)
    {
        [scene addItem:playerScore];
        [scene addItem:bestScore];
        
        
        // BACK BUTTON
        [scene addItem:backMenu];
        if(backMenu.wasReleased)
        {
            [igra mainMenuButtonFix];
            [igra saveState];
            [igra popState];
        }
    }
    
    
    
    

}


// iRATE DELEGATE
- (void)iRateCouldNotConnectToAppStore:(NSError *)error
{
	[unlocked setText:@"Could not connect to AppStore"];
    NSLog(@" COULDNT CONNECT iRATE ");
}

- (void)iRateDidOpenAppStore
{
	[unlocked setText:@""];
}


// HELP
- (void) updateScore:(int)value best:(int)theBestScore
{
    [playerScore setText:[NSString stringWithFormat:@"SCORE: %i", value] ];
    [bestScore setText:[NSString stringWithFormat:@"HIGHSCORE: %i", theBestScore] ];
}


- (void) setDisplayMessage:(NSString*)theTitle
{
    [title setText:theTitle];
    title.horizontalAlign = HorizontalAlignCenter;
}






- (void) unloadContent{
    [content unload];
}


@end
