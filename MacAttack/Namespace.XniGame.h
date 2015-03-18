//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


// iRate
#import "iRate.h"


// Protocols
#import "IPosition.h"
#import "IKillable.h"
#import "IMovable.h"
#import "IPowerUp.h"
#import "ITouchable.h"

// Enemies objects
#import "Rat.h"
#import "Unicorn.h"
#import "Enemy.h"
#import "Airplane.h"
#import "Alien.h"

#import "Random.h"
#import "ILifetime.h"

// GAME CENTER
#import "GameKitHelper.h"

// POWER-UP
#import "PowerUpContent.h"

#import "PowerUp.h"
#import "PowerUpFactory.h"
#import "GoldenEggPowerUp.h"
#import "SlowedPowerUp.h"
#import "DeadPowerUp.h"


// Levels
#import "Level.h"
#import "Level1.h"

// Game
#import "Igra.h"
#import "Gameplay.h"

// Scene
#import "Scene.h"

// Graphics
#import "AnimationType.h"
#import "AnimationContent.h"
#import "Sprite.h"
#import "AnimatedSprite.h"
#import "AnimatedSpriteFrame.h"
#import "DrawableGameComponent.h"
#import "GameComponent.h"
#import "GraphicsDevice.h"
#import "GameRenderer.h"

// AREA
#import "Rectangle+Extensions.h"

// Retronator
#import "Retronator.Xni.Framework.h"
#import "Retronator.Xni.Framework.Audio.h"
#import "Retronator.Xni.Framework.Graphics.classes.h"
/*
#import "XNI/Classes/Retronator/Xni/Framework/GameWindow.h"
#import "XNI/Classes/Retronator/Xni/Framework/GameViewController.h"
#import "XNI/Classes/Retronator/Xni/Framework/GameView.h"
*/

#import "GameWindow.h"
#import "GameViewController.h"
#import "GameView.h"


//GUI
#import "GuiRenderer.h"
#import "SpriteFont.h"
#import "Button.h"
#import "IScene.h"
#import "Label.h"
#import "GameState.h"
#import "Menu.h"
#import "MirageEnums.h"
#import "ISceneUser.h"
#import "Image.h"
#import "TouchPanelHelper.h"
#import "MainMenu.h"
#import "DeviceNFO.h"

// HUD, MENU
#import "FontTextureProcessor.h"
#import "About.h"
#import "Options.h"
#import "GameHud.h"
#import "GameOver.h"

// SOUND
#import "SoundEngine.h"

