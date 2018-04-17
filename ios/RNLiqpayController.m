#import "RNLiqpayController.h"
#import "Liqpay/LiqpayMob.h"

@implementation RNLiqpayController
{
    LiqpayMob *_liqpayObject;
    id<RNLiqpayInteractor> _bridgeView;
    NSDictionary *errorCodeNames;
}

- (instancetype)initWithBridgeView:(id<RNLiqpayInteractor>)bridgeView
{
    self = [super init];
    if (self)
    {
        _bridgeView = bridgeView;
        _liqpayObject = [[LiqpayMob alloc] initLiqPayWithDelegate:self];
        errorCodeNames = @{
                            @(ErrorCodeIO):@"ERROR_CODE_IO",
                            @(ErrorCodeInetMissing):@"ERROR_CODE_INET_MISSING",
                            @(ErrorCodeNonUIThread):@"ERROR_CODE_NON_UI_THREAD",
                            @(ErrorCodeCheckoutCanceled):@"ERROR_CODE_CHECKOUT_CANCELED",
                            @(ErrorCodeUIThread):@"ERROR_CODE_IU_THREAD"
                            };
    }
    return self;
}

- (void)onResponseSuccess:(NSString *)response {
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data

                          options:kNilOptions
                          error:&error];

    if(error) {
        [_bridgeView notifyLiqpayError:(@{
                                          @"error": errorCodeNames[@(ErrorCodeIO)],
                                          @"message": [error localizedDescription]
                                        })];
    }
    else {
        [_bridgeView notifyLiqpaySuccess:(json)];
    }


}

- (void)onResponseError:(NSError *)errorCode {
    [_bridgeView notifyLiqpayError:(@{@"error": errorCodeNames[@([errorCode code])]})];
}

- (UIColor *)getStatusBarColor {
    return [UIColor whiteColor];
}


@end
