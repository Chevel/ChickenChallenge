//
//  Created by snowman
//  Copyright 2015. All rights reserved.
//


#import "Namespace.XniGame.h"



/*
 contains all the objects that are createdi in level
 */
@implementation Scene



- (id) initWithGame:(Game *)theGame
{
	self = [super initWithGame:theGame];
	if (self != nil) {
		items = [[NSMutableArray alloc] init];
		
	}
	return self;
}


- (id)init{
    self = [super init];
    if (self != nil) {
        items = [[NSMutableArray alloc] init];
    }
    return self;
}



@synthesize itemAdded, itemRemoved;


- (int) updateOrder {return super.updateOrder;}
- (void) setUpdateOrder:(int)value {super.updateOrder = value;}
- (Event*) updateOrderChanged {return super.updateOrderChanged;}

- (BOOL) enabled {return super.enabled;}
- (void) setEnabled:(BOOL)value {super.enabled = value;}
- (Event*) enabledChanged {return super.enabledChanged;}



- (void) addItem:(id)item {
	[items addObject:item];
}

- (void) removeItem:(id)item {
	[items removeObject:item];
}

- (void) clear {
	[items removeAllObjects];
}



- (NSUInteger) countByEnumeratingWithState:(NSFastEnumerationState *)state 
                                   objects:(__unsafe_unretained id *)stackbuf
                                     count:(NSUInteger)len
{
    return [items countByEnumeratingWithState:state objects: stackbuf count:len];
}


@end
