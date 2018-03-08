import React from 'react';
import PropTypes from 'prop-types';
import { requireNativeComponent } from 'react-native';

const RNLiqpay = requireNativeComponent('RNLiqpay', null);

const LiqpayCheckout = props => <RNLiqpay type="checkout" {...props} />;

LiqpayCheckout.propTypes = {
  // eslint-disable-next-line react/forbid-prop-types
  params: PropTypes.object.isRequired,
  privateKey: PropTypes.string.isRequired,
  onLiqpaySuccess: PropTypes.func.isRequired,
  onLiqpayError: PropTypes.func.isRequired,
};

module.exports = LiqpayCheckout;
