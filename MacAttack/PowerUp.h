//
//  PowerUp.h
//  MacAttack
//
//  Created by snowman on 11/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Namespace.XniGame.classes.h"

#import "Retronator.Xni.Framework.h"


#import "PowerUpType.h"
#import "Lifetime.h"

@interface PowerUp : GameComponent <ILifetime, IKillable, IMovable, IPowerUp, ITouchable>

@property CGRect hitArea;
@property float width;
@property float height;
@property Rectangle *inputArea;
@property Matrix *inverseView;
@property NSTimeInterval duration; // how long the powerup stays active

@property BOOL activated;
@property BOOL dead;
@property (nonatomic) Vector2 *position;
@property float rotation;
@property (nonatomic, strong) Lifetime *lifetime;
@property (nonatomic) PowerUpType type;
@property BOOL zombie;
@property BOOL visible;
@property float size;


- (id) initWithType:(PowerUpType)theType;
- (id) initWithType:(PowerUpType)theType duration:(NSTimeInterval)theDuration;
- (void) setCamera:(Matrix *)camera;
- (void) deactivate;
- (void) updateWithGameTime:(GameTime *)gameTime;






@end
