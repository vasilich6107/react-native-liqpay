#import "RNLiqpayView.h"

#import <UIKit/UIKit.h>

#import "Liqpay/LiqpayMob.h"
#import "RCTAssert.h"
#import "RNLiqpayController.h"
#import "RCTTouchHandler.h"
#import "RCTUIManager.h"
#import "RCTUtils.h"
#import "UIView+React.h"

@implementation RNLiqpayView
{
    BOOL _isPresented;
    RNLiqpayController *_liqpayController;
    LiqpayMob *_liqpayObject;
}

RCT_NOT_IMPLEMENTED(- (instancetype)initWithFrame:(CGRect)frame)
RCT_NOT_IMPLEMENTED(- (instancetype)initWithCoder:coder)

- (instancetype)initWithBridge:(RCTBridge *)bridge
{
    if ((self = [super initWithFrame:CGRectZero])) {
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
//
//- (BOOL)isTransparent
//{
//    return _modalViewController.modalPresentationStyle == UIModalPresentationOverFullScreen;
//}
//
//- (BOOL)hasAnimationType
//{
//    return ![self.animationType isEqualToString:@"none"];
//}

//- (void)setTransparent:(BOOL)transparent
//{
//    if (self.isTransparent != transparent) {
//        return;
//    }
//
//    _modalViewController.modalPresentationStyle = transparent ? UIModalPresentationOverFullScreen : UIModalPresentationFullScreen;
//}

@end
