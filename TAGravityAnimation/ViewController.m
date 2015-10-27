//
//  ViewController.m
//  TAGravityAnimation
//
//  Created by 李小盆 on 15/10/26.
//  Copyright © 2015年 Zip Lee. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

#define kFilteringFactor 0.175

@interface ViewController ()
{
    CMMotionManager * animationManager;
    UIImageView * imageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 30, 30)];
    imageView.image = [UIImage imageNamed:@"tagshop.png"];
    [self.view addSubview:imageView];

    animationManager = [[CMMotionManager alloc]init];
    animationManager.deviceMotionUpdateInterval = 0.01;
    [animationManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                  withHandler:^(CMAccelerometerData *data, NSError *error) {
                                      CGFloat x = data.acceleration.x;
                                      x = data.acceleration.x * kFilteringFactor + x * (1.0 - kFilteringFactor);
                                      [UIView beginAnimations:@"rotate" context:nil];
                                      [UIView setAnimationDuration:0.1];
                                      imageView.transform=CGAffineTransformMakeRotation(-x);
                                      [UIView commitAnimations];
                                  }];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
