//
//  AppController.h
//  Replicator
//
//  Created by test on 10/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuartzCore/QuartzCore.h>

@interface AppController : NSObject {

	IBOutlet NSView *view;

	CALayer *rootLayer;
	CALayer *sublayerOne;
	CALayer *sublayerTwo;
	
	CAReplicatorLayer *replicatorNorth;
	CAReplicatorLayer *replicatorEast;
	CAReplicatorLayer *replicatorSouth;
	CAReplicatorLayer *replicatorWest;
}

- (void)animateIn;
- (void)rollAnimation;
- (void)zoomIn;
- (void)createNorthQuad;
- (void)createSouthQuad;
- (void)centerX;
- (void)centerY;
- (void)spreadX;
- (void)spreadY;
- (void)rotateCameraAngle;
- (void)animateTopOut;
- (void)animateBottomOut;
- (void)reverseAnimationTopOut;
- (void)reverseAnimationBottomOut;

@end
