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
    NSError* error;

    NSDictionary* responseJSON = [NSJSONSerialization
                          JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                          options:kNilOptions
                          error:&error];

    NSDictionary* responseDataJSON = [NSJSONSerialization
                                  JSONObjectWithData:[responseJSON[@"data"] dataUsingEncoding:NSUTF8StringEncoding]
                                  options:kNilOptions
                                  error:&error];

    if(error) {
        [_bridgeView notifyLiqpayError:(@{
                                          @"error": errorCodeNames[@(ErrorCodeIO)],
                                          @"message": [error localizedDescription]
                                        })];
    }
    else if([responseDataJSON[@"status"] isEqualToString:@"failure"]) {
        if([responseDataJSON[@"err_code"] isEqualToString:@"cancel"]) {
            [_bridgeView notifyLiqpayError:(@{
                                              @"error": errorCodeNames[@(ErrorCodeCheckoutCanceled)],
                                              @"message": responseDataJSON[@"err_description"]
                                              })];
        }
        else {
            [_bridgeView notifyLiqpayError:(@{
                                              @"error": responseDataJSON[@"err_code"],
                                              @"message": responseDataJSON[@"err_description"]
                                              })];
        }
    }
    else {
        [_bridgeView notifyLiqpaySuccess:(responseJSON)];
    }


}

- (void)onResponseError:(NSError *)errorCode {
    [_bridgeView notifyLiqpayError:(@{@"error": errorCodeNames[@([errorCode code])]})];
}

- (UIColor *)getStatusBarColor {
    return [UIColor whiteColor];
}


@end
