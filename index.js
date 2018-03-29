import React from 'react';
import PropTypes from 'prop-types';
import { requireNativeComponent } from 'react-native';

const RNLiqpay = requireNativeComponent('RNLiqpay', null);
const style = {
  position: 'absolute',
  top: 0,
  left: 0,
  bottom: 0,
  right: 0
};

const LiqpayCheckout = props => <RNLiqpay type="checkout" style={style} {...props} />;

LiqpayCheckout.propTypes = {
  // eslint-disable-next-line react/forbid-prop-types
  params: PropTypes.object.isRequired,
  privateKey: PropTypes.string.isRequired,
  onLiqpaySuccess: PropTypes.func.isRequired,
  onLiqpayError: PropTypes.func.isRequired,
};

const LiqpayCheckoutBase64 = props => <RNLiqpay type="checkoutBase64" style={style} {...props} />;

LiqpayCheckoutBase64.propTypes = {
  paramsBase64: PropTypes.string.isRequired,
  signature: PropTypes.string.isRequired,
  onLiqpaySuccess: PropTypes.func.isRequired,
  onLiqpayError: PropTypes.func.isRequired,
};

const LiqpayApi = props => <RNLiqpay type="api" style={style} {...props} />;

LiqpayApi.propTypes = {
  // eslint-disable-next-line react/forbid-prop-types
  params: PropTypes.object.isRequired,
  path: PropTypes.string.isRequired,
  privateKey: PropTypes.string.isRequired,
  onLiqpaySuccess: PropTypes.func.isRequired,
  onLiqpayError: PropTypes.func.isRequired,
};

const LiqpayApiBase64 = props => <RNLiqpay type="apiBase64" style={style} {...props} />;

LiqpayApiBase64.propTypes = {
  path: PropTypes.string.isRequired,
  paramsBase64: PropTypes.string.isRequired,
  signature: PropTypes.string.isRequired,
  onLiqpaySuccess: PropTypes.func.isRequired,
  onLiqpayError: PropTypes.func.isRequired,
};

module.exports = {
  LiqpayCheckout,
  LiqpayCheckoutBase64,
  LiqpayApi,
  LiqpayApiBase64,
};
