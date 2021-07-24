
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:sip_ua/sip_ua.dart';

// class SipController extends GetxController implements SipUaHelperListener {
//   static SipController instance = Get.find();
//   RxString wsUriController = "wss://sipswitch.s2switch.com:8089/ws".obs; //102.88.21.66
//   RxString sipUriController = "1000@sipswitch.s2switch.com:5060".obs;
//   RxString displayNameController = "User".obs;
//   RxString passwordController = "Ga#425@#!01".obs;
//   RxString authorizationUserController = "1000".obs;
//   // Map<String, String> _wsExtraHeaders = {
//   //   'Origin': ' https://tryit.jssip.net',
//   //   'Host': 'tryit.jssip.net:10443'
//   // };
//   Rx<RegistrationState> _registerState = RegistrationState().obs;
//   final SIPUAHelper _helper = SIPUAHelper();
//   final box = GetStorage();
//   @override
//   void onReady() {
//     super.onReady();
//     print("==========on Ready Called===================");
//     _registerState.value = _helper.registerState;
//     _helper.addSipUaHelperListener(this);
//     _saveSettings();
//     _handleSave();
//   }

//   @override
//   void onClose() {
//     super.onClose();

//     _helper.removeSipUaHelperListener(this);
//     print("==========on Close Called===================");
//   }

//   void _handleSave() {
//     // if (_wsUriController.value == null) {
//     //   _alert(context, "WebSocket URL");
//     // } else if (_sipUriController.text == null) {
//     //   _alert(context, "SIP URI");
//     // }

//     UaSettings settings = UaSettings();

//     settings.webSocketUrl = wsUriController.value;
//    // settings.webSocketSettings.extraHeaders = _wsExtraHeaders;
//     settings.webSocketSettings.allowBadCertificate = true;
//     //settings.webSocketSettings.userAgent = 'Dart/2.8 (dart:io) for OpenSIPS.';

//     settings.uri = sipUriController.value;
//     settings.authorizationUser = authorizationUserController.value;
//     settings.password = passwordController.value;
//     settings.displayName = displayNameController.value;
//     settings.userAgent = 'Dart SIP Client v1.0.0';
//     settings.dtmfMode = DtmfMode.RFC2833;
//     _helper.start(settings);
//   }

//   // void loadSettings() async {
//   //   wsUriController.value = box.read('ws_uri') ?? 'wss://tryit.jssip.net:10443';
//   //   sipUriController.value =
//   //       box.read('sip_uri') ?? 'hello_flutter@tryit.jssip.net';
//   //   displayNameController.value = box.read('display_name') ?? 'Flutter SIP UA';
//   //   passwordController = box.read('password');
//   //   authorizationUserController = box.read('auth_user');
//   // }

//   void _saveSettings() {
//     box.write('ws_uri', wsUriController.value);
//     box.write('sip_uri', sipUriController.value);
//     box.write('display_name', displayNameController.value);
//     box.write('password', passwordController.value);
//     box.write('auth_user', authorizationUserController.value);
//   }

//   @override
//   void registrationStateChanged(RegistrationState state) {
//     _registerState.value = state;
//   }

//   @override
//   void callStateChanged(Call call, CallState state) {}

//   @override
//   void onNewMessage(SIPMessageRequest msg) {}

//   @override
//   void transportStateChanged(TransportState state) {}
// }
