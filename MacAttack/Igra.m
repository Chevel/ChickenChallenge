//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import "Igra.h"

#import "Namespace.XniGame.h"

#import "Retronator.Xni.Framework.h"

#import "GameKit/GameKit.h"

#import <iAd/iAd.h>


@interface Igra()



//iAd ADVERTISMENT
@property BOOL adAvailable;
@property BOOL showAd;
@property BOOL scoreWasChecked;

// SOUND STUFF
@property (strong) GameKitHelper *gkHelper;
@property (strong) Song *song;

// GAME DATA
@property BOOL gameoverDeathStart;
@property int easy,medium,hard;
@property (nonatomic) float flappingSpeed;
@property int eggPop;

// STUFF
@property (nonatomic, readonly) Matrix *camera;
@property (nonatomic, readonly) GraphicsDeviceManager *graphics;
@property int prevBest;
@property (nonatomic, readonly) NSError* lastError;

// GAME STATE
@property (nonatomic, strong) NSMutableArray *stateStack;

// TABLE OF LEVELS
@property (nonatomic, strong) NSMutableArray *levelClasses;

// TOUCHY
@property (nonatomic, strong) TouchPanel *touchPanel;
@property Rectangle *inputArea;
@property Matrix *inverseView;



@end


@implementation Igra

- (id)init {
    if (self = [super init]) {
        
        _graphics = [[GraphicsDeviceManager alloc] initWithGame:self];
        
		[self.components addComponent:[[TouchPanelHelper alloc] initWithGame:self]];
        
		_stateStack = [[NSMutableArray alloc] init];
        
        

        
        
        
        // iAD - LOAD NEW ADVERTISMENT
        @try
        {
            _interstitial = [[ADInterstitialAd alloc] init];
            _interstitial.delegate = [GameKitHelper sharedGameKitHelper:self];
        }
        @catch (NSException *exception)
        {
            //[[GameKitHelper sharedGameKitHelper:self] setAdAvailable:NO];
            _adAvailable = NO;
        }

        
        // TESTING PURPOSE - RESET NSUserdefaults - reset score - RESET GAME DATA
        /*
        NSString *domainName = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:domainName];
        */
        
        
        _freeplayActive = NO;  // currentLeaderboard reads this value
        
        //
        // LOAD HIGHSCORE
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *_bestScoreSaved = [defaults objectForKey:[self currentLeaderboard]];
        [self setBestScore:[_bestScoreSaved integerValue]];
        
        
        //
        // GAME DATA
        //
        _easy = 1;
        _medium = 2;
        _hard = 3;
        
        _intro = YES;
        _outro = NO;
        
        _difficulty = _hard;
        _savedState = nil;
        
        _stage = 0;
		_score = 0;
		_backgroundProgress = 3470; //3150 = start game position;  3470 = _intro position
        
        _gameover = NO;
        _active = NO;
        
        _eggPop = 0;
        
        _scoreWasChecked = NO;
        _scoreReported = NO;
        _introStart = YES;
        _stop = NO;
        
        _freeplayUnlocked = [[defaults objectForKey:@"freeplay"] integerValue] == 1 ? YES : NO;
        
        // TESTING PURPOSE
        //_freeplayUnlocked = NO;
        
        

        
        _gameoverDeathStart = NO;

        _easterEgg = NO;
        
        
        
        // EASTER EGG on easter
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger day = [components day];
        NSInteger month = [components month];
        if( (month >= 3 && day > 22) && (month <= 4 && day < 25) )
        {
            _easterEgg = YES;
        }
        else
        {
            _easterEgg = NO;
        }
        
        
    }
    return self;
}


-(void) initialize{
    
    // POWERUP
    _slowed = NO;
    
    // INIT SOUND
    _song = [self.content load:@"DST-GameOn"];
    _mp = [MediaPlayer getInstance];
    _mp.isRepeating = true;
    _mp.volume = 0.1; // MUSIC VOLUME
    [_mp playSong:_song];
    
    
    
    // _sfx
    _sfx = true;
    
    // ADD LEVEL
	_levelClasses = [[NSMutableArray alloc] init];
	[_levelClasses addObject:[Level1 class]];
    
    // CONTINUE
    if(_savedState != nil){
        [self pushState:_savedState];
    }
    // NEW GAME - MAIN MENU
    else{
        MainMenu *mainMenu = [[MainMenu alloc] initWithGame:self];
        [self pushState:mainMenu];
    }
    
    
    // INIT ALL COMPONENTS
	[super initialize];
    
    
    
    [SoundEngine initializeWithGame:self];
    

    
    _touchPanel = [TouchPanel getInstance];
    
    _inputArea = [[Rectangle alloc] initWithX:0
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
    _camera = [Matrix createScale:[Vector3 vectorWithX:scaleX
                                                    y:scaleY
                                                    z:1]
              ];
    
    
    [self setCamera:_camera];
    
    _eggY = (screenHeight - 35); // egg on screen
    
    
    
    
    

    
    
}


//  STATE MANAGEMENT
- (void) pushState: (GameState *)gameState {
    
    
    //    NSLog(@"\n PUSH = %@", gameState);
    
    
	GameState *current_activeState = [_stateStack lastObject];
	[current_activeState deactivate];
	[self.components removeComponent:current_activeState];
    

    //[gameState initialize];
    

	[_stateStack addObject:gameState];
	[self.components addComponent:gameState];
	[gameState activate];
    
    
    
    /*
        NSLog(@"\n------------------------");
        NSLog(@"\n _active = %@, \n COUNT = %d \n STACK = %d", gameState, [self.components count], [stateStack count]);
        NSLog(@"\n------------------------");
     */
}

- (void) popState {
    
	GameState *current_activeState = [_stateStack lastObject];
	[_stateStack removeLastObject];
	[current_activeState deactivate];
	[self.components removeComponent:current_activeState];
    
 
	   // NSLog(@" POP = %@", current_activeState);
    
    
	current_activeState = [_stateStack lastObject];
	[self.components addComponent:current_activeState];
	[current_activeState activate];
    
/*
    NSLog(@"\n------------------------");
    NSLog(@"\n _active = %@, \n COUNT = %d \n STACK = %d", current_activeState, [self.components count], [stateStack count]);
    NSLog(@"\n------------------------");
*/
    
}

- (void) saveState {
    GameState *curentStateCopy = [[GameState alloc] initWithGame:self];
    curentStateCopy = [_stateStack lastObject];
    
    _savedState = curentStateCopy;
}

- (GameState *) loadState{
    return _savedState;
}

- (GameState *) getState{
    return (GameState *)[_stateStack lastObject];
}

- (Class) getLevelClass:(int) which {
	return [_levelClasses objectAtIndex:which];
}


// GAMEPLAY
- (void) stageUP{
    _stage+=1;
    //NSLog(@"_stage UP - _stage=%d",self._stage);
}



// RESET GAME DATA + UPDATE (eater egg,...)
- (void) resetGameData
{
    
    
    
    
    if(_score > _bestScore)
    {
        _score = _bestScore;
        
        // UPDATE HIGHSCORE
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *_bestScoreSaved = [defaults objectForKey:[self currentLeaderboard]];
        [self setBestScore:[_bestScoreSaved integerValue]];
    }
    _prevBest = _bestScore;
    
    
    // EASTER EGG CHECK
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    NSInteger month = [components month];
    if( (month >= 3 && day > 22) && (month <= 4 && day < 25) )
    {
        _easterEgg = YES;
    }
    else{
        _easterEgg = NO;
    }
    

    
    
    //
    // GAME DATA
    //
    _easy = 1;
    _medium = 2;
    _hard = 3;
    
    
    _outro = NO;
    
    _difficulty = _hard;
    _savedState = nil;
    
    _stage = 0;
    _score = 0;
    
    
    _gameover = NO;
    _active = NO;
    
    _eggPop = 0;
    
    _scoreWasChecked = NO;
    _scoreReported = NO;
    
    _stop = NO;
        
    _gameoverDeathStart = NO;
    
    _slowed = NO;
    
    
}



// RESTART GAME
- (void) restart{
    
    [self popState]; // rmv _gameover
    
    _intro = NO;
    _backgroundProgress = 3150;
    _introStart = NO;
    _eggY = screenHeight/2;
    
    
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
    _intro = YES;
    _backgroundProgress = 3470; //3150 = start;  3470 = inital _intro
    _introStart = YES;
    _eggY = (screenHeight - (35)); // for _intro, put animation on grass
    
    
    // UNLOCK FREEPLAY IN MAINMENU
    if(_freeplayUnlocked)
    {
        [(MainMenu*) [_stateStack objectAtIndex:0] unlockFreeplay];
    }
    else
    {
        [(MainMenu*) [_stateStack objectAtIndex:0] resetPlayBtn];
    }
    
    
    
    // RETURN TO MAIN MENU
    [self popState]; // rmv _gameover
    
    


    
}



// BACKGROUND ANIMATION
- (void) updateBackgroundProgress{
    
    if(!_outro){
        _backgroundProgress -= 0.5; // 0.5 = speed of background
    }

    //NSLog(@" BCKGRND = %f", _backgroundProgress);
}



// MUSIC and SOUND
- (void) musicSelect: (BOOL) state{
    state ? [_mp playSong:_song] : [_mp stop];
}

- (void) sfxSelect: (BOOL) state{
    _sfx = state;
    float volume = state ? 1 : 0;
    [SoundEffect setMasterVolume:volume];
}



// HELPERS
- (void) setCamera:(Matrix *)theCamera{
    
    _inverseView = [Matrix invert:theCamera];
    
    //NSLog(@" IGRA - SET _camera");
}

- (NSString*) currentLeaderboard
{
    return _freeplayActive ? @"ChickenChallenge.freeplay" : @"ChickenChallenge._hard";
}

- (NSString*) getDifficultyString{
    
    return @"_hard BOILED";
    
    /* // _difficulty select, at one point I considered _difficulty settings
    switch (_difficulty) {
        case 1:
            return @"SUNNY SIDE UP";
            break;
            
        case 2:
            return @"SCRAMBLED EGGS";
            break;
            
        case 3:
            return @"_hard BOILED";
            break;
            
        default:
            return nil;
    }
     */
}

- (void) updateBestScoreDisplay{
    
    // UPDATE BEST SCORE BASED ON _difficulty
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *_bestScoreSaved = [defaults objectForKey:[self currentLeaderboard]];
    [self setBestScore:[_bestScoreSaved integerValue]];
    
}

- (void) playMusic{
    [_mp playSong:_song];
}

- (void) saveScore
{
    
    
    //
    // GAMECENTER SAVE SCORE
    if( [[GameKitHelper sharedGameKitHelper:self] isPlayerAuthenticated] ) // isPlayerAuthenticated ???
    {
        // SAVE SCORE ON GAMECENTER
        [[GameKitHelper sharedGameKitHelper:self] reportScore:_score forLeaderboardID:[self currentLeaderboard]];
        
        _scoreReported = YES;
    }
    
    //
    // LOCALY SAVE SCORE
    if(_score > _bestScore)
    {
        _prevBest = _bestScore;
        
        
        // SAVE SCORE LOCALY
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *savedScore = [NSNumber numberWithInt:_score];
        [defaults setObject:savedScore forKey:[self currentLeaderboard]];
        
    }
    
    _scoreWasChecked = YES;
}

- (void) loadScore
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *_bestScoreSaved = [defaults objectForKey:[self currentLeaderboard]];
    [self setBestScore:[_bestScoreSaved integerValue]];
}

- (void) mainMenuButtonFix
{
    [(MainMenu*) [_stateStack objectAtIndex:0] setContinueButton];
}


// UPDATE
- (void) updateWithGameTime:(GameTime *)theGameTime{
	[super updateWithGameTime:theGameTime];
    
    
    _active = [[self getState] isKindOfClass:[Gameplay class]];
    

    // SAVE SCORE AT _outro - GAME VICTORY
    if( !_scoreWasChecked )
    {
        if(_outro){
            [self saveScore];
        }
    }

    
    // GAME OVER
    if( _gameover )
    {
        
        
        _gameover = false;
        _stop = YES;
        _gameoverDeathStart = YES;
        

        if( _eggY < (screenHeight/2) )
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
        if( !_scoreWasChecked )
        {
            [self saveScore];
        }
        
    }
    
    // GAME NOT OVER
    if(!_gameover && _active)
    {
        
        //
        // EASTER EGG :)
        if(!_easterEgg && _score > 999)
        {
            _easterEgg = YES;
        }
    }
    

}




@end
