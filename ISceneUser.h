//
//  ISceneUser.h
//  Express
//
//  Created by Matej Jan on 23.11.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Namespace.XniGame.classes.h"

@protocol ISceneUser <NSObject>

@property (nonatomic, retain) id<IScene> scene;

@optional
- (void) addedToScene:(id<IScene>)scene;
- (void) removedFromScene:(id<IScene>)scene;

@end
