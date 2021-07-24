import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class CallRateInfo extends StatefulWidget {
  final String displayName;
  final String phoneCode;
  final String name;
  final String countryCode;

  const CallRateInfo({Key key, this.displayName, this.phoneCode, this.name, this.countryCode}) : super(key: key);


  @override
  State<CallRateInfo> createState() => _CallRateInfoState();
}

class _CallRateInfoState extends State<CallRateInfo> {
  @override
  Widget build(BuildContext context) {
    String flag = widget.countryCode.toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0).codeUnitAt(0) + 127397));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Call Rate",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            LineIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () async {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.displayName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Text(
              flag,
              style: TextStyle(
                fontSize: 52,
              ),
            ),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Text(
              widget.phoneCode,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            "${widget.name} ${widget.phoneCode} rates: 3.5p",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Rates are subject to change. Please view our terms and condition for futher information",
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
