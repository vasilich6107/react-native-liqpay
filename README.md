
# react-native-liqpay

## Getting started

`$ npm install react-native-liqpay --save`

### Mostly automatic installation

`$ react-native link react-native-liqpay`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-liqpay` and add `RNLiqpay.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNLiqpay.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
    - Add `import com.reactlibrary.RNReactNativeLiqpayPackage;` to the imports at the top of the file
    - Add `new RNReactNativeLiqpayPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
    include ':react-native-liqpay'
    project(':react-native-liqpay').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-liqpay/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
    compile project(':react-native-liqpay')
  	```
4. Insert the following lines inside the dependencies block in `android/app/src/main/AndroidManifest.xml`:
    ```
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
      
    <activity android:name="ua.privatbank.paylibliqpay.CheckoutActivity"/>
    ```
5. Insert the following lines inside the dependencies block in `android/app/src/main/java/com/[yourappname]/MainApplication.java`:
    ```
    return Arrays.<ReactPackage>asList(
        new VectorIconsPackage()
        );
    ```

## Usage
```javascript
  TBD
```
  