//
//  STLayer+Viewport.m
//  SparrowTiled
//
//  Created by Shilo White on 2/22/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "STLayer+Viewport.h"
#import "STTile.h"
#import "SPTween.h"
#import "SPStage.h"
#import "SPJuggler.h"

@implementation STLayer (viewport)
- (void)centerViewToX:(float)x y:(float)y {
	[self centerViewToX:x y:y inBounds:YES];
}

- (void)centerViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds {
	float screenCenterX = self.viewWidth/2;
	float screenCenterY = self.viewHeight/2;
	
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
	x = self.x - x;
	y = self.y - y;
	if (inBounds) {
		x = MIN(x, 0);
		y = MIN(y, 0);
		x = MAX(x, -mPixelWidth + self.viewWidth);
		y = MAX(y, -mPixelHeight + self.viewHeight);
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
	float screenCenterX = self.viewWidth/2;
	float screenCenterY = self.viewHeight/2;
	
	if (inBounds) {
		x = MAX(x, screenCenterX);
		y = MAX(y, screenCenterY);
		x = MIN(x, mPixelWidth - screenCenterX);
		y = MIN(y, mPixelHeight - screenCenterY);
	}
	
	[self.stage.juggler removeTweensWithTarget:self];
	SPTween *tween = [SPTween tweenWithTarget:self time:time transition:transition];
	[tween animateProperty:@"x" targetValue:-x+screenCenterX];
	[tween animateProperty:@"y" targetValue:-y+screenCenterY];
	[self.stage.juggler addObject:tween];
}

- (void)scrollViewByX:(float)x y:(float)y {
	[self scrollViewByX:x y:y inBounds:YES time:0.5f transition:SP_TRANSITION_LINEAR];
}

- (void)scrollViewByX:(float)x y:(float)y inBounds:(BOOL)inBounds {
	[self scrollViewByX:x y:y inBounds:inBounds time:0.5f transition:SP_TRANSITION_LINEAR];
}

- (void)scrollViewByX:(float)x y:(float)y inBounds:(BOOL)inBounds time:(float)time {
	[self scrollViewByX:x y:y inBounds:inBounds time:time transition:SP_TRANSITION_LINEAR];
}

- (void)scrollViewByX:(float)x y:(float)y inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition {
	float screenCenterX = self.viewWidth/2;
	float screenCenterY = self.viewHeight/2;
	x = -self.x+x+screenCenterX;
	y = -self.y+y+screenCenterY;
	[self scrollViewToX:x y:y inBounds:inBounds time:time transition:transition];
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
@end
