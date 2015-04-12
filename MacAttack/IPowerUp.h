//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

@protocol IPowerUp

#import "PowerUpType.h"


// VARIABLES
@property Boolean activated;
@property Boolean visible;
@property int size;



// METHODS

- (void) activate;

- (PowerUpType) getType;

- (BOOL) isActivated;

- (void) reincarnation;

- (void) updateWithGameTime:(GameTime *)gameTime;



@end
