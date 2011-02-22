//
//  STLayer.m
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions. All rights reserved.
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
@synthesize tiles = mTiles;

- (id)initWithName:(NSString *)name width:(int)width height:(int)height gids:(NSMutableArray *)gids tileset:(STTileset *)tileset {
	if (self = [super init]) {
		mLayerName = name;
		mWidth = width;
		mHeight = height;
		mTileWidth = tileset.tileWidth;
		mTileHeight = tileset.tileHeight;
		
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
	SPTexture *texture = nil;
	if (gid >= tileset.firstGID) {
		texture = [tileset textureByGID:gid];
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

- (void)centerViewToX:(float)x y:(float)y {
	NSLog(@"x:%f y:%f", x, y);
	self.x = -x + (480/2);
	self.y = -y + (320/2);
}

- (void)centerViewToTile:(STTile *)tile {
	self.x = -(tile.x-tile.width/2) + (480/2);
	self.y = -(tile.y-tile.height/2) + (320/2);
}

- (void)dealloc {
	[mTiles release];
	[super dealloc];
}
@end