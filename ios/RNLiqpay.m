#import "RNLiqpay.h"
#import "RNLiqpayView.h"
#import "RCTModalManager.h"
#import "RCTShadowView.h"
#import "RCTUtils.h"

@implementation RNLiqpay
{
    NSHashTable *_hostViews;
}

RCT_EXPORT_MODULE()

- (UIView *)view
{
    return [[RNLiqpayView alloc] init];
}
RCT_EXPORT_VIEW_PROPERTY(type, NSString)

RCT_EXPORT_VIEW_PROPERTY(onLiqpaySuccess, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onLiqpayError, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(params, NSDictionary)
RCT_EXPORT_VIEW_PROPERTY(paramsBase64, NSString)
RCT_EXPORT_VIEW_PROPERTY(signature, NSString)
RCT_EXPORT_VIEW_PROPERTY(privateKey, NSString)
RCT_EXPORT_VIEW_PROPERTY(path, NSString)

@end

