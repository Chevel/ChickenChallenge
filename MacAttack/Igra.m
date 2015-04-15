//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import "Igra.h"

#import "Namespace.XniGame.h"

#import "Retronator.Xni.Framework.h"

#import "GameKit/GameKit.h"

#import <iAd/iAd.h>

#import "TapForTap.framework/Headers/TFTTapForTap.h"


@implementation Igra

- (id)init {
    if (self = [super init]) {
        
        graphics = [[GraphicsDeviceManager alloc] initWithGame:self];
        
		[self.components addComponent:[[TouchPanelHelper alloc] initWithGame:self]];
        
		stateStack = [[NSMutableArray alloc] init];
        
        
        // TapForTap - advertisment
        [TFTTapForTap initializeWithAPIKey: @"3d323e6d58c83e06dba2547ec54f8afc"];
        

        
        
        
        // iAD - LOAD NEW ADVERTISMENT
        @try
        {
            interstitial = [[ADInterstitialAd alloc] init];
            interstitial.delegate = [GameKitHelper sharedGameKitHelper:self];
        }
        @catch (NSException *exception)
        {
            //[[GameKitHelper sharedGameKitHelper:self] setAdAvailable:NO];
            adAvailable = NO;
        }

        
        // TESTING PURPOSE - RESET NSUserdefaults - reset score - RESET GAME DATA
        /*
        NSString *domainName = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:domainName];
        */
        
        
        freeplayActive = NO;  // currentLeaderboard reads this value
        
        //
        // LOAD HIGHSCORE
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *bestScoreSaved = [defaults objectForKey:[self currentLeaderboard]];
        [self setBestScore:[bestScoreSaved integerValue]];
        
        
        //
        // GAME DATA
        //
        easy = 1;
        medium = 2;
        hard = 3;
        
        intro = YES;
        outro = NO;
        
        difficulty = hard;
        savedState = nil;
        
        stage = 0;
		score = 0;
		backgroundProgress = 3470; //3150 = start game position;  3470 = intro position
        
        gameover = NO;
        active = NO;
        
        eggPop = 0;
        
        scoreWasChecked = NO;
        scoreReported = NO;
        introStart = YES;
        stop = NO;
        
        freeplayUnlocked = [[defaults objectForKey:@"freeplay"] integerValue] == 1 ? YES : NO;
        
        // TESTING PURPOSE
        //freeplayUnlocked = NO;
        
        

        
        gameoverDeathStart = NO;

        easterEgg = NO;
        
        
        
        // EASTER EGG on easter
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger day = [components day];
        NSInteger month = [components month];
        if( (month >= 3 && day > 22) && (month <= 4 && day < 25) )
        {
            easterEgg = YES;
        }
        else
        {
            easterEgg = NO;
        }
        
        
    }
    return self;
}

@synthesize interstitial, showAd, adAvailable;
@synthesize prevBest, scoreReported, scoreWasChecked;
@synthesize graphics, savedState, backgroundProgress, stage, camera;
@synthesize mp, song;
@synthesize easy, medium, hard;
@synthesize score, bestScore, gameover, eggPop, easterEgg, active, difficulty, sfx, intro, outro, introStart, gameoverDeathStart, eggY, stop;
@synthesize slowed;
@synthesize freeplayUnlocked, freeplayActive;


-(void) initialize{
    
    // POWERUP
    slowed = NO;
    
    // INIT SOUND
    song = [self.content load:@"DST-GameOn"];
    mp = [MediaPlayer getInstance];
    mp.isRepeating = true;
    mp.volume = 0.1; // MUSIC VOLUME
    [mp playSong:song];
    
    
    
    // SFX
    sfx = true;
    
    // ADD LEVEL
	levelClasses = [[NSMutableArray alloc] init];
	[levelClasses addObject:[Level1 class]];
    
    // CONTINUE
    if(savedState != nil){
        [self pushState:savedState];
    }
    // NEW GAME - MAIN MENU
    else{
        MainMenu *mainMenu = [[MainMenu alloc] initWithGame:self];
        [self pushState:mainMenu];
    }
    
    
    // INIT ALL COMPONENTS
	[super initialize];
    
    
    
    [SoundEngine initializeWithGame:self];
    

    
    touchPanel = [TouchPanel getInstance];
    
    inputArea = [[Rectangle alloc] initWithX:0
                                           y:0
                                       width:screenWidth
                                      height:screenHeight
                 ];
    
    
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
    
    
    [self setCamera:camera];
    
    eggY = (screenHeight - 35); // egg on screen
    
    
    
    
    

    
    
}


//  STATE MANAGEMENT
- (void) pushState: (GameState *)gameState {
    
    
    //    NSLog(@"\n PUSH = %@", gameState);
    
    
	GameState *currentActiveState = [stateStack lastObject];
	[currentActiveState deactivate];
	[self.components removeComponent:currentActiveState];
    

    //[gameState initialize];
    

	[stateStack addObject:gameState];
	[self.components addComponent:gameState];
	[gameState activate];
    
    
    
    /*
        NSLog(@"\n------------------------");
        NSLog(@"\n ACTIVE = %@, \n COUNT = %d \n STACK = %d", gameState, [self.components count], [stateStack count]);
        NSLog(@"\n------------------------");
     */
}

- (void) popState {
    
	GameState *currentActiveState = [stateStack lastObject];
	[stateStack removeLastObject];
	[currentActiveState deactivate];
	[self.components removeComponent:currentActiveState];
    
 
	   // NSLog(@" POP = %@", currentActiveState);
    
    
	currentActiveState = [stateStack lastObject];
	[self.components addComponent:currentActiveState];
	[currentActiveState activate];
    
/*
    NSLog(@"\n------------------------");
    NSLog(@"\n ACTIVE = %@, \n COUNT = %d \n STACK = %d", currentActiveState, [self.components count], [stateStack count]);
    NSLog(@"\n------------------------");
*/
    
}

- (void) saveState {
    GameState *curentStateCopy = [[GameState alloc] initWithGame:self];
    curentStateCopy = [stateStack lastObject];
    
    self.savedState = curentStateCopy;
}

- (GameState *) loadState{
    return self.savedState;
}

- (GameState *) getState{
    return (GameState *)[stateStack lastObject];
}

- (Class) getLevelClass:(int) which {
	return [levelClasses objectAtIndex:which];
}


// GAMEPLAY
- (void) stageUP{
    self.stage+=1;
    //NSLog(@"STAGE UP - stage=%d",self.stage);
}

- (void) gameOver{
    gameover = true;
}



// RESET GAME DATA + UPDATE (eater egg,...)
- (void) resetGameData
{
    
    
    
    
    if(score > bestScore)
    {
        score = bestScore;
        
        // UPDATE HIGHSCORE
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *bestScoreSaved = [defaults objectForKey:[self currentLeaderboard]];
        [self setBestScore:[bestScoreSaved integerValue]];
    }
    prevBest = bestScore;
    
    
    // EASTER EGG CHECK
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    NSInteger month = [components month];
    if( (month >= 3 && day > 22) && (month <= 4 && day < 25) )
    {
        easterEgg = YES;
    }
    else{
        easterEgg = NO;
    }
    

    
    
    //
    // GAME DATA
    //
    easy = 1;
    medium = 2;
    hard = 3;
    
    
    outro = NO;
    
    difficulty = hard;
    savedState = nil;
    
    stage = 0;
    score = 0;
    
    
    gameover = NO;
    active = NO;
    
    eggPop = 0;
    
    scoreWasChecked = NO;
    scoreReported = NO;
    
    stop = NO;
        
    gameoverDeathStart = NO;
    
    slowed = NO;
    
    
}



// RESTART GAME
- (void) restart{
    
    [self popState]; // rmv gameover
    
    intro = NO;
    backgroundProgress = 3150;
    introStart = NO;
    eggY = screenHeight/2;
    
    
    [self resetGameData];
    
    
    // NEW GAME
    Class levelClass = [self getLevelClass:0];
    Gameplay *gameplay = [[Gameplay alloc] initSinglePlayerWithGame:self
                                                         levelClass:levelClass];
    [self pushState:gameplay];
}


// RESET GAME
- (void) reset{
    
    [self resetGameData];
    

    // BUTTON SPECIFIC
    intro = YES;
    backgroundProgress = 3470; //3150 = start;  3470 = inital intro
    introStart = YES;
    eggY = (screenHeight - (35)); // for intro, put animation on grass
    
    
    // UNLOCK FREEPLAY IN MAINMENU
    if(freeplayUnlocked)
    {
        [(MainMenu*) [stateStack objectAtIndex:0] unlockFreeplay];
    }
    else
    {
        [(MainMenu*) [stateStack objectAtIndex:0] resetPlayBtn];
    }
    
    
    
    // RETURN TO MAIN MENU
    [self popState]; // rmv gameover
    
    


    
}



// BACKGROUND ANIMATION
- (void) updateBackgroundProgress{
    
    if(!outro){
        backgroundProgress -= 0.5; // 0.5 = speed of background
    }

    //NSLog(@" BCKGRND = %f", backgroundProgress);
}



// MUSIC and SOUND
- (void) musicSelect: (BOOL) state{
    state ? [mp playSong:song] : [mp stop];
}

- (void) sfxSelect: (BOOL) state{
    sfx = state;
    float volume = state ? 1 : 0;
    [SoundEffect setMasterVolume:volume];
}



// HELPERS
- (void) setCamera:(Matrix *)theCamera{
    
    inverseView = [Matrix invert:theCamera];
    
    //NSLog(@" IGRA - SET CAMERA");
}

- (NSString*) currentLeaderboard
{
    return freeplayActive ? @"ChickenChallenge.freeplay" : @"ChickenChallenge.hard";
}

- (NSString*) getDifficultyString{
    
    return @"HARD BOILED";
    
    /* // difficulty select, at one point I considered difficulty settings
    switch (difficulty) {
        case 1:
            return @"SUNNY SIDE UP";
            break;
            
        case 2:
            return @"SCRAMBLED EGGS";
            break;
            
        case 3:
            return @"HARD BOILED";
            break;
            
        default:
            return nil;
    }
     */
}

- (void) updateBestScoreDisplay{
    
    // UPDATE BEST SCORE BASED ON DIFFICULTY
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *bestScoreSaved = [defaults objectForKey:[self currentLeaderboard]];
    [self setBestScore:[bestScoreSaved integerValue]];
    
}

- (void) playMusic{
    [mp playSong:song];
}

- (void) saveScore
{
    
    
    //
    // GAMECENTER SAVE SCORE
    if( [[GameKitHelper sharedGameKitHelper:self] isPlayerAuthenticated] ) // isPlayerAuthenticated ???
    {
        // SAVE SCORE ON GAMECENTER
        [[GameKitHelper sharedGameKitHelper:self] reportScore:score forLeaderboardID:[self currentLeaderboard]];
        
        scoreReported = YES;
    }
    
    //
    // LOCALY SAVE SCORE
    if(score > bestScore)
    {
        prevBest = bestScore;
        
        
        // SAVE SCORE LOCALY
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *savedScore = [NSNumber numberWithInt:score];
        [defaults setObject:savedScore forKey:[self currentLeaderboard]];
        
    }
    
    scoreWasChecked = YES;
}

- (void) loadScore
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *bestScoreSaved = [defaults objectForKey:[self currentLeaderboard]];
    [self setBestScore:[bestScoreSaved integerValue]];
}

- (void) mainMenuButtonFix
{
    [(MainMenu*) [stateStack objectAtIndex:0] setContinueButton];
}


// UPDATE
- (void) updateWithGameTime:(GameTime *)theGameTime{
	[super updateWithGameTime:theGameTime];
    
    
    self.active = [[self getState] isKindOfClass:[Gameplay class]];
    

    // SAVE SCORE AT OUTRO - GAME VICTORY
    if( !scoreWasChecked )
    {
        if(outro){
            [self saveScore];
        }
    }

    
    // GAME OVER
    if( gameover )
    {
        
        
        gameover = false;
        stop = YES;
        gameoverDeathStart = YES;
        

        if( eggY < (screenHeight/2) )
        {
            // VICTORY
            [SoundEngine play:5 withVolume:1.5];
            
            // SAVE UNLOCKED FREEPLAY MODE
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSNumber *freeplay = [NSNumber numberWithInt:1];
            [defaults setObject:freeplay forKey:@"freeplay"];
            
            
        }
        else
        {
            // GAME OVER
            [SoundEngine play:6 withVolume:1.5];
        }
        
        
        // SAVE SCORE - IF GAME OVER
        if( !scoreWasChecked )
        {
            [self saveScore];
        }
        
    }
    
    // GAME NOT OVER
    if(!self.gameover && self.active)
    {
        
        //
        // EASTER EGG :)
        if(!self.easterEgg && self.score > 999) 
        {
            self.easterEgg = YES;
        }
    }
    

}




@end
