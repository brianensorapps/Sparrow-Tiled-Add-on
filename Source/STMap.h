//
//  STMap.h
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
@class STTileset;
@class STLayer;

@interface STMap : NSObject {
	NSString *mFilename;
	NSString *mVersion;
	NSString *mOrientation;
	int mWidth;
	int mHeight;
	int mTileWidth;
	int mTileHeight;
	int mPixelWidth;
	int mPixelHeight;
	STTileset *mTileset;
	NSMutableDictionary *mLayers;
}

@property (nonatomic, assign, readonly) NSString *filename;
@property (nonatomic, assign, readonly) NSString *version;
@property (nonatomic, assign, readonly) NSString *orientation;
@property (nonatomic, assign, readonly) int width;
@property (nonatomic, assign, readonly) int height;
@property (nonatomic, assign, readonly) int tileWidth;
@property (nonatomic, assign, readonly) int tileHeight;
@property (nonatomic, assign, readonly) int pixelWidth;
@property (nonatomic, assign, readonly) int pixelHeight;
@property (nonatomic, assign, readonly) STTileset *tileset;
@property (nonatomic, assign, readonly) NSMutableDictionary *layers;

- (id)initWithTMXFile:(NSString *)filename;
+ (STMap *)mapWithTMXFile:(NSString *)filename;
- (STLayer *)layerByName:(NSString *)name;
@end
