@protocol RNLiqpayInteractor <NSObject>

- (void)notifyLiqpayError:(NSDictionary *)eventPayload;
- (void)notifyLiqpaySuccess:(NSDictionary *)eventPayload;

@end
