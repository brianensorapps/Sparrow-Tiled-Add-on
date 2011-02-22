//
//  STTile.m
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions & Brian Ensor Apps. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import "STTile.h"
#import "SPTexture.h"

@implementation STTile

@synthesize gid = mGID;

- (id)initWithGID:(int)gid texture:(SPTexture *)texture {
	if (self = [super initWithTexture:texture]) {
		mGID = gid;
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
}
@end
