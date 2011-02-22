//
//  STMap.m
//  SparrowTiledTest
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#define ST_EXC_FILE_NOT_FOUND @"FileNotFoundOrInvalid"
#define ST_EXC_ELEMENT_NOT_FOUND @"ElementNotFound"

#import "STMap.h"
#import "TBXML.h"
#import "NSDataAdditions.h"
#import "SPTexture.h"
#import "STTileset.h"
#import "STLayer.h"
#import "STTile.h"

@interface STMap ()
- (void)loadXMLFile:(NSString *)filename;
- (void)parseXMLData:(TBXML *)xml;
- (void)setMapProperties:(TBXMLElement *)mapElement;
- (void)loadTileset:(TBXMLElement *)tilesetElement;
- (void)loadLayer:(TBXMLElement *)layerElement;
- (void)raiseXMLError:(NSString *)error message:(NSString *)message;
@end

@implementation STMap

@synthesize filename = mFilename;
@synthesize version = mVersion;
@synthesize orientation = mOrientation;
@synthesize width = mWidth;
@synthesize height = mHeight;
@synthesize tileWidth = mTileWidth;
@synthesize tileHeight = mTileHeight;
@synthesize pixelWidth = mPixelWidth;
@synthesize pixelHeight = mPixelHeight;
@synthesize tileset = mTileset;
@synthesize layers = mLayers;

- (id)initWithTMXFile:(NSString *)filename {
	if (self = [super init]) {
		mFilename = filename;
		
		[self loadXMLFile:filename];
	}
	return self;
}

+ (STMap *)mapWithTMXFile:(NSString *)filename {
	return [[[STMap alloc]initWithTMXFile:filename] autorelease];
}

- (void)loadXMLFile:(NSString *)filename {
	TBXML *xml = [[TBXML alloc] initWithXMLFile:filename];
	[self parseXMLData:xml];
	[xml release];
}

- (void)parseXMLData:(TBXML *)xml {
	TBXMLElement *mapElement = xml.rootXMLElement;
	if (!mapElement) [self raiseXMLError:ST_EXC_FILE_NOT_FOUND message:@"file doesn't exist or is unreadable"];
	
	[self setMapProperties:mapElement];
	
	TBXMLElement *tilesetElement = [TBXML childElementNamed:@"tileset" parentElement:mapElement];
	if (!tilesetElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"tileset\" element doesn't exist"];
	[self loadTileset:tilesetElement];
	
	TBXMLElement *layerElement = [TBXML childElementNamed:@"layer" parentElement:mapElement];
	if (!layerElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"layer\" element doesn't exist"];
	mLayers = [[NSMutableDictionary alloc] initWithCapacity:1];
	while (layerElement) {
		[self loadLayer:layerElement];
		layerElement = [TBXML nextSiblingNamed:@"layer" searchFromElement:layerElement];
	}
}

- (void)setMapProperties:(TBXMLElement *)mapElement {
	mVersion = [TBXML valueOfAttributeNamed:@"version" forElement:mapElement];
	mOrientation = [TBXML valueOfAttributeNamed:@"orientation" forElement:mapElement];
	mWidth = [[TBXML valueOfAttributeNamed:@"width" forElement:mapElement] intValue];
	mHeight = [[TBXML valueOfAttributeNamed:@"height" forElement:mapElement] intValue];
	mTileWidth = [[TBXML valueOfAttributeNamed:@"tilewidth" forElement:mapElement] intValue];
	mTileHeight = [[TBXML valueOfAttributeNamed:@"tileheight" forElement:mapElement] intValue];
	mPixelWidth = mWidth * mTileWidth;
	mPixelHeight = mHeight * mTileHeight;
	
	if (![mOrientation isEqualToString:@"orthogonal"]) [self raiseXMLError:@"OrientationNotSupported" message:[NSString stringWithFormat:@"orientation \"%@\" not supported yet", mOrientation]];
}

- (void)loadTileset:(TBXMLElement *)tilesetElement {
	TBXMLElement *imageElement = [TBXML childElementNamed:@"image" parentElement:tilesetElement];
	if (!imageElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"image\" element doesn't exist"];
	
	NSString *filename = [TBXML valueOfAttributeNamed:@"source" forElement:imageElement];
	NSString *name = [TBXML valueOfAttributeNamed:@"name" forElement:tilesetElement];
	int firstGID = [[TBXML valueOfAttributeNamed:@"firstgid" forElement:tilesetElement] intValue];
	int tileWidth = [[TBXML valueOfAttributeNamed:@"tilewidth" forElement:tilesetElement] intValue];
	int tileHeight = [[TBXML valueOfAttributeNamed:@"tileheight" forElement:tilesetElement] intValue];
	int spacing = [[TBXML valueOfAttributeNamed:@"spacing" forElement:tilesetElement] intValue];
	int margin = [[TBXML valueOfAttributeNamed:@"margin" forElement:tilesetElement] intValue];
	NSString *transparentColor = [TBXML valueOfAttributeNamed:@"trans" forElement:imageElement];
	int width = [[TBXML valueOfAttributeNamed:@"width" forElement:imageElement] intValue];
	int height = [[TBXML valueOfAttributeNamed:@"height" forElement:imageElement] intValue];
	
	NSString *trans = [@"0x" stringByAppendingString:[TBXML valueOfAttributeNamed:@"trans" forElement:imageElement]];
	NSScanner *scanner = [NSScanner scannerWithString:trans];
	unsigned int baseColor1;
	[scanner scanHexInt:&baseColor1]; 
	CGFloat red   = ((baseColor1 & 0xFF0000) >> 16);
	CGFloat green = ((baseColor1 & 0x00FF00) >>  8);
	CGFloat blue  =  (baseColor1 & 0x0000FF);
	if (trans) {
		SPTexture *transparentTexture = [[SPTexture alloc] initWithWidth:width height:height
																	draw:^(CGContextRef context) {
																		CGImageRef image = [[UIImage imageNamed:filename] CGImage];
																		const float myMaskingColors[6] = {red, red, green, green, blue, blue};
																		CGImageRef myMaskedImage = CGImageCreateWithMaskingColors(image, myMaskingColors);
																		CGContextTranslateCTM(context, 0, height);
																		CGContextScaleCTM(context, 1.0, -1.0);
																		CGContextDrawImage (context, CGRectMake(0, 0, width, height), myMaskedImage);
																	}];
		mTileset = [[STTileset alloc] initWithFile:filename texture:transparentTexture name:name firstGID:firstGID tileWidth:tileWidth tileHeight:tileHeight spacing:spacing margin:margin transparentColor:transparentColor width:width height:height];
		[transparentTexture release];
	}
	else {
		mTileset = [[STTileset alloc] initWithFile:filename name:name firstGID:firstGID tileWidth:tileWidth tileHeight:tileHeight spacing:spacing margin:margin transparentColor:transparentColor width:width height:height];
	}
}

- (void)loadTileset:(TBXMLElement *)tilesetElement {
	TBXMLElement *imageElement = [TBXML childElementNamed:@"image" parentElement:tilesetElement];
	if (!imageElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"image\" element doesn't exist"];
	
	NSString *filename = [TBXML valueOfAttributeNamed:@"source" forElement:imageElement];
	NSString *name = [TBXML valueOfAttributeNamed:@"name" forElement:tilesetElement];
	int firstGID = [[TBXML valueOfAttributeNamed:@"firstgid" forElement:tilesetElement] intValue];
	int tileWidth = [[TBXML valueOfAttributeNamed:@"tilewidth" forElement:tilesetElement] intValue];
	int tileHeight = [[TBXML valueOfAttributeNamed:@"tileheight" forElement:tilesetElement] intValue];
	int spacing = [[TBXML valueOfAttributeNamed:@"spacing" forElement:tilesetElement] intValue];
	int margin = [[TBXML valueOfAttributeNamed:@"margin" forElement:tilesetElement] intValue];
	NSString *transparentColor = [TBXML valueOfAttributeNamed:@"trans" forElement:imageElement];
	int width = [[TBXML valueOfAttributeNamed:@"width" forElement:imageElement] intValue];
	int height = [[TBXML valueOfAttributeNamed:@"height" forElement:imageElement] intValue];
	
	NSString *trans = [@"0x" stringByAppendingString:[TBXML valueOfAttributeNamed:@"trans" forElement:imageElement]];
	NSScanner *scanner = [NSScanner scannerWithString:trans];
	unsigned int baseColor1;
	[scanner scanHexInt:&baseColor1]; 
	CGFloat red   = ((baseColor1 & 0xFF0000) >> 16);
	CGFloat green = ((baseColor1 & 0x00FF00) >>  8);
	CGFloat blue  =  (baseColor1 & 0x0000FF);
	if (trans) {
		SPTexture *transparentTexture = [[SPTexture alloc] initWithWidth:width height:height
																	draw:^(CGContextRef context) {
																		CGImageRef image = [[UIImage imageNamed:filename] CGImage];
																		const float myMaskingColors[6] = {red, red, green, green, blue, blue};
																		CGImageRef myMaskedImage = CGImageCreateWithMaskingColors(image, myMaskingColors);
																		CGContextTranslateCTM(context, 0, height);
																		CGContextScaleCTM(context, 1.0, -1.0);
																		CGContextDrawImage (context, CGRectMake(0, 0, width, height), myMaskedImage);
																	}];
		mTileset = [[STTileset alloc] initWithTexture:transparentTexture name:name firstGID:firstGID tileWidth:tileWidth tileHeight:tileHeight spacing:spacing margin:margin transparentColor:transparentColor width:width height:height];
		[transparentTexture release];
	}
	else {
		mTileset = [[STTileset alloc] initWithFile:filename name:name firstGID:firstGID tileWidth:tileWidth tileHeight:tileHeight spacing:spacing margin:margin transparentColor:transparentColor width:width height:height];
	}
}

- (void)loadLayer:(TBXMLElement *)layerElement {
	NSString *name = [TBXML valueOfAttributeNamed:@"name" forElement:layerElement];
	int width = [[TBXML valueOfAttributeNamed:@"width" forElement:layerElement] intValue];
	int height = [[TBXML valueOfAttributeNamed:@"height" forElement:layerElement] intValue];
	
	TBXMLElement *dataElement = [TBXML childElementNamed:@"data" parentElement:layerElement];
	if (!dataElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"data\" element doesn't exist"];
	TBXMLElement *tileElement = [TBXML childElementNamed:@"tile" parentElement:dataElement];
	if (!tileElement) [self raiseXMLError:ST_EXC_ELEMENT_NOT_FOUND message:@"\"tile\" element doesn't exist"];
	NSMutableArray *tileGIDS = [NSMutableArray arrayWithCapacity:10];
	while (tileElement) {
		NSNumber *tileGID = [NSNumber numberWithInt:[[TBXML valueOfAttributeNamed:@"gid" forElement:tileElement] intValue]];
		[tileGIDS addObject:tileGID];
		tileElement = [TBXML nextSiblingNamed:@"tile" searchFromElement:tileElement];
	}
	
	STLayer *layer = [[STLayer alloc] initWithName:name width:width height:height gids:tileGIDS tileset:mTileset];
	[mLayers setObject:layer forKey:[name lowercaseString]];
	[layer release];
}

- (STLayer *)layerByName:(NSString *)name {
	name = [name lowercaseString];
	return [mLayers objectForKey:name];
}

- (void)centerViewToX:(float)x y:(float)y {
	[self centerViewToX:x y:y inBounds:YES];
}

- (void)centerViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds {
	for (id key in mLayers) {
		[[mLayers objectForKey:key] centerViewToX:x y:y inBounds:inBounds];
	}
}

- (void)centerViewToTile:(STTile *)tile {
	[self centerViewToTile:tile inBounds:YES];
}

- (void)centerViewToTile:(STTile *)tile inBounds:(BOOL)inBounds {
	for (id key in mLayers) {
		[[mLayers objectForKey:key] centerViewToTile:tile inBounds:inBounds];
	}
}

- (void)panViewByX:(float)x y:(float)y {
	[self panViewByX:x y:y inBounds:YES];
}

- (void)panViewByX:(float)x y:(float)y inBounds:(BOOL)inBounds {
	for (id key in mLayers) {
		[[mLayers objectForKey:key] panViewByX:x y:y inBounds:inBounds];
	}
}

- (void)scrollViewToX:(float)x y:(float)y {
	[self scrollViewToX:x y:y inBounds:YES time:0.5f transition:@"linear"];
}

- (void)scrollViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds {
	[self scrollViewToX:x y:y inBounds:inBounds time:0.5f transition:@"linear"];
}

- (void)scrollViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds time:(float)time {
	[self scrollViewToX:x y:y inBounds:inBounds time:time transition:@"linear"];
}

- (void)scrollViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition {
	for (id key in mLayers) {
		[[mLayers objectForKey:key] scrollViewToX:x y:y inBounds:inBounds time:time transition:transition];
	}
}

- (void)scrollViewToTile:(STTile *)tile {
	[self scrollViewToTile:tile inBounds:YES time:0.5f transition:@"linear"];
}

- (void)scrollViewToTile:(STTile *)tile inBounds:(BOOL)inBounds {
	[self scrollViewToTile:tile inBounds:inBounds time:0.5f transition:@"linear"];
}

- (void)scrollViewToTile:(STTile *)tile inBounds:(BOOL)inBounds time:(float)time {
	[self scrollViewToTile:tile inBounds:inBounds time:time transition:@"linear"];
}

- (void)scrollViewToTile:(STTile *)tile inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition {
	for (id key in mLayers) {
		[[mLayers objectForKey:key] scrollViewToTile:tile inBounds:inBounds time:time transition:transition];
	}
}

- (void)raiseXMLError:(NSString *)error message:(NSString *)message {
	[NSException raise:error format:[NSString stringWithFormat:@"Error while reading \"%@\", %@.", mFilename, message], NSStringFromSelector(_cmd)];
}

- (void)dealloc {
	[mLayers release];
	[mTileset release];
	[super dealloc];
}
@end
