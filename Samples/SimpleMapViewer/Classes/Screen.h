//
//  Screen.h
//  Sparrow
//
//  Created by Shilo White on 1/13/11.
//  Copyright 2011 Shilocity Productions. All rights reserved.
//

#import "Sparrow.h"

@interface Screen : SPSprite {
	SPTextField *mFrameRateText;
	BOOL mShowFrameRate;
	int mFrameRateCount;
	double mTimeCount;
	int mWidth;
	int mHeight;
}

@property (nonatomic, assign) BOOL showFrameRate;

- (void)load;
- (void)setLandscapeRight;
- (void)setLandscapeLeft;

+ (Screen *)screen;

@end
