import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();
  RxString country = "".obs;
  RxString countryCode = "".obs;
  RxString countryCurrency = "".obs;
  RxInt balance = 0.obs;

  @override
  void onReady() {
    super.onReady();
    getCountryName();
  }

  Future<String> getCountryName() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    country.value = first.countryName;
    countryCode.value = first.countryCode;
    var coun = CountryPickerUtils.getCountryByIsoCode(countryCode.value);
    countryCurrency.value = coun.currencyCode;
    // countryCurrency.value =
    //     CurrencyPickerUtils.getCountryByIsoCode(countryCode.value)
    //         .currencyCode
    //         .toString();
    print(country.value + countryCode.value + countryCurrency.value);
    return first.countryName; // this will return country name
  }

  // getCurrency() {
  //   CountryPickerUtils.getDefaultFlagImage(country);
  // }
}
