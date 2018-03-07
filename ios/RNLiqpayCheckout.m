#import "RNLiqpayCheckout.h"
#import "RNLiqpayCheckoutView.h"
#import "RCTModalManager.h"
#import "RCTShadowView.h"
#import "RCTUtils.h"

@implementation RNLiqpayCheckout
{
    NSHashTable *_hostViews;
}

RCT_EXPORT_MODULE()

- (UIView *)view
{
    return [[RNLiqpayCheckoutView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(onLiqpaySuccess, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onLiqpayError, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(params, NSDictionary)
RCT_EXPORT_VIEW_PROPERTY(privateKey, NSString)

@end

