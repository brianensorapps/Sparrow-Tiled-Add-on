//
//  STLayer.h
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "SPSprite.h"
@class STTileset;
@class STTile;
@class SPImage;
@class SPRenderTexture;

@interface STLayer : SPSprite {
	NSString *mLayerName;
	int mWidth;
	int mHeight;
	int mTileWidth;
	int mTileHeight;
	int mPixelWidth;
	int mPixelHeight;
	NSMutableArray *mTiles;
	SPImage *mImage;
	SPRenderTexture *mRenderTexture;
}

@property (nonatomic, assign, readonly) NSString *name;
@property (nonatomic, assign, readonly) int width;
@property (nonatomic, assign, readonly) int height;
@property (nonatomic, assign, readonly) int tileWidth;
@property (nonatomic, assign, readonly) int tileHeight;
@property (nonatomic, assign, readonly) int pixelWidth;
@property (nonatomic, assign, readonly) int pixelHeight;
@property (nonatomic, assign, readonly) NSMutableArray *tiles;
@property (nonatomic, assign, readonly) float trueRotation;
@property (nonatomic, assign, readonly) float viewWidth;
@property (nonatomic, assign, readonly) float viewHeight;
@property (nonatomic, assign, readonly) SPImage *image;
@property (nonatomic, assign) float zoom;

- (id)initWithName:(NSString *)name width:(int)width height:(int)height gids:(NSMutableArray *)gids tileset:(STTileset *)tileset;
- (STTile *)tileAtIndex:(int)index;
- (STTile *)tileAtX:(int)x y:(int)y;
@end
