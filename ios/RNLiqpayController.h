#import <UIKit/UIKit.h>
#import "Liqpay/LiqpayMob.h"
#import "RNLiqpayView.h"
#import "RNLiqpayInteractor.h"

@interface RNLiqpayController : UIViewController<LiqPayCallBack>

- (instancetype)initWithBridgeView:(id<RNLiqpayInteractor>)bridgeView;

@end
