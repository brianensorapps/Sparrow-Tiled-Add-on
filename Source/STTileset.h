//
//  STTileset.h
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "SPTextureAtlas.h"
@class SPTexture;

@interface STTileset : SPTextureAtlas {
	NSString *mName;
	NSString *mFilename;
	int mFirstGID;
	int mTileWidth;
	int mTileHeight;
	int mSpacing;
	int mMargin;
	NSString *mTransparentColor;
	int mWidth;
	int mHeight;
}

@property (nonatomic, assign, readonly) NSString *name;
@property (nonatomic, assign, readonly) NSString *filename;
@property (nonatomic, assign, readonly) int firstGID;
@property (nonatomic, assign, readonly) int tileWidth;
@property (nonatomic, assign, readonly) int tileHeight;
@property (nonatomic, assign, readonly) int spacing;
@property (nonatomic, assign, readonly) int margin;
@property (nonatomic, assign, readonly) NSString *transparentColor;
@property (nonatomic, assign, readonly) int width;
@property (nonatomic, assign, readonly) int height;

- (id)initWithFile:(NSString *)filename name:(NSString *)name firstGID:(int)firstGID tileWidth:(int)tileWidth tileHeight:(int)tileHeight spacing:(int)spacing margin:(int)margin transparentColor:(NSString *)transparentColor width:(int)width height:(int)height;
- (id)initWithFile:(NSString *)filename texture:(SPTexture)texture name:(NSString *)name firstGID:(int)firstGID tileWidth:(int)tileWidth tileHeight:(int)tileHeight spacing:(int)spacing margin:(int)margin transparentColor:(NSString *)transparentColor width:(int)width height:(int)height;
- (SPTexture *)textureByGID:(int)gid;
@end
