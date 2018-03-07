#import <UIKit/UIKit.h>
#import "Liqpay/LiqpayMob.h"
#import "RNLiqpayCheckoutView.h"
#import "RNLiqpayInteractor.h"

@interface RNLiqpayController : UIViewController<LiqPayCallBack>

- (instancetype)initWithBridgeView:(id<RNLiqpayInteractor>)bridgeView;

@end
