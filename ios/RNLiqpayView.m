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
        
        dispatch_block_t completionBlock = nil;
        
        if ([self.type isEqualToString:@"checkout"]) {
            completionBlock = ^{
                [_liqpayObject checkout:self.params
                             privateKey:self.privateKey
                               delegate:_liqpayController];
            };
        } else if ([self.type isEqualToString:@"checkoutWithParamsBase64"]) {
            completionBlock = ^{
                [_liqpayObject checkoutWithParamsBase64:self.paramsBase64
                                              signature:self.signature
                                               delegate:_liqpayController];
            };
        } else if ([self.type isEqualToString:@"api"]) {
            completionBlock = ^{
                [_liqpayObject api:self.path
                            params:self.params
                        privateKey:self.privateKey
                          delegate:_liqpayController];
            };
        } else if ([self.type isEqualToString:@"apiBase64"]) {
            completionBlock = ^{
                [_liqpayObject api:self.path
                      paramsBase64:self.paramsBase64
                         signature:self.signature
                          delegate:_liqpayController];
            };
        }
        
        
        [[self reactViewController] presentViewController:_liqpayController animated:YES completion:completionBlock];
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
