#import "RNLiqpayController.h"
#import "Liqpay/LiqpayMob.h"

@implementation RNLiqpayController
{
    LiqpayMob *_liqpayObject;
    id<RNLiqpayInteractor> _bridgeView;
}

- (instancetype)initWithBridgeView:(id<RNLiqpayInteractor>)bridgeView
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
    [_bridgeView notifyLiqpaySuccess:(@{@"response": response})];
}

- (void)onResponseError:(NSError *)errorCode {
    NSDictionary *errorCodeNames = @{
                                     @(ErrorCodeIO):@"ERROR_CODE_IO",
                                     @(ErrorCodeInetMissing):@"ERROR_CODE_INET_MISSING",
                                     @(ErrorCodeNonUIThread):@"ERROR_CODE_NON_UI_THREAD",
                                     @(ErrorCodeCheckoutCanceled):@"ERROR_CODE_CHECKOUT_CANCELED",
                                     @(ErrorCodeUIThread):@"ERROR_CODE_IU_THREAD"
                                     };
    
    [_bridgeView notifyLiqpayError:(@{@"error": errorCodeNames[@([errorCode code])]})];
}

- (UIColor *)getStatusBarColor {
    return [UIColor whiteColor];
}


@end

