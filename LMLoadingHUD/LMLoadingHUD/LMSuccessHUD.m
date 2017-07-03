//
//  LMSuccessHUD.m
//  LMLoadingHUD
//
//  Created by Mtel on 2017/7/3.
//  Copyright © 2017年 Mtel. All rights reserved.
//

#import "LMSuccessHUD.h"

#define beginDuration  0.5f
#define finishDuration 0.2f

@interface LMSuccessHUD()<CAAnimationDelegate>
@property (nonatomic,strong) CAShapeLayer *player;
@end

@implementation LMSuccessHUD

+(LMSuccessHUD*)hideIn:(UIView*)view{
    LMSuccessHUD *hud = nil;
    for (LMSuccessHUD *hudView in view.subviews) {
        if ([hudView isKindOfClass:[LMSuccessHUD class]]) {
            [hudView removeFromSuperview];
            hud = hudView;
        }
    }
    return hud;
}

+(LMSuccessHUD*)showIn:(UIView*)view{
    [self hideIn:view];
    LMSuccessHUD *hud = [[LMSuccessHUD alloc]initWithFrame:view.bounds];
    [view addSubview:hud];
    [hud startAnimation];
    return hud;
}

- (void)startAnimation{
    [self.layer addSublayer:self.player];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = beginDuration;
    animation.fromValue = @(0.0f);
    animation.toValue = @(0.8f);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    animation.delegate = self;
    
    
    CGFloat radius = self.player.bounds.size.width * 0.5 - self.player.lineWidth;
    CGFloat centerX = self.player.bounds.size.width/2.0f;
    CGFloat centerY = self.player.bounds.size.height/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX,centerY) radius:radius startAngle:-M_PI_2 endAngle:M_PI+M_PI_2 clockwise:YES];
    path.lineCapStyle = kCGLineCapRound;
    self.player.path = path.CGPath;
    
    [self.player addAnimation:animation forKey:@"animation1"];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        //完成剩余的动画
        CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation2.fromValue = @(0.8f);
        animation2.toValue = @(1.0f);
        animation2.duration = finishDuration;
        [self.player addAnimation:animation2 forKey:@"animation2"];
        //对勾动画
        [self checkAnimation];
        
    }
}

//对号
-(void)checkAnimation{
    
    CGFloat a = self.player.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(a*2.7/10,a*5.4/10)];
    [path addLineToPoint:CGPointMake(a*4.5/10,a*7/10)];
    [path addLineToPoint:CGPointMake(a*7.8/10,a*3.8/10)];
    
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = [UIColor blackColor].CGColor;
    checkLayer.lineWidth = 4.0f;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [_player addSublayer:checkLayer];
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = finishDuration;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    [checkLayer addAnimation:checkAnimation forKey:nil];
}


- (CAShapeLayer *)player{
    if (!_player) {
        _player = [CAShapeLayer layer];
        _player.bounds = CGRectMake(0, 0, 60, 60);
        _player.position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0);
        _player.fillColor = [UIColor clearColor].CGColor;
        _player.strokeColor = [UIColor blackColor].CGColor;
        _player.lineWidth = 4.0f;
        _player.lineCap = kCALineCapRound;
    }
    return _player;
}

@end
