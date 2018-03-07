#import "RNLiqpayCheckoutView.h"

#import <UIKit/UIKit.h>

#import "Liqpay/LiqpayMob.h"
#import "RCTAssert.h"
#import "RNLiqpayController.h"
#import "RCTTouchHandler.h"
#import "RCTUIManager.h"
#import "RCTUtils.h"
#import "UIView+React.h"

@implementation RNLiqpayCheckoutView
{
    BOOL _isPresented;
    RNLiqpayController *_liqpayController;
    LiqpayMob *_liqpayObject;
}

- (instancetype)init
{
    if ((self = [super init])) {
        _liqpayController = [[RNLiqpayController alloc] initWithBridgeView:self];
        _liqpayObject = [[LiqpayMob alloc] initLiqPayWithDelegate:_liqpayController];
        _isPresented = NO;
    }
    
    return self;
}

- (void)dismissModalViewController
{
    if (_isPresented) {
        [_liqpayController dismissViewControllerAnimated:YES completion:nil];
        _isPresented = NO;
    }
}

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    if (!_isPresented && self.window) {
        RCTAssert(self.reactViewController, @"Can't present modal view controller without a presenting view controller");
        [[self reactViewController] presentViewController:_liqpayController animated:YES completion:^{
            [_liqpayObject checkout:self.params
                         privateKey:self.privateKey
                           delegate:_liqpayController];
        }];
        _isPresented = YES;
    }
}

- (void)notifyLiqpayError:(NSDictionary *)eventPayload
{
    self.onLiqpayError(eventPayload);
}

- (void)notifyLiqpaySuccess:(NSDictionary *)eventPayload
{
    self.onLiqpaySuccess(eventPayload);
}

- (void)invalidate
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissModalViewController];
    });
}

@end
