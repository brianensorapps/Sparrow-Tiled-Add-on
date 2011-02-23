//
//  Game.m
//  Sparrow
//
//  Created by Shilo White on 1/13/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//

#import "Game.h"

@implementation Game
- (id)initWithWidth:(float)width height:(float)height {
	if (self = [super initWithWidth:width height:height]) {
		self.stage.frameRate = 60;
		mScreen = [Screen screen];
		mScreen.showFrameRate = YES;
		[self addChild:mScreen];
		[self load];
    }
    return self;
}

- (void)load {
	mMap = [[STMap alloc] initWithTMXFile:@"sewers.tmx"];
	mTopLayer = [mMap layerByName:@"top"];
	mBottomLayer = [mMap layerByName:@"bottom"];
	
	[mScreen addChild:mBottomLayer];
	[mScreen addChild:mTopLayer];
	
	[self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
}

- (void)onTouch:(SPTouchEvent *)event {
	SPTouch *move = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] anyObject];
	SPTouch *touchUp = [[event touchesWithTarget:mTopLayer andPhase:SPTouchPhaseEnded] anyObject];
	
	if (move) {
		mIsPanning = YES;
		SPPoint *moveLocation = [move locationInSpace:mScreen];
		SPPoint *movePrevLocation = [move previousLocationInSpace:mScreen];
		
		float distX = moveLocation.x - movePrevLocation.x;
		float distY = moveLocation.y - movePrevLocation.y;
		
		[mMap panViewByX:-distX y:-distY];
	}
	
	if (touchUp) {
		if (mIsPanning) { mIsPanning = NO; return; }
		
		SPPoint *touchUpPosition = [touchUp locationInSpace:mBottomLayer];
		[mMap scrollViewToX:touchUpPosition.x y:touchUpPosition.y];
	}
}

- (void)dealloc {
	[self removeEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
	[self removeAllChildren];
	[mMap release];
	[super dealloc];
}
@end
