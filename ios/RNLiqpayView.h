#import <UIKit/UIKit.h>

#import <React/RCTInvalidating.h>

#import <React/RCTView.h>

@class RCTBridge;
@class RCTModalHostViewController;
@class RCTTVRemoteHandler;

@protocol RCTModalHostViewInteractor;

@interface RNLiqpayView : UIView <RCTInvalidating>

@property (nonatomic, copy) RCTBubblingEventBlock onLiqpaySuccess;
@property (nonatomic, copy) RCTBubblingEventBlock onLiqpayError;
@property (nonatomic, copy) NSDictionary *params;
@property (nonatomic, copy) NSString *privateKey;

- (void)notifyLiqpayError:(NSDictionary *)eventPayload;
- (void)notifyLiqpaySuccess:(NSDictionary *)eventPayload;
- (instancetype)initWithBridge:(RCTBridge *)bridge NS_DESIGNATED_INITIALIZER;

@end

