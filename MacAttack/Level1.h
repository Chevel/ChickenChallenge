//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "Namespace.XniGame.classes.h"



@interface Level1 : Level{
    Vector2 *toCenter;
    Vector2 *toRat;
    
    int minFactor;
    int maxFactor;
	int numOfEnemies;
    
    Rat *rat1, *rat2, *rat3, *rat4, *rat5, *rat6, *rat7, *rat8;
    Unicorn *u1,*u2,*u3, *u4, *u5, *u6;
    Airplane *a1, *a2, *a3, *a4, *a5, *a6;
    Alien *ufo1, *ufo2;
}

@property Rat *rat1, *rat2, *rat3, *rat4, *rat5, *rat6, *rat7, *rat8;
@property Unicorn *u1, *u2, *u3, *u4, *u5, *u6;
@property Airplane *a1, *a2, *a3, *a4, *a5, *a6;
@property Alien *ufo1, *ufo2;
@property (readonly) PowerUp *p1, *p2;




- (void) updateLVL:(int)stage;


@end
