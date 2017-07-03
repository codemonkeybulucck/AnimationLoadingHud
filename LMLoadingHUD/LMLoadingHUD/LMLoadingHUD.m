//
//  LMLoadingHUD.m
//  LMLoadingHUD
//
//  Created by Mtel on 2017/7/3.
//  Copyright © 2017年 Mtel. All rights reserved.
//

#import "LMLoadingHUD.h"

#define beginDuration  0.5f
#define finishDuration 0.5f

@interface LMLoadingHUD()<CAAnimationDelegate>
@property (nonatomic,strong) CAShapeLayer *animationLayer;
@property (nonatomic,strong) CAShapeLayer *whiteLayer;
@end

@implementation LMLoadingHUD

+(LMLoadingHUD*)showIn:(UIView*)view{
    [self hideIn:view];
    LMLoadingHUD *hud = [[LMLoadingHUD alloc] initWithFrame:view.bounds];
    [view addSubview:hud];
    [hud startLoading];
    return hud;
}

+(LMLoadingHUD*)hideIn:(UIView*)view{
    LMLoadingHUD *hud = nil;
    for (LMLoadingHUD *hudView in view.subviews) {
        if ([hudView isKindOfClass:[LMLoadingHUD class]]) {
            [hudView stopLoading];
            [hudView removeFromSuperview];
            hud = hudView;
        }
    }
    return hud;
}


- (CAShapeLayer *)animationLayer{
    if (!_animationLayer) {
        _animationLayer = [CAShapeLayer layer];
        _animationLayer.bounds = CGRectMake(0, 0, 60, 60);
        _animationLayer.position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0);
        _animationLayer.fillColor = [UIColor clearColor].CGColor;
        _animationLayer.strokeColor = [UIColor blackColor].CGColor;
        _animationLayer.lineWidth = 4.0f;
        _animationLayer.lineCap = kCALineCapRound;
    }
    return _animationLayer;
}

- (CAShapeLayer *)whiteLayer{
    if (!_whiteLayer) {
        _whiteLayer = [CAShapeLayer layer];
        _whiteLayer.bounds = CGRectMake(0, 0, 70, 70);
        _whiteLayer.position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0);
        _whiteLayer.fillColor = [UIColor clearColor].CGColor;
        _whiteLayer.strokeColor = [UIColor whiteColor].CGColor;
        _whiteLayer.lineWidth = 10.0f;
        _whiteLayer.lineCap = kCALineCapRound;
    }
    return _whiteLayer;
}

- (void)stopLoading{
    [self.whiteLayer removeAllAnimations];
    [self.animationLayer removeAllAnimations];
    [self.whiteLayer removeFromSuperlayer];
    [self.animationLayer removeFromSuperlayer];
}

- (void)startLoading{
    
    [self.layer addSublayer:self.animationLayer];

    
    CGFloat radius = self.animationLayer.bounds.size.width * 0.5 - self.animationLayer.lineWidth;
    CGFloat centerX = self.animationLayer.bounds.size.width/2.0f;
    CGFloat centerY = self.animationLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX,centerY) radius:radius startAngle:-M_PI_2 endAngle:M_PI+M_PI_2 clockwise:YES];
    path.lineCapStyle = kCGLineCapRound;
    self.animationLayer.path = path.CGPath;
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.duration = beginDuration;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basicAnimation.fromValue = @(0.0f);
    basicAnimation.toValue = @(0.75f);
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.delegate = self;
    [self.animationLayer addAnimation:basicAnimation forKey:@"loading"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        CABasicAnimation *loadingAni = (CABasicAnimation*)[self.animationLayer animationForKey:@"loading"];
        if (loadingAni == anim) {
            CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            basicAnimation.duration = finishDuration;
            basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            basicAnimation.fromValue = @(0.75f);
            basicAnimation.toValue = @(1.0);
            basicAnimation.fillMode = kCAFillModeForwards;
            basicAnimation.removedOnCompletion = NO;
            basicAnimation.delegate = self;
            [self.animationLayer addAnimation:basicAnimation forKey:@"finish"];
            //添加白色layer覆盖蓝色layer
            [self beginWhiteLayerAnimation];
            
            return;
        }
        CABasicAnimation *finishAni = (CABasicAnimation*)[self.animationLayer animationForKey:@"finish"];
        if (finishAni == anim) {
            //移除动画重新开始
            [self.animationLayer removeAllAnimations];
            [self.whiteLayer removeAllAnimations];
            [self.whiteLayer removeFromSuperlayer];
            [self.animationLayer removeFromSuperlayer];
            [self startLoading];
        }
    }
}


- (void)beginWhiteLayerAnimation{
    [self.layer addSublayer:self.whiteLayer];
    CGFloat radius = self.whiteLayer.bounds.size.width * 0.5 - self.whiteLayer.lineWidth;
    CGFloat centerX = self.whiteLayer.bounds.size.width/2.0f;
    CGFloat centerY = self.whiteLayer.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX,centerY) radius:radius startAngle:-M_PI_2 endAngle:M_PI+M_PI_2 clockwise:YES];
    path.lineCapStyle = kCGLineCapRound;
    self.whiteLayer.path = path.CGPath;
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.duration = finishDuration;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    basicAnimation.fromValue = @(0.0f);
    basicAnimation.toValue = @(1.0f);
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    [self.whiteLayer addAnimation:basicAnimation forKey:@"whiteLoading"];
}

@end
