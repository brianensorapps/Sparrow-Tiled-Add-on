//
//  STMap+Viewport.m
//  SparrowTiled
//
//  Created by Shilo White on 2/22/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "STMap+Viewport.h"

@implementation STMap (viewport)
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

- (void)scrollViewByX:(float)x y:(float)y {
	[self scrollViewByX:x y:y inBounds:YES time:0.5f transition:@"linear"];
}

- (void)scrollViewByX:(float)x y:(float)y inBounds:(BOOL)inBounds {
	[self scrollViewByX:x y:y inBounds:inBounds time:0.5f transition:@"linear"];
}

- (void)scrollViewByX:(float)x y:(float)y inBounds:(BOOL)inBounds time:(float)time {
	[self scrollViewByX:x y:y inBounds:inBounds time:time transition:@"linear"];
}

- (void)scrollViewByX:(float)x y:(float)y inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition {
	for (id key in mLayers) {
		[[mLayers objectForKey:key] scrollViewByX:x y:y inBounds:inBounds time:time transition:transition];
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

@end
