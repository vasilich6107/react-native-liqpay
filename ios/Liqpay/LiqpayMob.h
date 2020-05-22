//
//  LiqpayMob.h
//  LiqpayMob
//
//  Created by Test CEB MacBook Pro on 3/22/16.
//  Copyright © 2016 PrivatBank. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM( NSUInteger, ErrorCode ) {
    ErrorCodeIO,          // -  I/O exception while sending request to server
    ErrorCodeInetMissing, // Operation is not possible, because there is no
    // Internet connection
    ErrorCodeNonUIThread, // You need to call method in NON UI thread
    ErrorCodeCheckoutCanceled, // Checkout is canceled without waiting for
    // confirmation
    ErrorCodeUIThread, // You need to call method in UI thread
};

@protocol LiqPayCallBack <NSObject>

- (UINavigationController *)navigationController;

- (void)onResponseSuccess:(NSString *)response;

- (void)onResponseError:(NSError *)errorCode;

- (UIColor *)getStatusBarColor;

@end

@interface LiqpayMob : NSObject

@property ( nonatomic, weak ) id<LiqPayCallBack> delegate;

- (id)initLiqPayWithDelegate:(id<LiqPayCallBack>)delegate;

/**
 * Create custom request to Liqpay server with parameters.
 * You should obtain a privateKey from Liqpay.
 *
 * @param path       Request path (example: status)
 * @param params     Parameters to generate base64Data
 * @param privateKey is privat key your store
 *                   it is recommended to store the private key on your server
 * @param delegate   Callback will be invoked when the response from the server
 * is recived or when error
 */

- (void)api:(NSString *)path
     params:(NSDictionary *)params
 privateKey:(NSString *)privateKey
   delegate:(id<LiqPayCallBack>)delegate;


/**
 * Create custom request to liqpay server with base64 encrypted parameters.
 * You should obtain a privateKey from Liqpay and create signature from it.
 *
 * @param path       request path (example: status)
 * @param base64Data is besa64 encode result from JSON string
 * @param signature  is base64 encode result from sha1 binary hash from
 * concatenate string ${PRIVATE_KEY}${DATA}${PRIVATE_KEY}
 * @param delegate   Callback will be invoked when the response from the server
 * is recived or when error .
 */
- (void)api:(NSString *)path
paramsBase64:(NSString *)paramsBase64
  signature:(NSString *)signature
   delegate:(id<LiqPayCallBack>)delegate;

/**
 * Receiving payments on a personal checkout Liqpay client->server in WebView.
 * You should obtain a privateKey from Liqpay.
 *
 * @param context    Context of the application
 * @param params     parameters to generate base64Data
 * @param privateKey is privat key your store
 *                   it is recommended to store the private key on your server
 * @param callBack   Callback will be invoked when the response from the server
 * is recived or when error
 */
- (void)checkout:(NSDictionary *)params
      privateKey:(NSString *)privateKey
        delegate:(id<LiqPayCallBack>)delegate;

/**
 * Receiving payments on a personal checkout Liqpay client->server in WebView.
 * You should obtain a privateKey from Liqpay and create signature from it.
 * Parameters are base64 encrypted.
 *
 * @param context    Context of the application
 * @param base64Data is base64 encode result from JSON string
 * @param signature  is base64 encode result from sha1 binary hash from
 * concatenate string ${PRIVATE_KEY}${DATA}${PRIVATE_KEY}
 * @param callBack   Callback will be invoked when the response from the server
 * is recived or when error .
 */
- (void)checkoutWithParamsBase64:(NSString *)paramsBase64
                       signature:(NSString *)signature
                        delegate:(id<LiqPayCallBack>)delegate;

@end
