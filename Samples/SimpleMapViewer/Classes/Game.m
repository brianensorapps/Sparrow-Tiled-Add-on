//
//  Game.m
//  Sparrow
//
//  Created by Shilo White on 1/13/11.
//  Copyright 2011 Shilocity Productions. All rights reserved.
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
	mTopLayer = [mMap layerByName:@"Top"];
	mBottomLayer = [mMap layerByName:@"bottom"];
	
	[mScreen addChild:mBottomLayer];
	[mScreen addChild:mTopLayer];
	[self addEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
	
	[SPStage setDefaultOrigin:0.5];
	
	SHLine *line = [SHLine lineWithLength:10];
	line.x = 480/2;
	line.y = 320/2;
	[mScreen addChild:line];
	
	SHLine *line2 = [SHLine lineWithLength:10];
	line2.x = 480/2;
	line2.y = 320/2;
	line2.rotation = SP_D2R(90);
	[mScreen addChild:line2];
	
	[SPStage setDefaultOrigin:0];
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
		
		mBottomLayer.x = mTopLayer.x += distX;
		mBottomLayer.y = mTopLayer.y += distY;

		if (mBottomLayer.x > 0) mBottomLayer.x = mTopLayer.x = 0;
		else if (mBottomLayer.x + (mMap.width*mMap.tileWidth) < 480) mBottomLayer.x = mTopLayer.x = 480 - (mMap.width*mMap.tileWidth);
		if (mBottomLayer.y > 0) mBottomLayer.y = mTopLayer.y = 0;
		else if (mBottomLayer.y + (mMap.height*mMap.tileHeight) < 320) mBottomLayer.y = mTopLayer.y = 320 - (mMap.height*mMap.tileHeight);
	}
	
	if (touchUp) {
		if (mIsPanning) { mIsPanning = NO; return; }
		
		SPPoint *touchUpPosition = [touchUp locationInSpace:mTopLayer];
		[mTopLayer centerViewToX:touchUpPosition.x y:touchUpPosition.y];
		[mBottomLayer centerViewToX:touchUpPosition.x y:touchUpPosition.y];
		[mTopLayer centerViewToTile:[mTopLayer tileAtX:5 y:5]];
		[mBottomLayer centerViewToTile:[mTopLayer tileAtX:5 y:5]];
	}
}

- (void)dealloc {
	[self removeEventListener:@selector(onTouch:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
	[self removeAllChildren];
	[mMap release];
	[super dealloc];
}
@end
