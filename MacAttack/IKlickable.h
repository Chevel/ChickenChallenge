//
//  IKlickable.h
//  MacAttack
//
//  Created by snowman on 11/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Namespace.XniGame.classes.h"


#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Input.Touch.h"

@protocol IKlickable <NSObject>


//KLICKABLE
@property (nonatomic, retain) Vector2 *position;

@property float rotation;



//KILLABLE
@property Boolean dead;
@property int life;

- (BOOL) containsVector:(Vector2 *) touchPoz;

- (BOOL) isDead;

- (void) minusLife;

- (void) updateRotation;

- (void) moveCloser; //to je treba popravt tko da bo rat imel protokol kjer se lahko premika, torej killable, movable
//medtem ko powerUp pa ne sme imeti movable

- (BOOL) atCenter;

@end
