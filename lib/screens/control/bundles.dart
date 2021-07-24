import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:s2_international/controller/app_controller.dart';
import 'package:get/get.dart';

class Bundles extends StatelessWidget {
  final AppController _appController = Get.find();
  Widget addCredit({String country, String amount, String description}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              country,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            AutoSizeText(
              country,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        //right side
        Column(
          children: [
            Text(
              _appController.countryCurrency.value + amount,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AutoSizeText(
                  "Add Credit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget recommendedContainer() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(4, 8),
                blurRadius: 2,
                spreadRadius: 0,
                color: Colors.grey[200],
              )
            ]),
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                LineIcons.patreon,
                color: Colors.blue[900],
                size: 16,
              ),
              label: Text(
                "Recommended",
                style: TextStyle(
                  color: Colors.blue[90],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15),
            Divider(),
            addCredit(
              country: "Nigeria 350",
              description: "350 mins to Nigeria(30 days)",
              amount: "20",
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            addCredit(
              country: "India Unlimited",
              description: "Unlimited mins to India(30 days)",
              amount: "20",
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            addCredit(
              country: "India 0.5p / min",
              description: "0.5p to India(30 days)",
              amount: "10",
            ),
          ],
        ),
      );

  Widget availableContainer() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(4, 8),
                blurRadius: 2,
                spreadRadius: 0,
                color: Colors.grey[200],
              )
            ]),
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(
                LineIcons.accessibleIcon,
                color: Colors.blue[900],
                size: 16,
              ),
              label: Text(
                "Available",
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15),
            Divider(),
            addCredit(
              country: "Bangladesh 1100",
              description: "1100 mins to Bangladesh(30 days)",
              amount: "20",
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            addCredit(
              country: "Ghana 135",
              description: "135 mins to Ghana(30 days)",
              amount: "20",
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            addCredit(
              country: "India 0.5p / min",
              description: "0.5p to India(30 days)",
              amount: "10",
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            addCredit(
              country: "India Unlimited",
              description: "Unlimited mins to India(30 days)",
              amount: "20",
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            addCredit(
              country: "Pakistan 800",
              description: "800 mins to Pakistan(30 days)",
              amount: "20",
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        leading: Icon(
          LineIcons.arrowLeft,
          color: Colors.white,
        ),
        title: Text(
          "Bundles",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              recommendedContainer(),
              SizedBox(height: 20),
              availableContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
