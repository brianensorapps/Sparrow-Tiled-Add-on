//
//  STTile.h
//  SparrowTiled
//
//  Created by Shilo White on 2/19/11.
//  Copyright 2011 Shilocity Productions. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "SPImage.h"
@class SPTexture;

@interface STTile : SPImage {
	int mGID;
}

@property (nonatomic, assign, readonly) int gid;

- (id)initWithGID:(int)gid texture:(SPTexture *)texture;
@end
