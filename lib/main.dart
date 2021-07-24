import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:s2_international/constants/asset_path.dart';
import 'package:get/get.dart';
import 'package:s2_international/controller/app_controller.dart';
import 'package:s2_international/controller/sip_controller.dart';
import 'package:s2_international/screens/control/call_screen.dart';
import 'package:s2_international/screens/home_screen.dart';
import 'package:s2_international/screens/pageview/dailpad.dart';
import 'package:sip_ua/sip_ua.dart';

typedef PageContentBuilder = Widget Function(
    [SIPUAHelper helper, Object arguments]);
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AppController());
  final SIPUAHelper _helper = SIPUAHelper();
  Map<String, PageContentBuilder> routes = {
    '/': ([SIPUAHelper helper, Object arguments]) => SplashScreen(helper),
    '/register': ([SIPUAHelper helper, Object arguments]) =>
        SplashScreen(helper),
    '/callscreen': ([SIPUAHelper helper, Object arguments]) =>
        CallScreenWidget(helper, arguments as Call),
    '/home': ([SIPUAHelper helper, Object arguments]) => HomeNav(helper),
  };

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final String name = settings.name;
    final PageContentBuilder pageContentBuilder = routes[name];
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        final Route route = MaterialPageRoute<Widget>(
            builder: (context) =>
                pageContentBuilder(_helper, settings.arguments));
        return route;
      } else {
        final Route route = MaterialPageRoute<Widget>(
            builder: (context) => pageContentBuilder(_helper));
        return route;
      }
    }
    return null;
  }

  GetStorage.init();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    onGenerateRoute: _onGenerateRoute,
    initialRoute: '/',
    supportedLocales: [
      const Locale('en'),
      const Locale('es'),
      const Locale('el'),
      const Locale('nb'),
      const Locale('nn'),
      const Locale('pl'),
      const Locale('pt'),
      const Locale('ru'),
      const Locale('hi'),
      const Locale('ne'),
      const Locale('uk'),
      const Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
      const Locale.fromSubtags(
          languageCode: 'zh',
          scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
    ],
    localizationsDelegates: [
      CountryLocalizations.delegate,
    ],
  ));
}

class SplashScreen extends StatefulWidget {
  final SIPUAHelper _helper;

  const SplashScreen(this._helper, {Key key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    implements SipUaHelperListener {
  RegistrationState _registerState;

  SIPUAHelper get helper => widget._helper;
  navigate() {
    Timer(Duration(seconds: 6), () {
     // Get.off(HomeNav());
     Navigator.pushNamed(context, '/home');
    });
  }

  @override
  void initState() {
    super.initState();
    _registerState = helper.registerState;
    helper.addSipUaHelperListener(this);
    _handleSave();

    navigate();
  }

  @override
  deactivate() {
    super.deactivate();
    helper.removeSipUaHelperListener(this);
  }

  void _handleSave() {
    // if (_wsUriController.text == null) {
    //   _alert(context, "WebSocket URL");
    // } else if (_sipUriController.text == null) {
    //   _alert(context, "SIP URI");
    // }

    UaSettings settings = UaSettings();

    settings.webSocketUrl = "wss://sipswitch.s2switch.com:8089/ws";
    // settings.webSocketSettings.extraHeaders = _wsExtraHeaders;
    settings.webSocketSettings.allowBadCertificate = true;
    //settings.webSocketSettings.userAgent = 'Dart/2.8 (dart:io) for OpenSIPS.';

    settings.uri = "1000@sipswitch.s2switch.com:5060";
    settings.authorizationUser = "1000";
    settings.password = "Ga#425@#!01";
    settings.displayName = "USER";
    settings.userAgent = 'Dart SIP Client v1.0.0';
    settings.dtmfMode = DtmfMode.RFC2833;

    helper.start(settings);
  }

  @override
  Widget build(BuildContext context) {
   // Get.put(SipController());
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Stack(children: [
        Center(
          child: Lottie.asset(network),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "S2 International",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void callStateChanged(Call call, CallState state) {
    // TODO: implement callStateChanged
  }

  @override
  void onNewMessage(SIPMessageRequest msg) {
    // TODO: implement onNewMessage
  }

  @override
  void registrationStateChanged(RegistrationState state) {
    // TODO: implement registrationStateChanged
  }

  @override
  void transportStateChanged(TransportState state) {
    // TODO: implement transportStateChanged
  }
}
