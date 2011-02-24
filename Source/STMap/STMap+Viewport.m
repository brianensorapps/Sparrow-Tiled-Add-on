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
#import "STLayer.h"
#import "SPImage.h"

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

- (void)zoomViewToRate:(float)rate {
	[self zoomViewToRate:rate inBounds:NO];
}

- (void)zoomViewToRate:(float)rate inBounds:(BOOL)inBounds {
	for (id key in mLayers) {
		[[mLayers objectForKey:key] zoomViewToRate:rate inBounds:inBounds];
	}
}

- (void)zoomViewByRate:(float)rate {
	[self zoomViewByRate:rate inBounds:NO];
}

- (void)zoomViewByRate:(float)rate inBounds:(BOOL)inBounds {
	for (id key in mLayers) {
		[[mLayers objectForKey:key] zoomViewByRate:rate inBounds:inBounds];
	}
}

- (void)setZoom:(float)zoom {
	[self zoomViewToRate:zoom];
}

- (float)zoom {
	id key = [[mLayers allKeys] objectAtIndex:0];
	if (key) {
		STLayer *layer = (STLayer *)[mLayers objectForKey:key];
		return layer.image.scaleX;
	} else {
		return 0;
	}
}

- (void)zoomTweenViewToRate:(float)rate {
	[self zoomTweenViewToRate:rate inBounds:NO time:0.5f transition:@"linear"];
}

- (void)zoomTweenViewToRate:(float)rate inBounds:(BOOL)inBounds {
	[self zoomTweenViewToRate:rate inBounds:inBounds time:0.5f transition:@"linear"];
}

- (void)zoomTweenViewToRate:(float)rate inBounds:(BOOL)inBounds time:(float)time {
	[self zoomTweenViewToRate:rate inBounds:inBounds time:time transition:@"linear"];
}

- (void)zoomTweenViewToRate:(float)rate inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition {
	for (id key in mLayers) {
		[[mLayers objectForKey:key] zoomTweenViewToRate:rate inBounds:inBounds time:time transition:transition];
	}
}

- (void)zoomTweenViewByRate:(float)rate {
	[self zoomTweenViewByRate:rate inBounds:NO time:0.5f transition:@"linear"];
}

- (void)zoomTweenViewByRate:(float)rate inBounds:(BOOL)inBounds {
	[self zoomTweenViewByRate:rate inBounds:inBounds time:0.5f transition:@"linear"];
}

- (void)zoomTweenViewByRate:(float)rate inBounds:(BOOL)inBounds time:(float)time {
	[self zoomTweenViewByRate:rate inBounds:inBounds time:time transition:@"linear"];
}

- (void)zoomTweenViewByRate:(float)rate inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition {
	for (id key in mLayers) {
		[[mLayers objectForKey:key] zoomTweenViewByRate:rate inBounds:inBounds time:time transition:transition];
	}
}
@end
