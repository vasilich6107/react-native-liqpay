#import "RNLiqpayController.h"
#import "Liqpay/LiqpayMob.h"

@implementation RNLiqpayController
{
    LiqpayMob *_liqpayObject;
    RNLiqpayView *_bridgeView;
}

- (instancetype)initWithBridgeView:(RNLiqpayView *)bridgeView
{
    self = [super init];
    if (self)
    {
        _bridgeView = bridgeView;
        _liqpayObject = [[LiqpayMob alloc] initLiqPayWithDelegate:self];
    }
    return self;
}

- (void)onResponseSuccess:(NSString *)response {
    [_bridgeView notifyLiqpaySuccess:(@{@"response": @"Success"})];
}

- (void)onResponseError:(NSError *)errorCode {
    [_bridgeView notifyLiqpayError:(@{@"response": @"Error"})];
}

- (UIColor *)getStatusBarColor {
    return [UIColor whiteColor];
}


@end

