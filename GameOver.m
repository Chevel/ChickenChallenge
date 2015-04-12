//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "Namespace.XniGame.h"
#import "Retronator.Xni.Framework.h" 

@implementation GameOver


@synthesize tmpPositionX;

- (void) activate{
    [super activate];
}


- (void) initialize {
    [super initialize];

    [scene clear];  
    
    
    // SHOW AD
    [[GameKitHelper sharedGameKitHelper:igra] showAdvertisment:igra.interstitial];
    
    
    
    // DIFFICULTY TXT
    // currently its allways hard.
    // code is leftover in case difficulty settings would be added 
    NSString *lvl;
    switch (igra.difficulty) {
        case 1:
            lvl = @" \"SUNNY SIDE UP\" ";
            break;
            
        case 2:
            lvl = @" \"SCRAMBLED EGGS\" ";
            break;
            
        case 3:
            lvl = @" \"HARD BOILED\" ";
            break;
            
        default:
            NSLog(@" ERROR GameOver.m --> initialize");
            break;
    }
    difficulty = [[Label alloc]
             initWithFont:screenFont
             text:lvl
             position:[Vector2 vectorWithX:(screenWidth/2)+12
                                         y:200]
             depth:0.1
             ];
	difficulty.horizontalAlign = HorizontalAlignCenter;
    
    
    
    // TEXT
	title = [[Label alloc]
             initWithFont:screenFont
             text:igra.outro ? @"GOOD JOB !\n HOW'S YOUR SCORE ?" : @"GAME OVER"
             position:[Vector2 vectorWithX:(screenWidth/2)+12
                                         y:280]
             depth:0.1
             ];
	title.horizontalAlign = HorizontalAlignCenter;
    [title setScale:[Vector2 vectorWithX:2 y:2]];
    
    
    // BEST SCORE
    bestScore = [[Label alloc]
             initWithFont:screenFont
             text:@"HIGHSCORE: 0"
             position:[Vector2 vectorWithX:(screenWidth/2)+10
                                         y:screenHeight/2]
             depth:0.1
             ];
	bestScore.horizontalAlign = HorizontalAlignCenter;
    [bestScore setColor:[Color white]];
    
    // SCORE
    score = [[Label alloc]
             initWithFont:screenFont
             text:@"SCORE: 0"
        position:[Vector2 vectorWithX:(screenWidth/2)+10
                                    y:screenHeight/2 + 40]
             depth:0.1
             ];
	score.horizontalAlign = HorizontalAlignCenter;
    [score setColor:[Color white]];
    
    
    
    
    
    // OK
    float scaleX = 0.4;
    float scaleY = 0.4;
    Texture2D *okButton = [self.game.content load:@"ButtonBackground"];  
    resetGame = [[Button alloc]
                   initWithInputArea:[Rectangle rectangleWithX:80
                                                             y:screenHeight-120
                                                         width:okButton.width * scaleX
                                                        height:okButton.height * scaleY]
                   background:okButton
                   font:screenFont
                   text:@"MENU"];
	[resetGame.backgroundImage setScaleUniform:0.4];
    [resetGame setLabelColor:[Color black]];
	[resetGame setCamera: renderer.camera];
    
    
    // RESTART
    Texture2D *restartButton = [self.game.content load:@"ButtonBackground"];  
    restartGame = [[Button alloc]
                   initWithInputArea:[Rectangle rectangleWithX: (screenWidth/2) - (restartButton.width*scaleX)/2
                                                             y:screenHeight-120
                                                         width:restartButton.width * scaleX
                                                        height:restartButton.height * scaleY]
                   background:restartButton
                   font:screenFont
                   text:@"RESTART"];
	[restartGame.backgroundImage setScaleUniform:0.4];
    [restartGame setLabelColor:[Color black]];
	[restartGame setCamera: renderer.camera];
    
    
    
    // SHARE WITH FRIENDS (facebook, twitter)
    if( ! igra.scoreReported ){
        Texture2D *shareButton = [self.game.content load:@"ButtonBackground"]; 
        submit = [[Button alloc]
                       initWithInputArea:[Rectangle rectangleWithX:screenWidth-200
                                                                 y:screenHeight-120
                                                             width: shareButton.width * scaleX
                                                            height: shareButton.height * scaleY]
                       background:shareButton
                       font:screenFont
                       text:@"SHARE"];
        [submit.backgroundImage setScale:[Vector2 vectorWithX:scaleX
                                                            y:scaleY]
         ];
        [submit setLabelColor:[Color black]];
        [submit setCamera: renderer.camera];
        
        [scene addItem:submit];
    
    }
    else{
        tmpPositionX = screenWidth/2 - resetGame.inputArea.width/2;
        [resetGame.inputArea setX:tmpPositionX];
    }
    

    

    
    //NSLog(@" GAMEOVER INIT ");
    
    
    
    // add all

    
    [scene addItem:title];
    //[scene addItem:difficulty];
    
    [scene addItem:score];
    [scene addItem:bestScore];
    

    [scene addItem:restartGame];
    [scene addItem:resetGame];
    
    


}


- (void) setScore:(int)currentPoints Best:(int)bestPoints{
    [score setText:[NSString stringWithFormat:@"SCORE: %i", currentPoints]];
    
    [bestScore setText:[NSString stringWithFormat:@"HIGHSCORE: %i", bestPoints]];

    if(igra.score > igra.bestScore){
        [score setColor:[Color yellow]];
    }
    else{
        [score setColor:[Color white]];
    }
    
}



- (void) setDisplayMessage:(NSString*)theTitle{
    [title setText:theTitle];
    title.horizontalAlign = HorizontalAlignCenter;
}


- (void) updateWithGameTime:(GameTime *)gameTime {

    [scene clear];
    
    [resetGame update];
    [restartGame update];
    
    
    if(restartGame.wasPressed)
    {
        [igra restart];
    }
        
    if(resetGame.wasReleased)
    {
        [igra reset];
    }
    else if(submit != nil)
    {
        [submit update];
        
        if( [[GameKitHelper sharedGameKitHelper:igra] isPlayerAuthenticated] ){
            [submit.label setText:@"SUBMIT SCORE"];
        }
        else{
            [submit.label setText:@"LOGIN TO SUBMIT"];
        }
    
        if(submit.wasReleased)
        {
            if( [[GameKitHelper sharedGameKitHelper:igra] isPlayerAuthenticated] )
            {
                [[GameKitHelper sharedGameKitHelper:igra] reportScore:igra.score forLeaderboardID:[igra currentLeaderboard]];
                [igra reset];
            }
            else
            {
                [[GameKitHelper sharedGameKitHelper:igra] authenticateLocalPlayer];
                
                if( [[GameKitHelper sharedGameKitHelper:igra] isPlayerAuthenticated] ){
                    NSLog(@" AUTHENTICATED ");
                }
            }
        }
    }
    else{
        // NO BUTTONS WERE PRESSED
    }
    

    

}


@end
