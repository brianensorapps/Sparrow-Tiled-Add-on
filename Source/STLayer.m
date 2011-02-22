//
//  STLayer.m
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "STLayer.h"
#import "STTileset.h"
#import "STTile.h"
#import "SPTexture.h"
#import "SPImage.h"
#import "SPRenderTexture.h"
#import "SPTween.h"
#import "SPStage.h"

@interface STLayer ()
- (void)loadTileWithGID:(int)gid tileset:(STTileset *)tileset index:(int)i;
- (void)loadLayer;
@end

@implementation STLayer

@synthesize name = mLayerName;
@synthesize width = mWidth;
@synthesize height = mHeight;
@synthesize tileWidth = mTileWidth;
@synthesize tileHeight = mTileHeight;
@synthesize pixelWidth = mPixelWidth;
@synthesize pixelHeight = mPixelHeight;
@synthesize tiles = mTiles;

- (id)initWithName:(NSString *)name width:(int)width height:(int)height gids:(NSMutableArray *)gids tileset:(STTileset *)tileset {
	if (self = [super init]) {
		mLayerName = name;
		mWidth = width;
		mHeight = height;
		mTileWidth = tileset.tileWidth;
		mTileHeight = tileset.tileHeight;
		mPixelWidth = mWidth * mTileWidth;
		mPixelHeight = mHeight * mTileHeight;
		
		int i;
		mTiles = [[NSMutableArray alloc] initWithCapacity:10];
		mRenderTexture = [[SPRenderTexture alloc] initWithWidth:mWidth*mTileWidth height:mHeight*mTileHeight];
		for (NSNumber *gid in gids) {
			[self loadTileWithGID:[gid intValue] tileset:tileset index:i++];
		}
		
		[self loadLayer];
	}
	return self;
}

- (void)loadTileWithGID:(int)gid tileset:(STTileset *)tileset index:(int)i {
	SPTexture *texture;
	if (gid >= tileset.firstGID) {
		texture = [tileset textureByGID:gid];
	} else {
		texture = [SPTexture textureWithWidth:tileset.tileWidth height:tileset.tileHeight draw:nil];
	}
	STTile *tile = [[STTile alloc] initWithGID:gid texture:texture];
	[mTiles addObject:tile];
	
	int y = (int)(i/mHeight);
	tile.y = y*mTileHeight;
	int x = i-(y*mHeight);
	tile.x = x*mTileWidth;
	
	if (gid >= tileset.firstGID) [mRenderTexture drawObject:tile];
	[tile release];
}

- (void)loadLayer {
	mImage = [[SPImage alloc] initWithTexture:mRenderTexture];
	[self addChild:mImage];
	[mRenderTexture release];
	[mImage release];
}

- (STTile *)tileAtIndex:(int)index {
	return [mTiles objectAtIndex:index];
}

- (STTile *)tileAtX:(int)x y:(int)y {
	int i = (y*mWidth)+x;
	return [mTiles objectAtIndex:i];
}

//------------- add the view methods into a viewport class -------------//
- (void)centerViewToX:(float)x y:(float)y {
	[self centerViewToX:x y:y inBounds:YES];
}

- (void)centerViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds {
	//FOR BRIAN
	//CHANGE 480 AND 320 TO SCREEN SIZE BASED ON DEVICE AND ORIENTATION
	//YOU ROCK
	float screenWidth = 480;
	float screenHeight = 320;
	float screenCenterX = screenWidth/2;
	float screenCenterY = screenHeight/2;
	
	if (inBounds) {
		x = MAX(x, screenCenterX);
		y = MAX(y, screenCenterY);
		x = MIN(x, mPixelWidth - screenCenterX);
		y = MIN(y, mPixelHeight - screenCenterY);
	}
	
	self.x = -x + screenCenterX;
	self.y = -y + screenCenterY;
}

- (void)centerViewToTile:(STTile *)tile {
	[self centerViewToTile:tile inBounds:YES];
}

- (void)centerViewToTile:(STTile *)tile inBounds:(BOOL)inBounds {
	[self centerViewToX:tile.x+tile.width/2 y:tile.y+tile.height/2 inBounds:inBounds];
}

- (void)panViewByX:(float)x y:(float)y {
	[self panViewByX:x y:y inBounds:YES];
}

- (void)panViewByX:(float)x y:(float)y inBounds:(BOOL)inBounds {
	//FOR BRIAN
	//CHANGE 480 AND 320 TO SCREEN SIZE BASED ON DEVICE AND ORIENTATION
	//YOU ROCK
	float screenWidth = 480;
	float screenHeight = 320;
	
	x = self.x - x;
	y = self.y - y;
	if (inBounds) {
		x = MIN(x, 0);
		y = MIN(y, 0);
		x = MAX(x, -mPixelWidth + screenWidth);
		y = MAX(y, -mPixelHeight + screenHeight);
	}
	
	self.x = x;
	self.y = y;
}

- (void)scrollViewToX:(float)x y:(float)y {
	[self scrollViewToX:x y:y inBounds:YES time:0.5f transition:SP_TRANSITION_LINEAR];
}

- (void)scrollViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds {
	[self scrollViewToX:x y:y inBounds:inBounds time:0.5f transition:SP_TRANSITION_LINEAR];
}

- (void)scrollViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds time:(float)time {
	[self scrollViewToX:x y:y inBounds:inBounds time:time transition:SP_TRANSITION_LINEAR];
}

- (void)scrollViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition {
	//FOR BRIAN
	//CHANGE 480 AND 320 TO SCREEN SIZE BASED ON DEVICE AND ORIENTATION
	//YOU ROCK
	float screenWidth = 480;
	float screenHeight = 320;
	float screenCenterX = screenWidth/2;
	float screenCenterY = screenHeight/2;
	
	if (inBounds) {
		x = MAX(x, screenCenterX);
		y = MAX(y, screenCenterY);
		x = MIN(x, mPixelWidth - screenCenterX);
		y = MIN(y, mPixelHeight - screenCenterY);
	}
	
	SPTween *tween = [SPTween tweenWithTarget:self time:time transition:transition];
	[tween animateProperty:@"x" targetValue:-x+screenCenterX];
	[tween animateProperty:@"y" targetValue:-y+screenCenterY];
	[self.stage.juggler addObject:tween];
}

- (void)scrollViewToTile:(STTile *)tile {
	[self scrollViewToTile:tile inBounds:YES time:0.5f transition:SP_TRANSITION_LINEAR];
}

- (void)scrollViewToTile:(STTile *)tile inBounds:(BOOL)inBounds {
	[self scrollViewToTile:tile inBounds:inBounds time:0.5f transition:SP_TRANSITION_LINEAR];
}

- (void)scrollViewToTile:(STTile *)tile inBounds:(BOOL)inBounds time:(float)time {
	[self scrollViewToTile:tile inBounds:inBounds time:time transition:SP_TRANSITION_LINEAR];
}

- (void)scrollViewToTile:(STTile *)tile inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition {
	[self scrollViewToX:tile.x+tile.width/2 y:tile.y+tile.height/2 inBounds:inBounds time:time transition:transition];
}

- (void)dealloc {
	[mTiles release];
	[super dealloc];
}
@end
