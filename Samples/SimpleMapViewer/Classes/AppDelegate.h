//
//  AppDelegate.h
//  Sparrow
//
//  Created by Shilo White on 1/13/11.
//  Copyright 2011 Shilocity Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sparrow.h"

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	SPView *sparrowView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SPView *sparrowView;

@end

