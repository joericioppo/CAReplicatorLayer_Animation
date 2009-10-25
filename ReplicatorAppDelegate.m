//
//  ReplicatorAppDelegate.m
//  Replicator
//
//  Created by test on 10/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ReplicatorAppDelegate.h"

@implementation ReplicatorAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application 
}


-(BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
    return YES;
}

@end
