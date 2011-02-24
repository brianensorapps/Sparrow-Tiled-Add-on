//
//  STMap+Viewport.h
//  SparrowTiled
//
//  Created by Shilo White on 2/22/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "STMap.h"

@interface STMap (viewport)
- (void)centerViewToX:(float)x y:(float)y;
- (void)centerViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds;
- (void)centerViewToTile:(STTile *)tile;
- (void)centerViewToTile:(STTile *)tile inBounds:(BOOL)inBounds;
- (void)panViewByX:(float)x y:(float)y;
- (void)panViewByX:(float)x y:(float)y inBounds:(BOOL)inBounds;
- (void)scrollViewToX:(float)x y:(float)y;
- (void)scrollViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds;
- (void)scrollViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds time:(float)time;
- (void)scrollViewToX:(float)x y:(float)y inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition;
- (void)scrollViewByX:(float)x y:(float)y;
- (void)scrollViewByX:(float)x y:(float)y inBounds:(BOOL)inBounds;
- (void)scrollViewByX:(float)x y:(float)y inBounds:(BOOL)inBounds time:(float)time;
- (void)scrollViewByX:(float)x y:(float)y inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition;
- (void)scrollViewToTile:(STTile *)tile;
- (void)scrollViewToTile:(STTile *)tile inBounds:(BOOL)inBounds;
- (void)scrollViewToTile:(STTile *)tile inBounds:(BOOL)inBounds time:(float)time;
- (void)scrollViewToTile:(STTile *)tile inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition;
- (void)zoomViewToRate:(float)rate;
- (void)zoomViewToRate:(float)rate inBounds:(BOOL)inBounds;
- (void)zoomViewByRate:(float)rate;
- (void)zoomViewByRate:(float)rate inBounds:(BOOL)inBounds;
- (void)zoomTweenViewToRate:(float)rate;
- (void)zoomTweenViewToRate:(float)rate inBounds:(BOOL)inBounds;
- (void)zoomTweenViewToRate:(float)rate inBounds:(BOOL)inBounds time:(float)time;
- (void)zoomTweenViewToRate:(float)rate inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition;
- (void)zoomTweenViewByRate:(float)rate;
- (void)zoomTweenViewByRate:(float)rate inBounds:(BOOL)inBounds;
- (void)zoomTweenViewByRate:(float)rate inBounds:(BOOL)inBounds time:(float)time;
- (void)zoomTweenViewByRate:(float)rate inBounds:(BOOL)inBounds time:(float)time transition:(NSString *)transition;
@end
