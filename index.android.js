import PropTypes from 'prop-types';
import {requireNativeComponent, ViewPropTypes} from 'react-native';

var iface = {
  name: 'LiqpayCheckout',
  propTypes: {
    privateKey: PropTypes.string,
    ...ViewPropTypes, // include the default view properties
  },
};

const LiqpayCheckout = requireNativeComponent('RNLiqpay', iface);

module.exports = {
  LiqpayCheckout,
}