import React from 'react';
import PropTypes from 'prop-types';
import { requireNativeComponent } from 'react-native';

RNLiqpayCheckout = requireNativeComponent('RNLiqpayCheckout', null);

LiqpayCheckout = props => <RNLiqpayCheckout {...props}/>;

LiqpayCheckout.propTypes = {
  params: PropTypes.object.isRequired,
  privateKey: PropTypes.string.isRequired,
  onLiqpaySuccess: PropTypes.func.isRequired,
  onLiqpayError: PropTypes.func.isRequired,
};

module.exports = LiqpayCheckout;