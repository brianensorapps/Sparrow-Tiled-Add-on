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
#import "SPEnterFrameEvent.h"

@implementation STLayer (viewport)
- (void)centerViewToX:(float)x y:(float)y {
	[self centerViewToX:x y:y inBounds:YES];
}

- (void)centerViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds {
	x *= self.zoom;
	y *= self.zoom;
	float screenCenterX = self.viewWidth/2;
	float screenCenterY = self.viewHeight/2;
	
	if (inBounds) {
		x = MAX(x, screenCenterX);
		y = MAX(y, screenCenterY);
		x = MIN(x, (mPixelWidth*self.zoom) - screenCenterX);
		y = MIN(y, (mPixelHeight*self.zoom) - screenCenterY);
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
	x = self.x - (x*self.zoom);
	y = self.y - (y*self.zoom);
	if (inBounds) {
		x = MIN(x, 0);
		y = MIN(y, 0);
		x = MAX(x, -(mPixelWidth*self.zoom) + self.viewWidth);
		y = MAX(y, -(mPixelHeight*self.zoom) + self.viewHeight);
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
	x *= self.zoom;
	y *= self.zoom;
	float screenCenterX = self.viewWidth/2;
	float screenCenterY = self.viewHeight/2;
	
	if (inBounds) {
		x = MAX(x, screenCenterX);
		y = MAX(y, screenCenterY);
		x = MIN(x, (mPixelWidth*self.zoom) - screenCenterX);
		y = MIN(y, (mPixelHeight*self.zoom) - screenCenterY);
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

- (void)zoomViewToRate:(float)rate {
	[self zoomViewToRate:rate inBounds:NO];
}

- (void)zoomViewToRate:(float)rate inBounds:(BOOL)inBounds {
	float screenCenterX = self.viewWidth/2;
	float screenCenterY = self.viewHeight/2;
	float centerX = (-self.x + screenCenterX)/self.zoom;
	float centerY = (-self.y + screenCenterY)/self.zoom;
	
	self.image.scaleX = self.image.scaleY = rate;
	[self centerViewToX:centerX y:centerY inBounds:inBounds];
}


- (void)zoomViewByRate:(float)rate {
	[self zoomViewByRate:rate inBounds:NO];
}

- (void)zoomViewByRate:(float)rate inBounds:(BOOL)inBounds {
	rate += self.image.scaleX;
	[self zoomViewToRate:rate inBounds:inBounds];
}

- (void)setZoom:(float)zoom {
	[self zoomViewToRate:zoom];
}

- (float)zoom {
	return self.image.scaleX;
}

- (void)zoomTweenViewToRate:(float)rate {
	[self zoomTweenViewToRate:rate inBounds:NO time:0.5f transition:SP_TRANSITION_LINEAR];
}

- (void)zoomTweenViewToRate:(float)rate inBounds:(BOOL)inBounds {
	[self zoomTweenViewToRate:rate inBounds:inBounds time:0.5f transition:SP_TRANSITION_LINEAR];
}

- (void)zoomTweenViewToRate:(float)rate inBounds:(BOOL)inBounds time:(float)time {
	[self zoomTweenViewToRate:rate inBounds:inBounds time:time transition:SP_TRANSITION_LINEAR];
}

- (void)zoomTweenViewToRate:(float)rate inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition {
	if (self.zoom == rate) return;
	float screenCenterX = self.viewWidth/2;
	float screenCenterY = self.viewHeight/2;
	float centerX = (-self.x + screenCenterX);
	float centerY = (-self.y + screenCenterY);
	
	[self.stage.juggler removeTweensWithTarget:self.image];
	SPTween *tween = [SPTween tweenWithTarget:self.image time:time transition:transition];
	[tween animateProperty:@"scaleX" targetValue:rate];
	[tween animateProperty:@"scaleY" targetValue:rate];
	
	[self scrollViewToX:centerX y:centerY inBounds:inBounds time:time transition:transition];
	[self.stage.juggler addObject:tween];
}

- (void)zoomTweenViewByRate:(float)rate {
	[self zoomTweenViewByRate:rate inBounds:NO time:0.5f transition:SP_TRANSITION_LINEAR];
}

- (void)zoomTweenViewByRate:(float)rate inBounds:(BOOL)inBounds {
	[self zoomTweenViewByRate:rate inBounds:inBounds time:0.5f transition:SP_TRANSITION_LINEAR];
}

- (void)zoomTweenViewByRate:(float)rate inBounds:(BOOL)inBounds time:(float)time {
	[self zoomTweenViewByRate:rate inBounds:inBounds time:time transition:SP_TRANSITION_LINEAR];
}

- (void)zoomTweenViewByRate:(float)rate inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition {
	rate += self.image.scaleX;
	[self zoomTweenViewToRate:rate inBounds:inBounds time:time transition:transition];
}
@end
