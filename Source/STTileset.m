//
//  STTileset.m
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "STTileset.h"
#import "SPTexture.h"
#import "SPRectangle.h"

@interface STTileset ()
- (void)setRegions;
- (SPTexture *)textureWithContentsOfFile:(NSString *)filename transparentColor:(NSString *)transparentColor width:(int)width height:(int)height;
@end

@implementation STTileset

@synthesize name = mName;
@synthesize filename = mFilename;
@synthesize firstGID = mFirstGID;
@synthesize tileWidth = mTileWidth;
@synthesize tileHeight = mTileHeight;
@synthesize spacing = mSpacing;
@synthesize margin = mMargin;
@synthesize transparentColor = mTransparentColor;
@synthesize width = mWidth;
@synthesize height = mHeight;

- (id)initWithFile:(NSString *)filename name:(NSString *)name firstGID:(int)firstGID tileWidth:(int)tileWidth tileHeight:(int)tileHeight spacing:(int)spacing margin:(int)margin transparentColor:(NSString *)transparentColor width:(int)width height:(int)height {
	if (self = [super initWithTexture:[self textureWithContentsOfFile:filename transparentColor:transparentColor width:width height:height]]) {
		mFilename = filename;
		mName = name;
		mFirstGID = firstGID;
		mTileWidth = tileWidth;
		mTileHeight = tileHeight;
		mSpacing = spacing;
		mMargin = margin;
		mTransparentColor = transparentColor;
		mWidth = width;
		mHeight = height;
		
		[self setRegions];
	}
	return self;
}

- (SPTexture *)textureWithContentsOfFile:(NSString *)filename transparentColor:(NSString *)transparentColor width:(int)width height:(int)height {
	if (transparentColor) {
		uint transColor;
		[[NSScanner scannerWithString:transparentColor] scanHexInt:&transColor];
		uint red = (((transColor) >> 16) & 0xff);
		uint green = (((transColor) >> 8) & 0xff);
		uint blue = ((transColor) & 0xff);
		
		return [SPTexture textureWithWidth:width height:height
			draw:^(CGContextRef context) {
				CGImageRef imageRef = [UIImage imageNamed:filename].CGImage;
				float maskingColors[6] = {red, red, green, green, blue, blue};
				CGImageRef maskedImage = CGImageCreateWithMaskingColors(imageRef, maskingColors);
				CGContextTranslateCTM(context, 0, height);
				CGContextScaleCTM(context, 1.0, -1.0);
				CGContextDrawImage(context, CGRectMake(0, 0, width, height), maskedImage);
			}];
	} else {
		return [SPTexture textureWithContentsOfFile:filename];
	}
}

- (void)setRegions {
	int i = mFirstGID;
	for (int y=mSpacing; y+mTileHeight+mMargin<=mHeight; y+=mTileHeight+mMargin) {
		for (int x=mSpacing; x+mTileWidth+mMargin<=mWidth; x+=mTileWidth+mMargin) {
			SPRectangle *region = [SPRectangle rectangleWithX:x y:y width:mTileWidth height:mTileHeight];
			[self addRegion:region withName:[NSString stringWithFormat:@"%i", i++]];
		}
	}
}

- (SPTexture *)textureByGID:(int)gid {
	return [self textureByName:[NSString stringWithFormat:@"%i", gid]];
}

- (void)dealloc {
	[super dealloc];
}
@end
