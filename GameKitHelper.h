//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "Namespace.XniGame.classes.h"

#import <iAd/iAd.h>

@protocol GameKitHelperProtocol<NSObject>
@optional

-(void) onLocalPlayerAuthenticationChanged;
-(void) onFriendListReceived:(NSArray*)friends;
-(void) onPlayerInfoReceived:(NSArray*)players;


@end



@interface GameKitHelper : NSObject<GKGameCenterControllerDelegate, GameKitHelperProtocol,ADInterstitialAdDelegate>
{
    id < GameKitHelperProtocol > delegate;
    BOOL gameCenterFeaturesAvailable;
    BOOL isPlayerAuthenticated;
    NSError* lastError;
    
    Game* game;
    GameWindow* gameWindow;
    GameViewController* gameViewController;
    
    BOOL gamePaused;
    BOOL adAvailable;
    
    UIView* adView;
    
}

@property (nonatomic, retain) UIView* adView;

@property BOOL gamePaused;
@property BOOL adAvailable;

@property (nonatomic, retain) Game* game;
@property (nonatomic, retain) GameWindow* gameWindow;
@property (nonatomic, retain) GameViewController* gameViewController;

@property (nonatomic, retain) id<GameKitHelperProtocol>delegate;
@property BOOL gameCenterFeaturesAvailable;
@property (nonatomic, readonly) BOOL isPlayerAuthenticated;
@property (nonatomic, readonly) NSError* lastError;



+(id) sharedGameKitHelper:(Game*)theGame;


// Player authentication, info
-(void) authenticateLocalPlayer;

-(void) showGameCenter;

-(GameViewController *) gameViewController;


// ADVERTISMENT
-(void) showAdvertisment:(ADInterstitialAd*)theAd;

// TAP FOR TAP ADVERTISMENT
- (void) tapForTapShowInterstitialBreak;

// SCORE
-(void) reportScore:(int)score forLeaderboardID: (NSString*) identifier;
-(int) retrieveBestScoreForLeaderboard:(NSString*)identifier;

// LEADERBOARD
-(void) showLeaderboard:(NSString*) leaderboardID;

// PLAYER
-(BOOL) isPlayerAuthenticated;

// HELPER
-(void) showGameCenter;
-(BOOL) isGameCenterAvailable;


@end
