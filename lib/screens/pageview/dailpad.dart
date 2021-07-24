import 'dart:async';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_numpad_widget/flutter_numpad_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:s2_international/constants/asset_path.dart';
import 'package:s2_international/screens/control/bundles.dart';
import 'package:s2_international/screens/control/call_screen.dart';
import 'package:s2_international/screens/control/help_support.dart';
import 'package:s2_international/screens/control/invite_and_earn.dart';
import 'package:s2_international/screens/control/rates_info.dart';
import 'package:s2_international/screens/pageview/wallet.dart';
import 'package:s2_international/screens/widgets/action_button.dart';
import 'package:sip_ua/sip_ua.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Colors.blue[900]
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0050000, size.height * 0.0020000);
    path_0.lineTo(size.width * 0.0025000, size.height * 0.6000000);
    path_0.lineTo(size.width * 0.9975000, size.height * 0.6000000);
    path_0.lineTo(size.width * 0.9962500, size.height * 0.0060000);
    path_0.lineTo(size.width * 0.0050000, size.height * 0.0020000);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DialPadWidget extends StatefulWidget {
  final SIPUAHelper _helper;
  DialPadWidget(this._helper, {Key key}) : super(key: key);
  @override
  _MyDialPadWidget createState() => _MyDialPadWidget();
}

class _MyDialPadWidget extends State<DialPadWidget>
    implements SipUaHelperListener {
  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  String _dest;
  SIPUAHelper get helper => widget._helper;
  TextEditingController _textController;
  //SharedPreferences _preferences;
  final box = GetStorage();

  String receivedMsg;

  @override
  initState() {
    super.initState();
    receivedMsg = "";
    _bindEventListeners();
    _loadSettings();
  }

  void _loadSettings() async {
    //_preferences = await SharedPreferences.getInstance();
    _dest = box.read('dest') ?? '';
    _textController = TextEditingController(text: _dest);
    _textController.text = _dest;

    this.setState(() {});
  }

  void _bindEventListeners() {
    helper.addSipUaHelperListener(this);
  }

  String phoneNumber;

  Widget _handleCall(BuildContext context, [bool voiceonly = false]) {
    var dest = _textController.text;
    if (phoneNumber == null || phoneNumber.isEmpty) {
      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Target is empty.'),
            content: Text('Please enter a SIP URI or username!'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return null;
    }
    helper.call(phoneNumber, voiceonly);
    box.write('dest', dest);
    return null;
  }

  final NumpadController _numpadController =
      NumpadController(format: NumpadFormat.NONE);

  @override
  Widget build(BuildContext context) {
    var WIDTH = MediaQuery.of(context).size.width;
    return AdvancedDrawer(
      backdropColor: Colors.blue[900],
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            CustomPaint(
              size: Size(
                  WIDTH,
                  (WIDTH * 0.875)
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: _handleMenuButtonPressed,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (context, value, child) {
                      return Icon(
                        value.visible ? Icons.clear : Icons.menu,
                        color: Colors.blue[900],
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: WIDTH * 0.275),
              child: Align(
                alignment: Alignment(0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                          child: Text(
                        'Status: ${EnumHelper.getName(helper.registerState.state)}',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      )),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(6.0),
                    //   child: Center(
                    //       child: Text(
                    //     'Received Message: ${receivedMsg}',
                    //     style: TextStyle(fontSize: 14, color: Colors.white),
                    //   )),
                    // ),
                    // DialPad(
                    //     buttonColor: Colors.blue[900],
                    //     buttonTextColor: Colors.white,
                    //     enableDtmf: true,
                    //     outputMask: "(000) 000-0000 0",
                    //     backspaceButtonIconColor: Colors.red,
                    //     makeCall: (number) {
                    //       _handleCall(context, true);
                    //       print("====================");
                    //       print(number);
                    //     }),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: NumpadText(
                        controller: _numpadController,
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    Expanded(
                      child: Numpad(
                        controller: _numpadController,
                        buttonTextSize: 40,
                        textColor: Colors.blue[900],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // _handleCall(context, true);
                        phoneNumber = _numpadController.rawNumber.toString();
                        print(phoneNumber);
                        if (phoneNumber != null || phoneNumber.isNotEmpty) {
                          _handleCall(context, true);
                        } else {
                          Get.snackbar(
                              "Error!", "Input a Phone Number to call");
                        }
                      },
                      child: Container(
                        width: WIDTH * 0.90,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue[900],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "Call",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    logowhite,
                    height: 150,
                  ),
                ),
                // ListTile(
                //   // onTap: () => Get.off(ProfileScreen()),
                //   leading: Icon(LineIcons.user),
                //   title: Text('Select Call Type'),
                // ),
                ListTile(
                  onTap: () => Get.off(InviteAndEarn()),
                  leading: Icon(LineIcons.jediOrder, color: Colors.white),
                  title: Text(
                    'Invite Friends & Earn',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                 ListTile(
                  onTap: () {
                    showCountryList();
                    // return PaymentDialog();
                  },
                  leading: Icon(LineIcons.lineChart, color: Colors.white),
                  title: Text(
                    'Rates',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return PaymentDialog();
                        });
                    // return PaymentDialog();
                  },
                  leading: Icon(LineIcons.creditCard, color: Colors.white),
                  title: Text(
                    'Add Credit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () => Get.to(Bundles()),
                  leading: Icon(LineIcons.newspaper, color: Colors.white),
                  title: Text(
                    'Bundles',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.to(HelpAndSupport());
                  },
                  leading: Icon(
                    LineIcons.cogs,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Help & Support',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(LineIcons.userCircle, color: Colors.white),
                  title: Text(
                    'My Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

    void showCountryList() {
    return showCountryPicker(
      context: context,
      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
      //exclude: <String>['KN', 'MF'],
      //Optional. Shows phone code before the country name.
      showPhoneCode: true,
      onSelect: (Country country) {
        print('Select country: ${country.displayName}');
        Get.off(CallRateInfo(
          displayName: country.displayName,
          phoneCode: country.phoneCode,
          countryCode: country.countryCode,
          name: country.name,
        ));
      },
      // Optional. Sets the theme for the country list picker.
      countryListTheme: CountryListThemeData(
        // Optional. Sets the border radius for the bottomsheet.
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        // Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void registrationStateChanged(RegistrationState state) {
    this.setState(() {});
  }

  @override
  void transportStateChanged(TransportState state) {}

  @override
  void callStateChanged(Call call, CallState callState) {
    if (callState.state == CallStateEnum.CALL_INITIATION) {
      Navigator.pushNamed(context, '/callscreen', arguments: call);
      //Get.to(CallScreenWidget(call));
    }
  }

  @override
  void onNewMessage(SIPMessageRequest msg) {
    //Save the incoming message to DB
    String msgBody = msg.request.body as String;
    setState(() {
      receivedMsg = msgBody;
    });
  }
}
