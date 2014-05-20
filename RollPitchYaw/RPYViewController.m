//
//  RPYViewController.m
//  RollPitchYaw
//
//  Created by BJ Miller on 5/3/14.
//  Copyright (c) 2014 Six Five Software, LLC. All rights reserved.
//

#import "RPYViewController.h"
@import CoreMotion;

#define kRadToDeg   57.2957795

@interface RPYViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rollLabel;
@property (weak, nonatomic) IBOutlet UILabel *pitchLabel;
@property (weak, nonatomic) IBOutlet UILabel *yawLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotationXLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotationYLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotationZLabel;
@property (nonatomic, strong) CMMotionManager *motionManager;
@end

@implementation RPYViewController

- (CMMotionManager *)motionManager
{
    if (!_motionManager) {
        _motionManager = [CMMotionManager new];
        [_motionManager setDeviceMotionUpdateInterval:0.01];
    }
    return _motionManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        self.rollLabel.text = [NSString stringWithFormat:@"%.2gº", motion.attitude.roll * kRadToDeg];
        self.pitchLabel.text = [NSString stringWithFormat:@"%.2gº", motion.attitude.pitch * kRadToDeg];
        self.yawLabel.text = [NSString stringWithFormat:@"%.2gº", motion.attitude.yaw * kRadToDeg];
    }];
    
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData *gyroData, NSError *error) {
        self.rotationXLabel.text = [NSString stringWithFormat:@"%f", gyroData.rotationRate.x];
        self.rotationYLabel.text = [NSString stringWithFormat:@"%f", gyroData.rotationRate.y];
        self.rotationZLabel.text = [NSString stringWithFormat:@"%f", gyroData.rotationRate.z];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.motionManager stopDeviceMotionUpdates];
    self.motionManager = nil;
    [super viewWillDisappear:animated];
}

@end
