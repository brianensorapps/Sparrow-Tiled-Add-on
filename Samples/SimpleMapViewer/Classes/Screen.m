//
//  Screen.m
//  Sparrow
//
//  Created by Shilo White on 1/13/11.
//  Copyright 2011 Shilocity Productions. All rights reserved.
//

#import "Screen.h"

@implementation Screen

@synthesize showFrameRate = mShowFrameRate;

- (id)init {
	if (self = [super init]) {
		[self load];
    }    
    return self;
}

- (void)load {
	mWidth = 480;
	mHeight = 320;
	
	[self setLandscapeRight];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}

- (void)onOrientationChange:(NSNotification *)notification {
	UIInterfaceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
	
	if (deviceOrientation == UIInterfaceOrientationLandscapeRight) {
		[self setLandscapeRight];
	} else if (deviceOrientation == UIInterfaceOrientationLandscapeLeft) {
		[self setLandscapeLeft];
	}
}

- (void)setLandscapeRight {
	[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;
	
	float orientation = SP_D2R(90);
	if (self.rotation == orientation) return;
	
	self.rotation = orientation;
	self.x = mHeight;
	self.y = 0;
}

- (void)setLandscapeLeft {	
	[UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeLeft;
	
	float orientation = SP_D2R(-90);
	if (self.rotation == orientation) return;
	
	self.rotation = orientation;
	self.x = 0;
	self.y = mWidth;
}

- (void)setShowFrameRate:(BOOL)showFrameRate {
	if (showFrameRate != mShowFrameRate) {
		mShowFrameRate = showFrameRate;
		
		if (mShowFrameRate) {
			mFrameRateText = [SPTextField textFieldWithWidth:55 height:15 text:@"FPS: 60"];
			mFrameRateText.hAlign = SPHAlignLeft;
			mFrameRateText.vAlign = SPVAlignBottom;
			mFrameRateText.color = 0xffffff;
			//mFrameRateText.shadow = YES;
			mFrameRateText.x = 5;
			mFrameRateText.y = 5;
			mFrameRateText.touchable = NO;
			[self addChild:mFrameRateText];
			[mFrameRateText addEventListener:@selector(displayFrameRate:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
		} else {
			[mFrameRateText removeEventListener:@selector(displayFrameRate:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
			[self removeChild:mFrameRateText];
		}
	}
}

- (void)displayFrameRate:(SPEnterFrameEvent *)event {
	mFrameRateCount++;
	mTimeCount += event.passedTime;
	if (mTimeCount >= 1.0f) {
		mFrameRateText.text = [NSString stringWithFormat:@"FPS: %i", mFrameRateCount];
		mFrameRateCount = 0;
		mTimeCount -= 1.0f;
	}
	
	if ([self childIndex:mFrameRateText] != self.numChildren-1) [self addChild:mFrameRateText];
}

+ (Screen *)screen {
	return [[[Screen alloc] init] autorelease];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	if (mShowFrameRate) mShowFrameRate = NO;
	[super dealloc];
}
@end
