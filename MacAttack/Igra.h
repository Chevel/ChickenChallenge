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

#import "Retronator.Xni.Framework.h"

#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

@interface Igra : Game{
    
//    // GRAPHICS
//    GraphicsDeviceManager *graphics;
//    

//
//    // GAME STATE
//    GameState *savedState;
//    
//    // GAME DATA
//    int stage;
//	int score;
//    int bestScore;
//    float backgroundProgress;  //y value for background rectangle, save position of spritebatch
//    BOOL gameover;
//    BOOL stop;
//    BOOL active;
//    int speed;
//    
//    // iAD
//    BOOL showAd;
//    BOOL adAvailable;
//    
//    int difficulty;
//    int easy,medium,hard;
//    
//    // EASTER EGG
//    int eggPop;
//    BOOL easterEgg;
//    
//    // TOUCHY
//    TouchPanel *touchPanel;
//    Matrix *inverseView;
//    Matrix *camera;
//    Vector2 *position;
//    Rectangle *inputArea;
//	BOOL grabbed;
//    
//    // MUSIC
//    MediaPlayer *mp;
//    Song *song;
//    BOOL sfx;
//    
//    BOOL introStart, gameoverDeathStart;
//    BOOL intro, outro;
//    float eggY;
//    BOOL first;
//    
//    BOOL scoreReported;
//    BOOL scoreWasChecked;
//    int prevBest;
//    
//    // GAME MODE
//    BOOL freeplayUnlocked;
//    BOOL freeplayActive;
}

// iAD ADVERTISMENT
@property BOOL scoreReported;
@property (nonatomic) ADInterstitialAd* interstitial;


// GAME DATA
@property float backgroundProgress;
@property BOOL intro, introStart;
@property BOOL easterEgg;
@property float eggY;
@property BOOL stop;
@property BOOL active;
@property (nonatomic) int stage;
@property BOOL freeplayActive;
@property BOOL outro;
@property int difficulty;
@property int score;
@property BOOL gameover;
@property BOOL freeplayUnlocked;  // gameplay
@property (nonatomic, strong) GameState *savedState;
@property int bestScore;


// SOUND STUFF
@property (strong) MediaPlayer *mp;
@property BOOL sfx;



// POWERUP
@property BOOL slowed;

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
