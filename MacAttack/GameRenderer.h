//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "Namespace.XniGame.classes.h"

#import "Retronator.Xni.Framework.h"


@class AnimatedSprite;

@interface GameRenderer : DrawableGameComponent{
    
    // RESOURCES
	ContentManager *content;
    Vector2 *centre;
    Matrix *camera;
    
    // ANIMATIONS STORAGE
    PowerUpContent *powerUps;
    AnimationContent *animations;
    
    
    SpriteBatch *spriteBatch; // to draw sprites
    
	// OBJECTS
    Sprite *airplaneSprite;
	Sprite *chickenSprite;
    Sprite *unicornSprite;
    Sprite *alienSprite;
    Sprite *appleLogoSprite;
    Sprite *powerUpSprite;
    Sprite *eggCrackedSprite;
    Sprite *eggCrackedEasterSprite;
        // ANIMATED WING
    Sprite *eggAnimation;
    
    Texture2D *background;
    
    // ENDLESS BACKGROUND
    Texture2D *image1;
    
    
    Texture2D *powerUpTexture;
    
    // TEXT
    SpriteFont *retrotype;
    Label *instructionsL1;
    Label *instructionsL2;

    SpriteBatch *wingSpriteBatch;

    
    // EASTER EGG
    AnimatedSprite *easterSpriteAnimation;
    
    
    // ANIMATED BACKGROUND
    AnimatedSprite *backgroundSpriteAnimation;
    Texture2D *animeBackground;
    
    
    int acrossScreen;
    
    
    // OTHER
    Sprite *back;
    Vector2 *drawRect; //background position
    
	// LEVEL
	Level *level; // This is the level we will be rendering.
    
    
    // IGRA
    Igra *igra;
    
    // TIMER
    NSTimeInterval startTime, introStart;
    NSTimeInterval currentTime, nowTime;
    Boolean msg1,msg2,msg3;
    
    NSTimeInterval startDeath;
    BOOL deathAnimationStart;
    
    Enemy* temp;
    
    float imagePoz;
}

@property float imagePoz;

@property BOOL deathAnimationStart;

@property (weak) Enemy* enemyTemp;

@property (strong) AnimationContent *animations;
@property (strong) PowerUpContent *powerUps;

@property (nonatomic, readonly) Matrix *camera;
@property int acrossScreen;

- (id) initWithGame:(Game *)theGame level:(Level *)theLevel;

- (void) reUpdateProgress:(int)value;







@end
