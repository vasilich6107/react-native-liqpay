/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react';
import {
  Platform,
  Button,
  StyleSheet,
  Text,
  View,
  PermissionsAndroid,
} from 'react-native';
import {LiqpayCheckout} from 'react-native-liqpay';

const LIQPAY_PUBLIC_KEY = '';
const LIQPAY_PRIVATE_KEY = '';

type Props = {};
export default class App extends Component<Props> {
  params = {
    version: '3',
    public_key: LIQPAY_PUBLIC_KEY,
    action: 'pay',
    currency: 'USD',
    sandbox: '1',
    order_id: Math.floor(1000 + Math.random() * 9000),
    amount: '1',
  };

  state = {
    liqpay: false,
  };

  handlePress = async () => {
    if (Platform.OS === 'android') {
      try {
        const granted = await PermissionsAndroid.request(
          PermissionsAndroid.PERMISSIONS.READ_PHONE_STATE,
        );

        if (granted === PermissionsAndroid.RESULTS.GRANTED) {
          this.setState({
            liqpay: true,
          });
        }
      } catch (e) {
        console.log(e);
      }
    } else {
      this.setState({
        liqpay: true,
      });
    }
  };

  handleSuccess = (event) => {
    console.log(event.nativeEvent);
    this.setState({
      liqpay: false,
    });
  };

  handleError = (event) => {
    console.log(event.nativeEvent);
    this.setState({
      liqpay: false,
    });
  };

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome to Liqpay example!</Text>
        <Text style={styles.instructions}>
          To get started, specify LIQPAY_PUBLIC_KEY and LIQPAY_PRIVATE_KEY in
          App.js
        </Text>
        <Text style={styles.instructions}>
          Press "Pay with Liqpay" button to make a test payment.
        </Text>
        <Button
          onPress={this.handlePress}
          title="Pay with Liqpay"
          color="#841584"
        />
        {this.state.liqpay && (
          <LiqpayCheckout
            privateKey={LIQPAY_PRIVATE_KEY}
            onLiqpayError={this.handleError}
            onLiqpaySuccess={this.handleSuccess}
            params={this.params}
          />
        )}
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
