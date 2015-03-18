//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.Media.h"
#import "Namespace.XniGame.classes.h"

#import "GameState.h"
#import "TouchPanel.h"
#import "GameKitHelper.h"
#import <iAd/iAd.h>

#import "Retronator.Xni.Framework.h"

#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

@interface Igra : Game{
    
    // GRAPHICS
    GraphicsDeviceManager *graphics;
    
    // TABLE OF LEVELS
    NSMutableArray *levelClasses;

    // GAME STATE
    NSMutableArray *stateStack;
    GameState *savedState;
    
    // GAME DATA
    int stage;
	int score;
    int bestScore;
    float backgroundProgress;  //y value for background rectangle, save position of spritebatch
    BOOL gameover;
    BOOL stop;
    BOOL active;
    int speed;
    
    // iAD
    BOOL showAd;
    BOOL adAvailable;
    
    int difficulty;
    int easy,medium,hard;
    
    // EASTER EGG
    int eggPop;
    BOOL easterEgg;
    
    // TOUCHY
    TouchPanel *touchPanel;
    Matrix *inverseView;
    Matrix *camera;
    Vector2 *position;
    Rectangle *inputArea;
	BOOL grabbed;
    
    // MUSIC
    MediaPlayer *mp;
    Song *song;
    BOOL sfx;
    
    BOOL introStart, gameoverDeathStart;
    BOOL intro, outro;
    float eggY;
    BOOL first;
    
    BOOL scoreReported;
    BOOL scoreWasChecked;
    int prevBest;
    
    // GAME MODE
    BOOL freeplayUnlocked;
    BOOL freeplayActive;
}



// POWERUP
@property BOOL slowed;

//iAd ADVERTISMENT
@property BOOL adAvailable;
@property ADInterstitialAd* interstitial;
@property BOOL showAd;

@property BOOL scoreWasChecked;
@property BOOL scoreReported;

// SOUND STUFF
@property (strong) GameKitHelper *gkHelper;
@property (strong) MediaPlayer *mp;
@property (strong) Song *song;
@property BOOL sfx;

// GAME DATA
@property float eggY;
@property BOOL intro, outro, introStart, gameoverDeathStart;

@property int difficulty;
@property int easy,medium,hard;

@property (nonatomic) float flappingSpeed;
@property (nonatomic) int score, bestScore, stage;
@property (nonatomic) float backgroundProgress;
@property BOOL active;


@property int eggPop;
@property BOOL easterEgg;  // to display easter egg

@property BOOL freeplayUnlocked;  // gameplay
@property BOOL freeplayActive;

@property BOOL gameover;
@property BOOL stop;
@property (nonatomic, strong) GameState *savedState;

// STUFF
@property (nonatomic, readonly) Matrix *camera;
@property (nonatomic, readonly) GraphicsDeviceManager *graphics;
@property int prevBest;


@property (nonatomic, readonly) NSError* lastError;

- (void) mainMenuButtonFix;

// POWERUP GAME MECHANICS
- (void) resetGameData;

// MUSIC SELECT
- (void) musicSelect:(BOOL) state;
- (void) sfxSelect:(BOOL) state;

// STATE CHANGE
- (void) saveState;
- (void) pushState: (GameState *) gameState;
- (void) popState;
- (GameState *) loadState;

// GAME MECHANICS
- (void) gameOver;
- (void) stageUP;
- (void) reset;
- (void) restart;
- (Class) getLevelClass:(int) which;

// GRAPHICS
- (void) updateBackgroundProgress;

// OTHER
- (void) setCamera:(Matrix *)camera;
- (NSString*) currentLeaderboard;
- (void) updateBestScoreDisplay;
- (NSString*) getDifficultyString;
- (void) playMusic;

- (void) saveScore;
- (void) loadScore;


@end
