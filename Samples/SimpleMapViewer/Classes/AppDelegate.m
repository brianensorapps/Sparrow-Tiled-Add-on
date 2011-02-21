//
//  AppDelegate.m
//  Sparrow
//
//  Created by Shilo White on 1/13/11.
//  Copyright 2011 Shilocity Productions. All rights reserved.
//

#import "AppDelegate.h"
#import "Game.h"

@implementation AppDelegate

@synthesize window;
@synthesize sparrowView;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    SP_CREATE_POOL(pool);
	
    [SPStage setSupportHighResolutions:YES];
    [SPAudioEngine start];
	
	Game *game = [Game alloc];
    sparrowView.stage = game;
	game = [game init];
    [game release];
	
    [window makeKeyAndVisible];
    [sparrowView start];
	
    SP_RELEASE_POOL(pool);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [sparrowView stop];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [sparrowView start];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[sparrowView.stage release];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)dealloc {
	[sparrowView release];
    [window release];
    [super dealloc];
}


@end
