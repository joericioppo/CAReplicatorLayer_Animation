//
//  AppController.m
//  Replicator
//
//  Created by test on 10/17/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"

#define X_TIME_DELAY (1.0)
#define Y_TIME_DELAY (1.5)


@implementation AppController

- (void)awakeFromNib
{

	//Root Layer
	rootLayer = [CALayer layer];
	
	CGColorRef	color = CGColorCreateGenericRGB(0.0, 0.0, 0.0, 1.0);
	rootLayer.backgroundColor = color;
	CGColorRelease(color);


	//Replicator Layer
	replicatorEast	= [CAReplicatorLayer layer];
	replicatorNorth = [CAReplicatorLayer layer];
	replicatorSouth = [CAReplicatorLayer layer];
	replicatorWest	= [CAReplicatorLayer layer];
		
	replicatorEast.frame = CGRectMake(0, 0, 50, 50);
	replicatorWest.frame = CGRectMake(0, 0, 50, 50);
	replicatorEast.position = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2);
	replicatorWest.position = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2);
	replicatorEast.anchorPoint = CGPointMake(0.5, 0.0);
	replicatorWest.anchorPoint = CGPointMake(0.5, 0.0);
	
	
	//Sublayers
	sublayerOne = [CALayer layer];
	sublayerTwo = [CALayer layer];
	
	sublayerOne.frame = replicatorEast.bounds;
	sublayerTwo.frame = replicatorWest.bounds;
	
//	sublayerOne.position = position;
//	sublayerTwo.position = position;
//	sublayerOne.anchorPoint = CGPointMake(0.5, 0.0);
//	sublayerTwo.anchorPoint = CGPointMake(0.5, 0.0);	
	
	sublayerOne.cornerRadius = 8;
	sublayerTwo.cornerRadius = 8;
	
	color = CGColorCreateGenericRGB(1, 1, 1, 1);
	sublayerOne.backgroundColor = color;
	sublayerTwo.backgroundColor = color;
	CGColorRelease(color);

	replicatorWest.transform = CATransform3DMakeScale(0.05, 0.05, 1.0);
	replicatorEast.transform = CATransform3DMakeScale(0.05, 0.05, 1.0);
	
	//Stack
	[replicatorNorth addSublayer:sublayerOne];
	[replicatorEast addSublayer:replicatorNorth];
	
	[replicatorSouth addSublayer:sublayerTwo];
	[replicatorWest addSublayer:replicatorSouth];
	
	[rootLayer addSublayer:replicatorEast];
	[rootLayer addSublayer:replicatorWest];
	
	
	[view setLayer:rootLayer];
	[view setWantsLayer:YES];
	
	[view setNeedsDisplay:YES];

	[self performSelector:@selector(animateIn) withObject:self afterDelay:0.75];
}


- (void)animateIn
{
	[CATransaction begin];
	
	[CATransaction setAnimationDuration:0.7];

//	sublayerOne.bounds = CGRectMake(0, 0, 50, 50);
//	sublayerTwo.bounds = CGRectMake(0, 0, 50, 50);
	
	replicatorEast.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
	replicatorWest.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
	
	[CATransaction commit];
	
	[self performSelector:@selector(zoomIn) withObject:self afterDelay:0.8];	
}


- (void)rollAnimation
{

	
	[CATransaction begin];
	
	[CATransaction setDisableActions:YES];
	
	replicatorEast.anchorPoint = CGPointMake(1.0, 0.0);
	replicatorWest.anchorPoint = CGPointMake(1.0, 0.0);	

//	replicatorEast.transform = CATransform3DMakeTranslation(100, 0.0, 0.0);
//	replicatorWest.transform = CATransform3DMakeTranslation(100, 0.0, 0.0);
	
	[CATransaction setDisableActions:NO];
	
	[CATransaction setAnimationDuration:2.0];
	[CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	replicatorEast.transform = CATransform3DMakeRotation(90/57.2958, 0.0, 0.0, -1.0);
	replicatorWest.transform = CATransform3DMakeRotation(90/57.2958, 0.0, 0.0, -1.0);
	
	[CATransaction commit];
	
}



- (void)zoomIn
{	
	
	[CATransaction begin];
	
	[CATransaction setAnimationDuration:0.9];
	
	[CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		
//	sublayerOne.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
			
	CATransform3D t = CATransform3DIdentity;
	t.m34 = 1.0/-550; //Newmans
	
	//	t = CATransform3DTranslate(t, 0, 40, -210);
	//	t = CATransform3DRotate(t, M_PI/2, .7, 0.7, 0.25);
	
	t = CATransform3DRotate(t, 0.09, 0, 0, 1); //Z
	t = CATransform3DRotate(t, .762, 0, 1, 0);	//Y
	t = CATransform3DRotate(t, 1.44, -1, 0, 0); //X
	
	replicatorEast.position = CGPointMake(135, 0);
	replicatorWest.position = CGPointMake(135, 0);
	
	rootLayer.sublayerTransform = t;

	[CATransaction commit];
	
	[self performSelector:@selector(createNorthQuad) withObject:self afterDelay:0.2];
	
}


-(void)createNorthQuad
{
	[CATransaction setDisableActions:YES];
	
	replicatorEast.instanceCount = 2;
	replicatorNorth.instanceCount = 2;

	[CATransaction setDisableActions:NO];
	
	[CATransaction setAnimationDuration:0.8];
	
	replicatorEast.instanceTransform = CATransform3DMakeTranslation(55, 0, 0);	
	replicatorNorth.instanceTransform = CATransform3DMakeTranslation(0, 55, 0);
	
	[self performSelector:@selector(createSouthQuad) withObject:self afterDelay:1.0];
}


- (void)createSouthQuad
{
	[CATransaction begin];

	[CATransaction setDisableActions:YES];
	
	replicatorWest.instanceCount = 2;
	replicatorSouth.instanceCount = 2;
//	replicatorWest.instanceDelay = 1.2;
	replicatorSouth.instanceDelay = 0.7;
	
	[CATransaction setDisableActions:NO];
	
	[CATransaction setAnimationDuration:1.2];
	
	replicatorWest.instanceTransform = CATransform3DMakeTranslation(-55, 0, 0);	
	replicatorSouth.instanceTransform = CATransform3DMakeTranslation(0, -55, 0);
	
	
	//Zoom Out
	rootLayer.sublayerTransform = CATransform3DIdentity;
	
	replicatorEast.position = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2);
	replicatorWest.position = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2);
	
	[CATransaction commit];
	
	[self performSelector:@selector(centerX) withObject:self afterDelay:1.3];
}


- (void)centerX
{
	[CATransaction begin];
	
	[CATransaction setAnimationDuration:0.8];
	
	replicatorNorth.instanceTransform = CATransform3DIdentity;
	replicatorSouth.instanceTransform = CATransform3DIdentity;
	
	[CATransaction commit];		
	
	[self performSelector:@selector(centerY) withObject:self afterDelay:0.5];
}

- (void)centerY
{
	[CATransaction setAnimationDuration:0.8];
		
	replicatorEast.instanceTransform = CATransform3DIdentity;
	replicatorWest.instanceTransform = CATransform3DIdentity;
		
	[CATransaction begin];

	[self performSelector:@selector(spreadX) withObject:self afterDelay:0.8];
}

- (void)spreadX
{
	[CATransaction begin];
	
	[CATransaction setDisableActions:YES];
	
	replicatorEast.instanceCount = 17;
	replicatorWest.instanceCount = 17;
	replicatorEast.instanceBlueOffset = -0.05;
	replicatorEast.instanceGreenOffset = -0.05;
	
	replicatorWest.instanceGreenOffset = -0.05;
	
	[CATransaction setDisableActions:NO];
	
	[CATransaction setAnimationDuration:2.0];
	
	replicatorEast.instanceTransform = CATransform3DMakeTranslation(55.0, 0.0, 0.0);
	replicatorWest.instanceTransform = CATransform3DMakeTranslation(-55.0, 0.0, 0.0);
	
	rootLayer.sublayerTransform = CATransform3DMakeScale(0.4, 0.4, 1.0);	
	
	[CATransaction commit];

	[self performSelector:@selector(spreadY) withObject:self afterDelay:1.7];	
}


- (void)spreadY
{
	[CATransaction begin];
	
	[CATransaction setDisableActions:YES];
	
	replicatorNorth.instanceCount = 17;

	replicatorNorth.instanceDelay = 0.7;
	
	replicatorSouth.instanceDelay = 1.0;
	
	replicatorSouth.instanceCount = 17;
	
	
	replicatorNorth.instanceGreenOffset = -0.05;
	
	replicatorSouth.instanceRedOffset = -0.05;
	
	[CATransaction setDisableActions:NO];
	
	[CATransaction setAnimationDuration:3.0];	
	
	replicatorNorth.instanceTransform = CATransform3DMakeTranslation(0.0, 55.0, 0.0);
	
	replicatorSouth.instanceTransform = CATransform3DMakeTranslation(0.0, -55.0, 0.0);
	
	
	rootLayer.sublayerTransform = CATransform3DMakeScale(0.3, 0.3, 1.0);
	
	[CATransaction commit];
	
	[self performSelector:@selector(rotateCameraAngle) withObject:self afterDelay:3.0];	
}


- (void)rotateCameraAngle
{	
	
	[CATransaction setAnimationDuration:2.2];
	
	CATransform3D t = CATransform3DIdentity;
	t.m34 = 1.0/-550; //Newmans
	
	t = CATransform3DRotate(t, 0.09, 0, 0, 1); //Z
	t = CATransform3DRotate(t, .762, 0, 1, 0);	//Y
	t = CATransform3DRotate(t, 1.44, -1, 0, 0); //X
	
	t = CATransform3DScale(t, 0.35, 0.35, 1.0);
	t = CATransform3DTranslate(t, -220, -220, 0);
	
	rootLayer.sublayerTransform = t;
	
	replicatorEast.transform = CATransform3DMakeTranslation(-440, -440, 0);
	replicatorWest.transform = CATransform3DMakeTranslation(440, 440, -55);

	[self performSelector:@selector(animateTopOut) withObject:self afterDelay:2.6];
	[self performSelector:@selector(animateBottomOut) withObject:self afterDelay:2.6];	
	
}


- (void)animateTopOut
{
	[CATransaction setDisableActions:YES];
	

	replicatorNorth.instanceDelay = .15;
	replicatorEast.instanceDelay = (.15 * 17);
//	replicatorSouth.instanceDelay = (replicatorWest.instanceDelay * 17);
	
	[CATransaction setDisableActions:NO];
	
	
	CATransform3D tOne;
	tOne = CATransform3DMakeTranslation(-1000, 0, 0);
	
	
	CABasicAnimation *animationOne = [CABasicAnimation animation];
	animationOne.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	animationOne.toValue = [NSValue valueWithCATransform3D:tOne];
	animationOne.duration = 1.0;
//	animationOne.autoreverses = YES;
//	animationOne.repeatCount = 1e100f;
	animationOne.removedOnCompletion = NO;
	animationOne.fillMode = kCAFillModeBoth;
	[sublayerOne addAnimation:animationOne forKey:@"transform"];


	[self performSelector:@selector(reverseAnimationTopOut) withObject:self afterDelay:44.25];

}


- (void)animateBottomOut
{
	CATransform3D tTwo;	
	tTwo = CATransform3DMakeTranslation(0, -1000, 0);
	
	CABasicAnimation *animationTwo = [CABasicAnimation animation];
	animationTwo.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	animationTwo.toValue = [NSValue valueWithCATransform3D:tTwo];
	animationTwo.duration = 1.0;
	//	animationTwo.autoreverses = YES;
	//	animationTwo.repeatCount = 1e100f;
	animationTwo.removedOnCompletion = NO;
	animationTwo.fillMode = kCAFillModeBoth;
	[sublayerTwo addAnimation:animationTwo forKey:@"transform"];
	
	[self performSelector:@selector(reverseAnimationBottomOut) withObject:self afterDelay:17];
}


- (void)reverseAnimationTopOut
{
	CATransform3D tOne;
	tOne = CATransform3DMakeTranslation(-1000, 0, 0);
	
	
	CABasicAnimation *animationOne = [CABasicAnimation animation];
	animationOne.fromValue = [NSValue valueWithCATransform3D:tOne];
	animationOne.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	animationOne.duration = 1.0;
	animationOne.removedOnCompletion = NO;
	animationOne.fillMode = kCAFillModeBoth;
	[sublayerOne addAnimation:animationOne forKey:@"transform"];
	
	
	[self performSelector:@selector(animateTopOut) withObject:self afterDelay:44.25];
}


- (void)reverseAnimationBottomOut
{
	CATransform3D tTwo;	
	tTwo = CATransform3DMakeTranslation(0, -1000, 0);
	
	CABasicAnimation *animationTwo = [CABasicAnimation animation];
	animationTwo.fromValue = [NSValue valueWithCATransform3D:tTwo];
	animationTwo.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	animationTwo.duration = 1.0;
	animationTwo.removedOnCompletion = NO;
	animationTwo.fillMode = kCAFillModeBoth;
	[sublayerTwo addAnimation:animationTwo forKey:@"transform"];

	[NSTimer scheduledTimerWithTimeInterval:17.0 target:self selector:@selector(animateBottomOut) userInfo:nil repeats:NO];		
}

@end











