//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Retronator.Xni.Framework.Content.h"

#import "Namespace.XniGame.classes.h"

#import "Retronator.Xni.Framework.h" 
#import "iRate.h"

@interface GameHud : GameComponent <iRateDelegate> {
    
    // RESOURCES
    ContentManager *content;
    Scene *scene;
    Igra *igra;
    Matrix *camera;
    
    // HUD
    Label *playerScore;
    Label *bestScore;
    
    // GAME OVER
    Label *title;
    Label *unlocked;
    Button *restartGame;
    Button *submit;
    Button *resetGame;
    
    Button *facebookBtn;
    Button *twitterBtn;
    Button *ratingBtn;
    Button *backMenu;
    
    
}

@property (nonatomic, readonly) id<IScene> scene;
@property (nonatomic, readonly) Matrix *camera;


@end
