import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';
import 'package:rave_flutter/rave_flutter.dart';
import 'package:s2_international/constants/asset_path.dart';
import 'package:s2_international/controller/app_controller.dart';
import 'package:s2_international/screens/control/apple_google_pay.dart';
import 'package:s2_international/screens/control/bundles.dart';
import 'package:s2_international/screens/control/help_support.dart';
import 'package:s2_international/screens/control/invite_and_earn.dart';
import 'package:s2_international/screens/control/paypal_payment.dart';
import 'package:s2_international/screens/control/paystack.dart';
import 'package:s2_international/screens/control/rates_info.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final AppController _appController = Get.find();
  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  // Pay _pay = Pay.withAssets(["google_pay.json", "apple_pay.json"]);
  // List<PayProvider> availableProviders = [];

  @override
  Widget build(BuildContext context) {
    // PayProvider.values.forEach((e) async {
    //   bool canPay = await _pay.userCanPay(e);
    //   if (canPay) availableProviders.add(e);
    // });
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
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text(
            'Account',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
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
        body: Obx(
          () => Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CustomPaint(
                  size: Size(
                      WIDTH,
                      (WIDTH * 1.525)
                          .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: RPSCustomPainter(),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(logoblue),
                    Text(
                      "S2 International",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "${_appController.countryCurrency.value}${_appController.balance.value}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return PaymentDialog();
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(18),
                          width: WIDTH,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.blue[900],
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[200],
                                  offset: Offset(4, 8),
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ]),
                          child: Center(
                            child: Text(
                              "Add Credit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Colors.blue[50]
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.0040000);
    path_0.quadraticBezierTo(size.width * 0.4931250, size.height * 0.1015000,
        size.width * 0.5000000, size.height * 0.4980000);
    path_0.quadraticBezierTo(size.width * 0.5009375, size.height * 0.9030000,
        size.width * 0.0012500, size.height * 0.9980000);
    path_0.cubicTo(
        size.width * 0.0015625,
        size.height * 0.7485000,
        size.width * -0.0034375,
        size.height * 0.7505000,
        0,
        size.height * 0.0040000);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class PaymentDialog extends StatefulWidget {
  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var autoValidate = false;
  bool acceptCardPayment = true;
  bool acceptAccountPayment = true;
  bool acceptMpesaPayment = false;
  bool shouldDisplayFee = true;
  bool acceptAchPayments = false;
  bool acceptGhMMPayments = false;
  bool acceptUgMMPayments = false;
  bool acceptMMFrancophonePayments = false;
  bool live = false;
  bool preAuthCharge = false;
  bool addSubAccounts = false;
  List<SubAccount> subAccounts = [];
  String publicKey = "FLWPUBK-1b4cee87cfe7d211d207c9a93c09a11a-X";
  String encryptionKey = "eff9e6b0e81de400406d13b7";
  String txRef = "GTEL-${DateTime.now().toString()}";
  String orderRef = "GTEL-${DateTime.now().toString()}";
  String narration = "Payment on GTEL";
  String roomId = "";
  AppController _appController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  void startPayment() async {
    var initializer = RavePayInitializer(
        amount: 100,
        publicKey: publicKey,
        encryptionKey: encryptionKey,
        subAccounts: subAccounts.isEmpty ? null : null)
      ..country = "NG"
      ..currency = "NGN"
      ..email = "gtel@gmail.com"
      ..fName = "GTEL"
      ..lName = "LIMITED"
      ..narration = narration ?? ''
      ..txRef = txRef
      ..acceptMpesaPayments = acceptMpesaPayment
      ..acceptAccountPayments = acceptAccountPayment
      ..acceptCardPayments = acceptCardPayment
      ..acceptAchPayments = acceptAchPayments
      ..acceptGHMobileMoneyPayments = acceptGhMMPayments
      ..acceptUgMobileMoneyPayments = acceptUgMMPayments
      ..acceptMobileMoneyFrancophoneAfricaPayments = acceptMMFrancophonePayments
      ..displayEmail = true
      ..displayAmount = true
      ..staging = false
      ..isPreAuth = preAuthCharge
      ..displayFee = shouldDisplayFee
      ..companyName = Text("GTEL");

    RaveResult response = await RavePayManager()
        .prompt(context: context, initializer: initializer);
    print(response);
    if (response != null) {
      // var uniqueId = getRandomString(5);
      print(
          "-------------------------response not null-----------------------");
      print(response?.message);

      Get.snackbar(
        "GTEL!",
        "${response?.message}. Please wait a couple of seconds before leaving this page",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        duration: Duration(seconds: 5),
      );
    } else if (response.status == RaveStatus.cancelled) {
      Get.snackbar(
        "GTEL!",
        response?.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        duration: Duration(seconds: 5),
      );
    } else if (response.status == RaveStatus.error) {
      Get.snackbar(
        "GTEL!",
        response?.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        duration: Duration(seconds: 5),
      );
    } else {
      Get.snackbar(
        "Error!",
        "No Response",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        duration: Duration(seconds: 5),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        "Select Payment",
        style: TextStyle(color: Colors.black),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset(
          //   'assets/room_created_vector.png',
          // ),
          Platform.isIOS
              ? TextButton(
                  onPressed: () {
                    Get.off(AppleGooglePay());
                  },
                  child: Text(
                    "Apple Pay",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : const SizedBox(
                  height: 20,
                ),
          TextButton(
            onPressed: () {
              Get.off(AppleGooglePay());
            },
            child: Text(
              "Google Pay",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          TextButton(
            onPressed: () => Get.to(
              PaypalPayment(
                onFinish: (number) async {
                  // payment done
                  print('order id: ' + number);
                },
                currency: _appController.countryCurrency.value.toString(),
              ),
            ),
            child: Text(
              "PayPal",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          TextButton(
            onPressed: () => Get.to(Paystack()),
            child: Text(
              "PayStack",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          TextButton(
            onPressed: () => startPayment(),
            child: Text(
              "Flutterwave",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          TextButton(
            onPressed: () {},
            child: Text(
              "InterSwitch",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
