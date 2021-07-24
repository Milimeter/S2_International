import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:s2_international/screens/pageview/contacts.dart';
import 'package:s2_international/screens/pageview/dailpad.dart';
import 'package:s2_international/screens/pageview/rates.dart';
import 'package:s2_international/screens/pageview/wallet.dart';
import 'package:sip_ua/sip_ua.dart';

class HomeNav extends StatefulWidget {
  final SIPUAHelper _helper;
  HomeNav(this._helper, {Key key}) : super(key: key);
  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  @override
  void initState() {
    super.initState();
    _askPermissions(null);
  }

  Future<void> _askPermissions(String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        //  Navigator.of(context).pushNamed(routeName);
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  int bottomSelectedIndex = 2;

  List<BottomNavigationBarItem> buildNav() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black), label: "Contacts"),
      BottomNavigationBarItem(
          icon: Icon(Icons.timelapse_rounded, color: Colors.black),
          label: "Recents"),
      BottomNavigationBarItem(
          icon: Icon(Icons.dialpad, color: Colors.black), label: "Keypad"),
      BottomNavigationBarItem(
          icon: Icon(Icons.language, color: Colors.black), label: "Rates"),
      BottomNavigationBarItem(
          icon: Icon(Icons.account_balance, color: Colors.black),
          label: "Wallet"),
    ];
  }

  PageController pageController = PageController(
    initialPage: 2,
    keepPage: true,
  );
  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: [
        Contacts(),
        Text(
          'Recent Calls',
        ),
        DialPadWidget(widget._helper),
        WalletScreen(),
      ],
    );
  }

  pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _widgetOptions[selectedIndex],
      // bottomNavigationBar: ConvexAppBar(
      //   backgroundColor: Colors.blue[900],
      //   style: TabStyle.react,
      //   items: [
      //     TabItem(icon: Icons.person, title: "Contacts"),
      //     TabItem(icon: Icons.timelapse_rounded, title: "Recents"),
      //     TabItem(icon: Icons.dialpad, title: "Keypad"),
      //     TabItem(icon: Icons.language, title: "Rates"),
      //     TabItem(icon: Icons.account_balance, title: "Wallet"),
      //   ],
      //   onTap: onItemTapped,
      // ),
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildNav(),
      ),
    );
  }
}
