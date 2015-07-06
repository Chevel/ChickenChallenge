//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Namespace.XniGame.classes.h"


#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Content.h"
#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Input.Touch.h"


@protocol IKillable




// VARIABLES
@property (nonatomic, retain) Vector2 *position;
@property (readwrite) BOOL dead;
@property (readwrite) BOOL zombie;


// METHODS
- (BOOL) containsVector:(Vector2 *) touchPoz;

- (void) reincarnation;

- (void) updateWithGameTime:(GameTime *)gameTime;



@end
