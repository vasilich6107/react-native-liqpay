#import <UIKit/UIKit.h>

#import <React/RCTInvalidating.h>
#import "RNLiqpayInteractor.h"

#import <React/RCTView.h>

@class RCTBridge;
@class RCTModalHostViewController;
@class RCTTVRemoteHandler;

@protocol RCTModalHostViewInteractor;

@interface RNLiqpayCheckoutView : UIView <RCTInvalidating, RNLiqpayInteractor>

@property (nonatomic, copy) RCTBubblingEventBlock onLiqpaySuccess;
@property (nonatomic, copy) RCTBubblingEventBlock onLiqpayError;
@property (nonatomic, copy) NSDictionary *params;
@property (nonatomic, copy) NSString *privateKey;

@end

