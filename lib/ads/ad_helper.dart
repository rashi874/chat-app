import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId1 {
    if (Platform.isAndroid) {
      return "ca-app-pub-9884983574056106/7402267045";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId2 {
    if (Platform.isAndroid) {
      return "ca-app-pub-9884983574056106/3906595349";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId3 {
    if (Platform.isAndroid) {
      return "ca-app-pub-9884983574056106/6452829643";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId4 {
    if (Platform.isAndroid) {
      return "ca-app-pub-9884983574056106/2186719913";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId5 {
    if (Platform.isAndroid) {
      return "ca-app-pub-9884983574056106/1326199857";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/2934735716";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9884983574056106/5105437423";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
