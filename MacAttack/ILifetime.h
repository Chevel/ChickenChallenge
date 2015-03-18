//
//  ILifetime.h
//  Express
//
//  Created by Matej Jan on 27.10.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "Express.Scene.Objects.classes.h" // ORIGINAL
#import "Namespace.XniGame.h" // TEST


@protocol ILifetime <NSObject>

@property (nonatomic, retain) Lifetime *lifetime;

@end
