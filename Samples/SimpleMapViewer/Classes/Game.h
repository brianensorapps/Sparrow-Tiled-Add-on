//
//  Game.h
//  Sparrow
//
//  Created by Shilo White on 1/13/11.
//  Copyright 2011 Shilocity Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"
#import "SparrowTiled.h"
#import "Screen.h"

@interface Game : SPStage {
	Screen *mScreen;
	STMap *mMap;
	STLayer *mTopLayer;
	STLayer *mBottomLayer;
}

- (void)load;

@end
