//
//  LMLoadingHUD.h
//  LMLoadingHUD
//
//  Created by Mtel on 2017/7/3.
//  Copyright © 2017年 Mtel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMLoadingHUD : UIView
+(LMLoadingHUD*)hideIn:(UIView*)view;
+(LMLoadingHUD*)showIn:(UIView*)view;
@end
