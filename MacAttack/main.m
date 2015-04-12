//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Retronator.Xni.Framework.h"

int main(int argc, char *argv[])
{
    [GameHost load];
    
    int retVal = UIApplicationMain(argc, argv, @"GameHost", @"Igra");
    
    return retVal;
}
