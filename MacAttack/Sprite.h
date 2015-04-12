//
//  MyClass.h
//  XniGame
//
//  Created by snowman on 10/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import "Namespace.XniGame.classes.h"


@interface Sprite : NSObject {
	Texture2D *texture;
	Rectangle *sourceRectangle;
	Vector2 *origin;
    
    float Size;
}

@property (nonatomic, retain) Texture2D *texture;
@property (nonatomic, retain) Rectangle *sourceRectangle;
@property (nonatomic, retain) Vector2 *origin;

@property (nonatomic) float Size;





@end
