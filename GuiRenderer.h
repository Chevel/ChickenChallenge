//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import <Foundation/Foundation.h>

#import "Retronator.Xni.Framework.h"

#import "Namespace.XniGame.classes.h"

@interface GuiRenderer : DrawableGameComponent {
	SpriteBatch *spriteBatch;
    
    SpriteFont *crkopis;
    
	id<IScene> scene;
    
    Matrix *camera;

}

@property (nonatomic, readonly) Matrix *camera;

- (id) initWithGame:(Game*)theGame scene:(id<IScene>)theScene;

@end
