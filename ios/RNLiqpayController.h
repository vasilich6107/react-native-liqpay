//
//  ViewController.h
//  LiqPayTest
//
//  Created by vasilich on 2/15/18.
//  Copyright © 2018 vasilich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Liqpay/LiqpayMob.h"
#import "RNLiqpayView.h"

@interface RNLiqpayController : UIViewController<LiqPayCallBack>

- (instancetype)initWithBridgeView:(RNLiqpayView *)bridgeView;

@end
