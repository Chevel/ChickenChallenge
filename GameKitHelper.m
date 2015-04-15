//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "Namespace.XniGame.h"


#import "GameWindow.h"
#import "GameViewController.h"

#import <iAd/iAd.h>

#import "TapForTap.framework/Headers/TFTTapForTap.h"


@implementation GameKitHelper


static GameKitHelper *sharedHelper = nil;

+(id)sharedGameKitHelper: (Game*)theGame{
    
    if (!sharedHelper) {
        sharedHelper = [[GameKitHelper alloc] init];

    }
    
    
    [sharedHelper setGame:theGame];
    
    GameWindow *gameWindow = (GameWindow*)[theGame gameWindow];
    [sharedHelper setGameWindow:gameWindow];
    
    [sharedHelper setGameViewController: [ gameWindow gameViewController] ];
    
    
    
    // because this class is a singleton, gameCenterAvailable is checked and set with every method
    [sharedHelper setGameCenterFeaturesAvailable:[sharedHelper isGameCenterAvailable]];
    
    
     
    
    
    return sharedHelper;
}

-(id) init {
    if ((self = [super init]))
    {
        adAvailable = YES;
        gamePaused = NO;
        
        gameCenterFeaturesAvailable = [self isGameCenterAvailable];
        
        if(gameCenterFeaturesAvailable)
        {
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            
            [nc addObserver:self
                   selector:@selector(authenticationChanged)
                       name: GKPlayerAuthenticationDidChangeNotificationName
                     object:nil];
        }
    }
    return self;
}

-(void) authenticationChanged{
    
    if([GKLocalPlayer localPlayer].isAuthenticated && !isPlayerAuthenticated){
        NSLog(@" PLAYER AUTH - YES ");
        isPlayerAuthenticated = YES;
    }
    else if(![GKLocalPlayer localPlayer].isAuthenticated && isPlayerAuthenticated){
        NSLog(@" PLAYER AUTH - NO ");
        isPlayerAuthenticated = NO;
    }
}


@synthesize adView;
@synthesize game, gameWindow, gameViewController, gameCenterFeaturesAvailable, isPlayerAuthenticated, delegate;
@synthesize lastError; 
@synthesize adAvailable;
@synthesize gamePaused;


//
// iAd ADVERTISING
//
- (void) showAdvertisment:(ADInterstitialAd*) interstitialAd
{
    
    
    [interstitialAd setDelegate:self];
    delegate = self;
    
    if(adAvailable && interstitialAd && UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        if(interstitialAd.loaded)
        {
            //[gameWindow.gameViewController.view setAutoresizesSubviews:YES];
            
            
            if( [self sysVerCheck:@"6.0"] )
            {
                NSLog(@" SYSTEM VERSION < 6.0");
                
                // PRESENTING MODALLY - ON TOP OF MY GAME - LANDSCAPE
                [interstitialAd presentFromViewController:gameViewController];  // deprecated in iOs 7
                gamePaused = YES;
            }
            else
            {
                NSLog(@" SYSTEM VERSION > 6.0");
                
                // PRESENTING NON-MODALLY - AS SUBVIEW - PORTRAIT
                
                int _index = 0; // layer depth. 0 = on current view, 1 = bellow it
                CGRect interstitialFrame = gameWindow.gameViewController.view.bounds;
                interstitialFrame.origin = CGPointMake(interstitialFrame.size.width * _index, 0);
                adView = [[UIView alloc] initWithFrame:interstitialFrame];
                
                [gameWindow.gameViewController.view addSubview:adView];
                
                [interstitialAd presentInView:adView];
                
                
                
                gamePaused = YES;
            
            }
        }
        else
        {
            NSLog(@" AD NOT LOADED ");
        }
    }
}

- (BOOL) interstitialAdActionShouldBegin:(ADInterstitialAd *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"Interstitial ad is beginning an ad action");
    
    if (!willLeave && adAvailable)
    {
        // insert code here to suspend any services that might conflict with the advertisement
        
        // NO NEED TO, THE GAME IS ALREADY PAUSED

        return YES;
    }
    
    return NO;
    
    //return NO; //allow ad to run
}

- (void) interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd
{
    adAvailable = YES;
    
    if( interstitialAd != nil ){
    
    
    /*
        UIView* _adPlaceholderView = [[UIView alloc] initWithFrame:gameViewController.view.bounds];
        [gameViewController.view addSubview:_adPlaceholderView];
        [interstitialAd presentInView:_adPlaceholderView];
    */
    }
    
}

- (void) interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd
{
    //NSLog(@" AD RELEASED ");
    NSLog(@" realease not available in ARC mode ");
    //[interstitial release];
}

- (void) interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    NSLog(@"interstitialAd <%@> recieved error <%@>", interstitialAd, error);
    NSLog(@" realease not available in ARC mode ");
    //[interstitialAd release];
}

- (void) interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd
{
    NSLog(@" AD FINISHED - USER STOPPED PLAYING WITH IT");
    // restore any services paused by your app
    
    
    gamePaused = NO;
    
    [adView removeFromSuperview];
    
}


//
// TapForTap Ad
//
- (void) tapForTapShowBanner
{
    
    bannerAd = [TFTBanner bannerWithFrame:CGRectMake(0, (gameViewController.gameView.frame.size.height - 50),  gameViewController.gameView.frame.size.width, 50) delegate:nil];
    
    [gameWindow.gameViewController.view addSubview:bannerAd];
}

- (void) tapForTapShowInterstitialBreak
{

    [TFTInterstitial loadBreakInterstitialWithCallbackOnReceivedAd:^(TFTInterstitial *interstitial) {
        [interstitial showWithViewController:gameViewController];
    } onAdDidFail:^(TFTInterstitial *interstitial, NSString *reason) {
        NSLog(@"Ad failed: %@", reason);
    } onAdDidShow:nil onAdWasTapped:nil onAdWasDismissed:nil];
     
}

- (void) tapForTapCloseBanner
{

    [bannerAd removeFromSuperview];

}

//
// PLAYER
//
-(BOOL) isPlayerAuthenticated{
    
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    return localPlayer.isAuthenticated;
}

-(void) authenticateLocalPlayer{
    
    NSLog(@"-------------");
    NSLog(@" AUTHENTICATE PLAYER ");
    NSLog(@"-------------");
    
    
    delegate = self;
    
    
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    if(localPlayer.authenticated == NO)
    {
        
        if( [self sysVerCheck:@"6.0"] )
        {
            
            NSLog(@" iOS < 6.0");
            
            // iOS 5.x and less
            [localPlayer authenticateWithCompletionHandler:^(NSError *error){
                [self checkLocalPlayer];
            }];
            
            gameCenterFeaturesAvailable = YES;
            
        }
        else // iOS 6 and up
        {
            
            NSLog(@" SYSTEM VERSION > 6.0");
            
            [localPlayer setAuthenticateHandler:^(UIViewController *viewController, NSError *error)
            {
                if (viewController != nil)
                {
                    // DISPLAY LOGIN WINDOW
                    [gameWindow.gameViewController presentViewController:viewController animated:YES completion:nil];
                    NSLog(@" DISPLAY LOGIN WINDOW ");
                    
                    gamePaused = YES;
                    
                
                    
                }
                else if(error)
                {
                    // DISABLE GAMECENTER
                    gameCenterFeaturesAvailable = NO;
                    NSLog(@" ERROR - GAMECENTER FEAUTERS = OFF ");
                    
                    gamePaused = NO;
                    
                    
                    /*
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Note" message:@"You are not loged in. Login to gamecenter to submit score" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                    */
                }
                else
                {
                    NSLog(@" WELCOME BACK ");
                    gamePaused = NO;
                    
                    NSLog(@" unknown error in gameKitHelper -> authenticate player ");
                    NSLog(@" gamecenter probably closed 3times so apple cancels stuff");
                }
            }];
            
            NSLog(@"gcFeatures = %@", gameCenterFeaturesAvailable?@"YES":@"NO" );
            NSLog(@"playerAuth = %@", isPlayerAuthenticated?@"YES":@"NO" );
            if(!gameCenterFeaturesAvailable || !isPlayerAuthenticated)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Note" message:@"Please login to gamecenter." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
            if(isPlayerAuthenticated)
            {
                gamePaused = NO;
            }
            
            
        }
    }
    else{
        // player already authenticated
        NSLog(@" PLAYER ALREADY LOGGED IN ");
        gamePaused = NO;
    }


}

-(void) checkLocalPlayer{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    if( localPlayer.isAuthenticated){
        //NSLog(@" LOCAL CHECK AUTH - YES ");
    }
    else{
        //NSLog(@" LOCAL CHECK AUTH - NO ");
    }
}

-(void) onLocalPlayerAuthenticationChanged{
    if ([delegate respondsToSelector:@selector(onLocalPlayerAuthenticationChanged)])
    {
        [delegate onLocalPlayerAuthenticationChanged];
    }
}

-(void) showGameCenter{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.gameCenterDelegate = self;
        [gameViewController presentViewController: gameCenterController animated: YES completion:nil];
    }
}



//
// LEADERBOARD
//
-(void) showLeaderboard: (NSString*) leaderboardID{
    
    
    if( !gameCenterFeaturesAvailable ) return;
    
    
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil)
    {
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gameCenterController.gameCenterDelegate = self;
        gameCenterController.leaderboardIdentifier = leaderboardID;
        
        [gameViewController presentViewController:gameCenterController animated:YES completion:nil];
        
    }
}

-(void) gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:^{}];
    
   // NSLog(@" YES ");
}






//
// SCORES
//
-(void) reportScore:(int)score forLeaderboardID:(NSString*)identifier{
    
    if( !gameCenterFeaturesAvailable ) return;

    
    NSLog(@" SUBMIT SCORE ");
    NSLog(@"%@",identifier);
    NSLog(@"%d",score);
    NSLog(@"-------------");
    
    GKScore * GCscore = [[GKScore alloc] initWithLeaderboardIdentifier:identifier];
    GCscore.value = score; // has to be set, see GKScore class reference
    
    NSNumber *theScore = [[NSNumber alloc]initWithInt:score];
    NSArray *scores = [[NSArray alloc] initWithObjects:theScore, nil];
    
    

    [GKScore reportScores:scores withCompletionHandler:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            if (error == NULL) {
                NSLog(@"Score Sent = %d", score);
            }
            else {
                NSLog(@"Score Failed, %@",[error localizedDescription]);
            }
        });
    }];

    
    
    
    
    
    
}

-(int) retrieveBestScoreForLeaderboard:(NSString*)identifier{
    
    
    
    if(isPlayerAuthenticated)
    {
        GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc] init];
        if (leaderboardRequest != nil)
        {
            leaderboardRequest.playerScope = GKLeaderboardPlayerScopeGlobal;
            leaderboardRequest.timeScope = GKLeaderboardTimeScopeAllTime;
            leaderboardRequest.identifier = identifier;
            leaderboardRequest.range = NSMakeRange(1,1);
            [leaderboardRequest loadScoresWithCompletionHandler: ^(NSArray *scores, NSError *error) {
                if (error != nil)
                {
                    // Handle the error.
                    NSLog(@"ERROR RETRIEVING SCORES");
                }
                if (scores != nil)
                {
                    // Process the score information.
                    NSLog(@"SCORE RETRIEVED SUCCESS");
                }
            }];
            
            if (leaderboardRequest.scores != nil){
                NSLog(@" NumOfscores = %d", leaderboardRequest.scores.count);
                
                return [leaderboardRequest.scores objectAtIndex:0];
            }
        }
    }
    
    return nil;
}



//
// HELP
//
-(BOOL) isGameCenterAvailable{
    Class gcClass = (NSClassFromString((@"GKLocalPlayer")));
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare: reqSysVer
                                           options:NSNumericSearch] != NSOrderedAscending);
    return (gcClass && osVersionSupported);
}

-(BOOL) sysVerCheck:(NSString*)version{
    return [[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending;
}

-(void) setLastError:(NSError*)error{
    lastError = error.copy;
    if (lastError != nil){
        NSLog(@"GameKitHelper ERROR: %@", [lastError userInfo].description);
    }
}


@end
